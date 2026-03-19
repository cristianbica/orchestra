# Plan: Add Approved Generic Overlays To Template Source

Date: 2026-03-19

## Goal
- Add the approved generic overlay files to `src/ai/overlays/` using the existing overlay file shape.
- Keep the change template-safe and minimal.
- Update only source documentation that would become inaccurate because it explicitly presents the built-in overlay set.

## Non-goals
- No changes to agent prompts, workflow defaults, or overlay-selection logic.
- No installer changes.
- No edits under `.ai/**` other than this plan artifact.
- No broad documentation sweep.

## Scope + assumptions
- `install.sh` copies the full `src/ai` tree into downstream `.ai/`, so adding files under `src/ai/overlays/` is sufficient for distribution.
- Existing overlays in `src/ai/overlays/` establish the reusable content pattern: `Purpose`, `When to apply`, `Output focus`, `Decision prompts`, and `Quality checks`.
- The only source docs that clearly become stale from this change are the files that explicitly enumerate the built-in overlays today.
- The approved overlay set is fixed to these new names: `webdev`, `frontend`, `api`, `integration`, `devops`, `performance`, `testing`, `review`, `payments`, `privacy`, `dx`, `i18n`, `reliability`, `mobile`.

## Overlay files to create
- `src/ai/overlays/webdev.md` — server-rendered or MVC-style web app concerns such as routing, controllers, forms, sessions, and jobs
- `src/ai/overlays/frontend.md` — view-layer concerns in web apps: HTML/templates, CSS, browser-side JS, rendering, and interaction behavior
- `src/ai/overlays/api.md` — API contracts, validation, payload shape, compatibility, and serialization
- `src/ai/overlays/integration.md` — third-party integrations and external API/service connection concerns
- `src/ai/overlays/devops.md` — deployment and post-deployment concerns such as environments, rollout, rollback, runtime operations, and observability
- `src/ai/overlays/performance.md` — coding with performance in mind: query cost, render cost, caching, throughput, and efficiency
- `src/ai/overlays/testing.md` — testability, regression coverage, verification strategy, and critical-path checks
- `src/ai/overlays/review.md` — code review focus on regressions, maintainability, risk, and missing validation
- `src/ai/overlays/payments.md` — billing, money movement, reconciliation, transactional correctness, and failure handling
- `src/ai/overlays/privacy.md` — personal data handling, exposure minimization, retention, and privacy/compliance-sensitive behavior
- `src/ai/overlays/dx.md` — developer experience, maintainability, tooling clarity, and local workflow ergonomics
- `src/ai/overlays/i18n.md` — localization, translation safety, locale-aware formatting, and multilingual UX
- `src/ai/overlays/reliability.md` — failure handling, retries, idempotency, graceful degradation, and recovery behavior
- `src/ai/overlays/mobile.md` — native and mobile-shell app concerns such as lifecycle, navigation, device constraints, platform behavior, and web-to-native wrappers

Not creating:
- `compliance.md` — intentionally omitted because compliance-sensitive concerns are merged into `privacy`

## Evidence summary
- `src/ai/overlays/` currently contains only `data.md`, `security.md`, `system.md`, `ux.md`, and `value.md`.
- `install.sh` copies directories from `src/ai/*` into downstream `.ai/` without special handling for overlays, so new overlay files should install automatically.
- `src/ai/HUMANS.md` and `src/ai/MEMORY.md` explicitly describe the current built-in overlay set; `src/ai/docs/features/overlays.md` does not exist in template source.

## Critical files
- `src/ai/overlays/`
- `src/ai/HUMANS.md`
- `src/ai/MEMORY.md`
- `install.sh` (read-only verification reference only; no planned edits)

## Reuse first
- Reuse the structure and tone of:
  - `src/ai/overlays/value.md`
  - `src/ai/overlays/system.md`
  - `src/ai/overlays/ux.md`
  - `src/ai/overlays/data.md`
  - `src/ai/overlays/security.md`
- Keep each new overlay concise and generic, using the user-provided definitions as the scope boundary.

## Steps
1. Add one new markdown file per approved overlay under `src/ai/overlays/`.
2. For each new file, mirror the established overlay format and keep the guidance generic enough for distributed template use.
3. Do not modify existing overlay defaults in agents or workflows unless implementation uncovers a hard contradiction; adding files alone is the intended primary change.
4. Update only the source docs that explicitly enumerate the built-in overlays so they no longer imply there are only five.
5. Leave installer code unchanged unless verification proves new overlay files are not copied into downstream `.ai/overlays/`.

## Verification
- Confirm the new files exist in `src/ai/overlays/`:
  - `ls src/ai/overlays`
- Check for stale source references that still imply the old built-in set:
  - `rg -n "Current overlays:|Built-in overlays:" src/ai`
- Validate install behavior without changing installer logic:
  - `tmpdir=$(mktemp -d)`
  - `cd "$tmpdir"`
  - `SRC_DIR=/home/cristi/Projects/bcd/ai bash /home/cristi/Projects/bcd/ai/install.sh copilot`
  - `ls .ai/overlays`

## Doc impact
- `updated`
- Update only:
  - `src/ai/HUMANS.md`
  - `src/ai/MEMORY.md`
- Defer any repo-local `.ai/**` doc synchronization unless separately requested, because the approved implementation target is `src/**`.

## Rollback
- Remove the added files from `src/ai/overlays/`.
- Revert the minimal source doc updates.
- Re-run the verification commands to confirm downstream installs return to the previous overlay set.
