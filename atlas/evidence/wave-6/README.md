# Wave 6 — second-site-from-scratch evidence

Target: `somarc/da-lifecycle-atlas`  
Code branch: `feature-wave-6-full-da-site`  
Canonical CLI: `/Users/mhess/aem/aem-code/da/da-cli/bin/da.js` (`0.5.1`, source tree)

## Observable transitions

1. **Auth refusal contained before first write**
   - `00-auth-expired.json`
   - `01-status-baseline.json`
   - Invalid cached IMS state was reported with executable recovery. No DA write ran.

2. **Branch addressing corrected before construction**
   - The initial slash-containing branch triggered da-cli's EDS-ref warning.
   - It was renamed to `feature-wave-6-full-da-site`.
   - The feature code asset returned 200 before content mutation.

3. **Constrained DA construct completed**
   - `02-construct-plan.json`
   - `03-construct-run.json`
   - `03-construct-run.stderr.txt`
   - Initial construct: 17/17 steps completed. After the approved media input joined the canonical pipeline, the final current construct completed 18/18, including binary upload, seven content writes/previews, contracts, freshness, and code proof (`27`–`30` evidence files).

4. **Content and block contracts proved**
   - `04-content-tree.json` — seven canonical DA documents.
   - `05-audit-full.json` — Helix explainer: zero errors, zero warnings.
   - `06-contracts.json` — all authored blocks have public JS/CSS; `missing=[]`.
   - `10-design-audit.json` — zero error-severity findings.

5. **Preview and live delivery proved**
   - `12-publish-pages.json` — seven pages promoted.
   - `13-freshness-live.json` — initial seven-page live freshness proof.
   - `14-live-sha256.txt` — public plain-HTML hashes.
   - `22-final-freshness.json` — all seven canonical pages fresh after media promotion.

6. **Riverboat + Grok Imagine trust boundary proved**
   - `08-riverboat-imagine-plan.json` — unsafe mode explicit, one shell step, no ungated shell steps.
   - `09-riverboat-imagine-run.json` — explicitly approved step completed; unsafe warning retained.
   - `.grok-proof/evidence/019f6e1e-2a05-7201-b63b-2da6d115d22b/` — prompt/YAML/wrapper hashes, Grok version and binary hash, headless output, image hash, and non-determinism non-claims.
   - Human review promoted the exact 1280×720 output to `media/atlas/helix-transition.jpg`.

7. **Binary media path proved**
   - `17-media-put.json` — committed DA binary upload.
   - `18-index-put-with-media.json`, `19-explainer-put-with-media.json` — authored references accepted after media existed.
   - `20-media-pages-preview.json`, `21-media-pages-publish.json` — both pages activated and promoted.
   - Browser proof: rendered image resolves to optimized `media_<hash>.jpg?width=750&format=webply&optimize=medium`, natural size 750×422, `about:error=false`, all block statuses loaded.

8. **Learnings stayed current**
   - `23-learnings-put.json`, `24-learnings-preview.json`, `25-learnings-publish.json`
   - The public record now names the auth containment, static-to-DA correction, branch-ref correction, and Riverboat Imagine proof.

## Honest residue

- `preview pages`, `publish pages`, `audit contracts`, and `site freshness` still emit legacy bare arrays/objects rather than the shared agent envelope on their success paths. This was already tracked by the f017 migration; the evidence retains the exact shapes rather than rewriting them.
- Direct unauthenticated GET of the DA source-media URL returns 401, while the preview/live static path and rendered optimized derivative are publicly 200. The user-facing delivery contract is proven through the rendered page.
- The standalone `/visuals/helix-5-to-helix-6.html` remains as the first design reference, but the canonical `/explainers/helix-5-to-helix-6` route is ordinary DA-authored content decorated by repo-native blocks.

## Cut interpretation

This closes the **second-site-from-scratch** and **credentialed external integration** portions of Wave 6 with public evidence. It does not by itself declare every Wave 6 condition or the 0.6.0 gate complete; the source test plan remains authoritative.
