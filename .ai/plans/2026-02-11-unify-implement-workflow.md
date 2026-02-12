# Plan: Unify implement workflows (implement-feature + fix-bug) into `implement`

Date: 2026-02-11

## Goal
- Introduce a single workflow named `implement` that covers: feature implementation, bug fixes, and the no-plan trivial-change path.
- Preserve existing user-facing shortcuts/phrases (“implement feature”, “fix bug”, “trivial change”), while routing them through `implement`.
- Expand shortcut phrase matching to cover natural phrasing like “fix this bug …” and “implement this …”.
- Update investigate → implement handoff guidance so Researcher reports promote into `implement`.

## Non-goals
- Changing the overall 6-role agent model, delegation strategy, or adding new workflows beyond `implement`.
- Adding new tooling, scripts, or runtime checks (repo is Markdown-only).
- Broad repo-wide rewrite of every reference to `implement-feature` / `fix-bug` (only the necessary routing/gate/handoff docs).

## Scope + assumptions
- Canonical sources are under `src/ai/**`; this repo’s `.ai/**` is a local mirror and `.ai/workflows/**` must remain unedited (forbidden by `.ai/docs/overview.md`).
- Shortcut detection remains case-insensitive substring matching (no regex), but we will add an explicit priority order to avoid collisions.
- Default mode selection:
  - “fix bug” / “fix this bug” => `implement` in **bug** mode.
  - “implement feature” / “implement this” / “implement:” => `implement` in **feature** mode.
  - “trivial change” / “implement trivial change” => `implement` in **trivial** mode.

## Proposed workflow definition: `implement`

### Location
- Add: `src/ai/workflows/implement.md` (new canonical workflow).

### Modes
- **Feature mode** (replaces `implement-feature`)
  - Intake (Conductor):
    1) Feature summary + top 3 acceptance criteria
    2) References (similar flow/files)
    3) Constraints (hard limits)
  - Gate: requires an explicitly approved plan artifact (inline or plan file).
  - Delegation: Conductor → Architect (plan) → user approval → Builder (implement) → Archivist (docs if needed) → Inspector (review).

- **Bug mode** (replaces `fix-bug`)
  - Intake (Conductor):
    1) Expected vs actual
    2) Minimal repro + environment
    3) Evidence (logs/trace/screenshot)
  - Gate: requires an explicitly approved plan artifact (inline or plan file).
  - Delegation: same as feature mode.

- **Trivial mode** (incorporates `trivial-change` behavior)
  - Intake (Conductor, only if unclear):
    1) Confirm scope is strictly formatting/typos/docs wording only (no behavior change)
    2) Target files/sections
    3) Constraints/terminology to preserve
  - Gate: **no plan artifact required**.
  - Delegation: Conductor → Builder (minimal change) → Inspector spot-check.
  - Hard constraint: If not obviously trivial, switch to `implement` bug/feature mode (plan required).

### Gates (plan/no-plan)
- The only no-plan path for implementation is: `implement` in **trivial** mode.
- All other `implement` modes require an explicitly approved plan artifact.

## Shortcut detection changes (src/ai/agents/conductor.md)

### Add/route shortcuts to `implement`
- Replace “Shortcut 3: Implement Feature” behavior to route to `implement` (**feature** mode).
- Replace “Shortcut 6: Fix Bug” behavior to route to `implement` (**bug** mode).
- Replace “Shortcut 5: Trivial Change” behavior to route to `implement` (**trivial** mode) (no plan).
- Add new phrases:
  - Bug mode: “fix this bug” (also keep “fix bug”)
  - Feature mode: “implement this” and “implement:” (also keep “implement feature”)
  - Trivial mode: “implement trivial change” (to avoid multi-shortcut collisions)

### Priority rules (avoid collisions)
- Change detection from “collect all matches; if multiple, ask user” to:
  - Maintain an **ordered** shortcut list and select the **first** matching shortcut.
  - Only ask user to choose when **two different shortcuts of equal specificity** match (rare under ordered matching).
- Recommended priority (top wins):
  1) bootstrap
  2) refresh context
  3) implement trivial change  (routes to `implement` trivial)
  4) trivial change           (routes to `implement` trivial)
  5) fix this bug             (routes to `implement` bug)
  6) fix bug                  (routes to `implement` bug)
  7) implement feature        (routes to `implement` feature)
  8) implement this           (routes to `implement` feature)
  9) implement:               (routes to `implement` feature)
  10) document
  11) refactor

Rationale: more specific phrases win; “implement trivial change” prevents the old “multiple shortcuts detected” branch when both “implement …” and “trivial change” appear.

## Plan gate invariant updates

