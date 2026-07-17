# DA Lifecycle Atlas content IA

## Purpose

Wave 6 second-site proof for the da-cli 0.6.0 cut. The canonical experience is
DA-authored content decorated by repo-native EDS blocks. The standalone
`/visuals/helix-5-to-helix-6.html` file is retained as the first visual design
reference, not the canonical explainer route.

## Routes

| Route | Role | Primary blocks |
|---|---|---|
| `/` | Atlas orientation and second-site thesis | atlas-hero, atlas-grid, atlas-compare |
| `/explainers/helix-5-to-helix-6` | beginner H5→H6 field guide | atlas-hero, atlas-compare, atlas-flow, atlas-grid, table, accordion |
| `/plans` | lifecycle and compatibility plans | atlas-hero, atlas-flow, atlas-grid |
| `/learnings` | append-only build findings | atlas-hero, table |
| `/provenance` | operational proof and agent-engagement framing | atlas-hero, atlas-grid |
| `/nav` | site navigation | header fragment contract |
| `/footer` | site footer | footer fragment contract |

## Block contracts

### atlas-hero

One row. Cell 1 is the authored kicker, H1, lead, and optional CTA. Cell 2 is
optional media. The block adds layout only; all narrative remains in DA.

### atlas-compare

Each row has exactly two cells. They are rendered as old/new or
assertion/proof panels with an inserted visual connector.

### atlas-flow

One row per step. Cells: label, title/body, code/detail. Connectors are code-owned
and decorative.

### atlas-grid

One row per card. Authored cells remain ordered card regions. Variants such as
`readiness` and `three-up` alter layout, not content.

### table and accordion

Standard semantic transforms. Table row 1 is the header. Accordion rows are
term/definition pairs.

## Ownership boundary

- DA: words, headings, links, lists, table cells, glossary, metadata, page order.
- Git: layout, tokens, connectors, responsive behavior, accessibility, interactions.
- Riverboat: reviewed outside-tool coordination only; never required to reconstruct the site.
