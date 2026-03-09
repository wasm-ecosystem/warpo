# Feature: VitePress Mermaid Diagram Rendering

## Overview

Enable Mermaid diagram rendering in this repository's VitePress docs by adapting the `mermaid-markdown-all.ts` approach from the Mermaid project for `warpo` docs. The goal is to make existing and future ````mermaid` code fences render as diagrams in docs pages, while keeping scope intentionally small (`mermaid` fences only, no additional custom fence types).

## Success Criteria

- [ ] All tasks complete
- [ ] All tests passing
- [ ] Build succeeds
- [ ] No blockers

## Tasks

### Task-001: Add Mermaid Docs Runtime Foundation

**Priority**: High
**Estimated Iterations**: 1-2

**Acceptance Criteria**:

- [ ] Add Mermaid runtime dependency needed for client-side diagram rendering in VitePress docs.
- [ ] Add a docs-side client entry (`theme/index.ts`) that registers Mermaid rendering component(s).
- [ ] Keep implementation compatible with current VitePress setup in `docs/.vitepress/config.ts`.
- [ ] No existing docs navigation/locales behavior regresses.

**Verification**:

```bash
npm run docs:build
```

### Task-002: Implement Markdown Fence Transform For Mermaid

**Priority**: High
**Estimated Iterations**: 2-3

**Acceptance Criteria**:

- [ ] Add a markdown-it fence override (similar pattern to Mermaid's `mermaid-markdown-all.ts`) in `docs/.vitepress`.
- [ ] Transform only `mermaid` fences into a Vue Mermaid-renderer component tag.
- [ ] Preserve default fence rendering for all non-mermaid fences.
- [ ] Ensure Mermaid graph content is safely encoded before embedding in HTML attributes.
- [ ] Include succinct inline comments only where logic is not obvious.

**Verification**:

```bash
npm run docs:build
```

### Task-003: Wire VitePress Config And Validate Existing Mermaid Docs

**Priority**: Medium
**Estimated Iterations**: 1-2

**Acceptance Criteria**:

- [ ] Wire the markdown transform into `defineConfig` via VitePress `markdown` config hook.
- [ ] Confirm Mermaid blocks in `docs/tech/lower/gc.md` render without markdown fallback.
- [ ] Ensure docs dev server starts and renders Mermaid diagrams in-browser.
- [ ] Keep change surface minimal and localized to docs tooling.

**Verification**:

```bash
# Build check
npm run docs:build

# Manual render check
npm run docs:dev
# Open the page containing Mermaid fences and confirm diagram render
```

### Task-004: Repository Quality Validation

**Priority**: Medium
**Estimated Iterations**: 1

**Acceptance Criteria**:

- [ ] Run repository build as required by project instructions.
- [ ] Run repository tests for non-WASM-output-impacting docs/tooling changes.
- [ ] Ensure formatting/linting is not regressed by touched files.
- [ ] Capture any follow-up issues in progress notes.

**Verification**:

```bash
npm run build
npm run test
```

## Technical Constraints

- Language: TypeScript + Vue (VitePress docs customization)
- Framework: VitePress (`^2.0.0-alpha.15` in this repo)
- Testing: `npm run docs:build` for docs integration, plus repository-level `npm run build` and `npm run test`
- Style: Existing repo TypeScript style; keep docs customization concise and maintainable

## Architecture Notes

- Design pattern: Markdown renderer extension with fence rule override and fallback to default renderer
- Key libraries: `vitepress`, `markdown-it` renderer API, `mermaid` runtime
- Data flow: Markdown fence token (`mermaid`) -> custom fence renderer -> Vue component output -> client-side Mermaid render in docs page

## Out of Scope

- Supporting custom fence aliases like `mermaid-example`
- Porting non-mermaid fence behaviors (`warning`, `note`, `regexp`, `jison`)
- Converting diagrams to static SVG at build time
- Broader docs theme redesign or navigation restructuring