### Conductor (src/ai/agents/conductor.md)
- Update the hard gate rule:
  - From: “allow implementation only if trivial-change OR approved plan”
  - To: “allow implementation only if `implement` is in trivial mode OR an explicitly approved plan artifact exists”.
- Update Step 3) Plan Gate:
  - From: “skip only for trivial-change”
  - To: “skip only for `implement` trivial mode”.

### Builder (src/ai/agents/builder.md)
- Update rules:
  - From: “Exception: the `trivial-change` workflow requires no plan.”
  - To: “Exception: `implement` in trivial mode requires no plan.”
- Add a short clarification:
  - If routed via legacy alias workflows (see below), Builder should still apply the same invariant: only the trivial-mode path skips plan.

## Investigate → implement handoff updates

### Workflow handoff list (src/ai/workflows/investigate.md)
- Change promotion rule handoff targets:
  - Replace: `fix-bug` | `implement-feature` | `refactor` | `document`
  - With: `implement` | `refactor` | `document`
- Update Investigation Report template “Handoff” section:
  - Next workflow: `implement` | `refactor` | `document`
  - If `implement`: specify mode = bug | feature (and include a tight proposed scope + verification plan).

### Researcher guidance (src/ai/agents/researcher.md)
- Update the recommended next workflow list:
  - Replace: `fix-bug` / `implement-feature` / `refactor` / `document`
  - With: `implement` / `refactor` / `document`.
- Update handoff instructions to include `implement` mode selection (bug vs feature).

## What to do with existing workflow files in src/ai/workflows

### Recommendation: keep as stubs/aliases (do not delete)
- Keep these files for backward compatibility and for “existing shortcuts still work”:
  - `src/ai/workflows/implement-feature.md`
  - `src/ai/workflows/fix-bug.md`
  - `src/ai/workflows/trivial-change.md`
- Convert each into a short alias stub:
  - Mark as “Deprecated: use `implement` workflow”
  - Point to `src/ai/workflows/implement.md` and specify mode mapping:
    - implement-feature => implement(feature)
    - fix-bug => implement(bug)
    - trivial-change => implement(trivial)

Rationale: avoids breaking external references while centralizing the actual process in `implement`.

## Steps
1. Add `src/ai/workflows/implement.md` with the three modes and gating rules.
2. Update `src/ai/agents/conductor.md`:
   - Add new shortcut phrases (“fix this bug”, “implement this”, “implement:”, “implement trivial change”).
   - Route legacy shortcuts to `implement` modes.
   - Implement ordered priority matching rules (doc-level specification).
   - Update the plan gate invariant to reference `implement` trivial mode.
3. Update `src/ai/agents/builder.md` to align the no-plan exception with `implement` trivial mode.
4. Update `src/ai/workflows/investigate.md` and `src/ai/agents/researcher.md` to hand off to `implement` (with mode).
5. Update legacy workflow files under `src/ai/workflows/` into alias stubs pointing to `implement`.
6. Mirror implications (explicitly do NOT edit forbidden paths):
   - Do not edit `.ai/workflows/**` in this repo.
   - If maintainers want to exercise the new workflow via the local mirror, do so by testing the `src/ai/**` docs directly (or regenerate `.ai/` in a separate scratch workspace, not committed).

## Verification
- Repo is Markdown-only; verification is consistency/sanity checks:
  - `grep` for remaining required references:
    - Ensure Conductor shortcut list mentions `implement` and new phrases.
    - Ensure plan gate text mentions `implement` trivial mode.
    - Ensure investigate/researcher handoff lists no longer prefer `fix-bug`/`implement-feature`.
  - Optional: `rg "implement-feature|fix-bug|trivial-change" src/ai/` to confirm only intentional alias references remain.

## Doc impact
- Update (as part of the implementation of this plan):
  - `src/ai/workflows/implement.md` (new canonical workflow)
  - `src/ai/agents/conductor.md` and `src/ai/agents/builder.md` (gate + shortcut rules)
  - `src/ai/workflows/investigate.md` and `src/ai/agents/researcher.md` (handoff lists)
- Mirror note: do not edit `.ai/workflows/**`; any `.ai/` updates should be done via copying from `src/ai/` outside this repo’s tracked forbidden paths.

## Memory impact
- After implementing, append 1 durable bullet to `.ai/MEMORY.md`:
  - “Unified `implement` workflow replaces `implement-feature` + `fix-bug`; trivial path is `implement`(trivial) with no plan.”

## Rollback
- If the unified workflow causes confusion, revert by restoring Conductor shortcuts to route to the old workflows and deleting `src/ai/workflows/implement.md`.
- Keep alias stubs minimal so rollback is a clean revert of the related commits.
