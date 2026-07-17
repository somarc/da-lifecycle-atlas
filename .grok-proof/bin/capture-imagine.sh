#!/usr/bin/env bash
set -euo pipefail
umask 077

repo="$(git rev-parse --show-toplevel)"
cd "$repo"

proof_root='.grok-proof'
yaml="$proof_root/riverboat-imagine.yaml"
prompt_file="$proof_root/prompts/helix-transition.txt"
self="$proof_root/bin/capture-imagine.sh"
grok_link="$HOME/.grok/bin/grok"

for path in "$yaml" "$prompt_file" "$self"; do
  git ls-files --error-unmatch -- "$path" >/dev/null
  git diff --quiet -- "$path"
  git diff --cached --quiet -- "$path"
done

test -x "$grok_link"
test -s "$prompt_file"

tmp="$(mktemp -d "${TMPDIR:-/tmp}/atlas-grok-proof.XXXXXX")"
trap 'rm -rf "$tmp"' EXIT

grok_bin="$(python3 - "$grok_link" <<'PY'
import os
import sys
print(os.path.realpath(sys.argv[1]))
PY
)"

grok_version="$("$grok_bin" --version)"
repo_head="$(git rev-parse HEAD)"
prompt_sha="$(shasum -a 256 "$prompt_file" | awk '{print $1}')"
wrapper_sha="$(shasum -a 256 "$self" | awk '{print $1}')"
yaml_sha="$(shasum -a 256 "$yaml" | awk '{print $1}')"
grok_sha="$(shasum -a 256 "$grok_bin" | awk '{print $1}')"

env -i \
  HOME="$HOME" \
  PATH='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin' \
  LANG='C' \
  "$grok_bin" \
    --cwd "$repo" \
    -p "$(cat "$prompt_file")" \
    --verbatim \
    --output-format json \
    --tools image_gen \
    --no-subagents \
    --no-memory \
    --disable-web-search \
    --max-turns 2 \
    --always-approve \
    > "$tmp/grok-output.json"

session_id="$(python3 - "$tmp/grok-output.json" <<'PY'
import json
import sys
result = json.load(open(sys.argv[1], encoding='utf-8'))
session = result.get('sessionId')
if not isinstance(session, str) or not session:
    raise SystemExit('Grok output did not contain sessionId')
print(session)
PY
)"

encoded_cwd="$(python3 - "$repo" <<'PY'
import sys
import urllib.parse
print(urllib.parse.quote(sys.argv[1], safe=''))
PY
)"
session_dir="$HOME/.grok/sessions/$encoded_cwd/$session_id"
image_count="$(find "$session_dir/images" -maxdepth 1 -type f | wc -l | tr -d ' ')"
test "$image_count" -eq 1

source_image="$(find "$session_dir/images" -maxdepth 1 -type f -print | sort | head -1)"
image_name="$(basename "$source_image")"
evidence_dir="$proof_root/evidence/$session_id"
test ! -e "$evidence_dir"
mkdir -p "$evidence_dir"
cp -p "$source_image" "$evidence_dir/$image_name"
cp "$tmp/grok-output.json" "$evidence_dir/grok-output.json"

image_sha="$(shasum -a 256 "$evidence_dir/$image_name" | awk '{print $1}')"
output_sha="$(shasum -a 256 "$evidence_dir/grok-output.json" | awk '{print $1}')"
mime="$(file -b --mime-type "$evidence_dir/$image_name")"
dimensions="$(sips -g pixelWidth -g pixelHeight "$evidence_dir/$image_name" 2>/dev/null | tr '\n' ' ' | sed 's/  */ /g')"

python3 - "$evidence_dir/run.json" <<PY
import json
from datetime import datetime, timezone

record = {
  'schema': 'atlas-grok-imagine-evidence/v1',
  'claim': {
    'type': 'recorded-single-generation',
    'notClaimed': ['deterministic regeneration', 'byte-identical replay', 'automatic visual acceptance'],
  },
  'recordedAt': datetime.now(timezone.utc).isoformat().replace('+00:00', 'Z'),
  'repository': {'head': '$repo_head'},
  'grok': {'version': '$grok_version', 'binarySha256': '$grok_sha'},
  'contractHashes': {'yaml': '$yaml_sha', 'wrapper': '$wrapper_sha', 'prompt': '$prompt_sha'},
  'invocation': {
    'mode': 'headless /imagine',
    'toolAllowlist': ['image_gen'],
    'memory': 'disabled',
    'subagents': 'disabled',
    'webSearch': 'disabled',
    'credentials': 'not supplied, read, printed, or copied by wrapper',
  },
  'result': {
    'sessionId': '$session_id',
    'evidenceImage': '$image_name',
    'mimeType': '$mime',
    'dimensionsProbe': '$dimensions',
    'imageSha256': '$image_sha',
    'headlessOutputSha256': '$output_sha',
  },
  'review': {'status': 'pending-human-review'},
}
json.dump(record, open('$evidence_dir/run.json', 'w', encoding='utf-8'), indent=2, sort_keys=True)
print()
PY

(
  cd "$evidence_dir"
  shasum -a 256 "$image_name" grok-output.json run.json > SHA256SUMS
)

printf 'Evidence captured: %s\n' "$evidence_dir"
