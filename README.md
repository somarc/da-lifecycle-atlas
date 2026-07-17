# DA Lifecycle Atlas

Visual field guides for the DA CLI, Edge Delivery Services control plane, and
the platform changes that operators need to understand.

## Environments
- Preview: https://main--da-lifecycle-atlas--somarc.aem.page/
- Live: https://main--da-lifecycle-atlas--somarc.aem.live/

## Local development

```sh
npm install
npx -y @adobe/aem-cli up --no-open --forward-browser-logs --html-folder drafts
```

The initial local route is `/helix-5-to-helix-6`.

## Visual architecture

- `visuals/` contains standalone, self-contained visual explainers.
- `blocks/atlas-visual/` embeds a same-origin visual in an authored EDS page
  and resizes it from a constrained `postMessage` contract.
- `drafts/` contains local source-page fixtures that mirror the CMS block
  contract. They are development fixtures, not the production content source.

## Documentation

Before using the aem-boilerplate, we recommand you to go through the documentation on https://www.aem.live/docs/ and more specifically:
1. [Developer Tutorial](https://www.aem.live/developer/tutorial)
2. [The Anatomy of a Project](https://www.aem.live/developer/anatomy-of-a-project)
3. [Web Performance](https://www.aem.live/developer/keeping-it-100)
4. [Markup, Sections, Blocks, and Auto Blocking](https://www.aem.live/developer/markup-sections-blocks)

## Installation

```sh
npm i
```

## Linting

```sh
npm run lint
```

## Local development

1. Create a new repository based on the `aem-boilerplate` template
1. Add the [AEM Code Sync GitHub App](https://github.com/apps/aem-code-sync) to the repository
1. Install the [AEM CLI](https://github.com/adobe/helix-cli): `npm install -g @adobe/aem-cli`
1. Start AEM Proxy: `aem up` (opens your browser at `http://localhost:3000`)
1. Open the `{repo}` directory in your favorite IDE and start coding :)
