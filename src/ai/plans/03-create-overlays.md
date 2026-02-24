# Plan: Create Overlays

Date: <YYYY-MM-DD when you run this>

Run this when:
- You want built-in overlay guidance available by default in `.ai/overlays/`
- You need workflow- and role-level defaults for selecting overlays
- You want a consistent precedence model: workflow gates > roles > overlays

Execute via the `change` workflow.

## Goal
- Add a small built-in overlay set to the blueprint
- Make overlays part of core context in agents/workflows
- Preserve current gating behavior and plan approval requirements

## Non-goals
- Building runtime overlay execution logic
- Expanding beyond the built-in overlay set
- Changing workflow gates or plan approval policy

## Scope + assumptions
- Overlay set is fixed to exactly 5 built-ins
- Existing repos may already have custom overlays that must not be clobbered
- Changes remain concise and documentation-first

## Steps

### Phase 1: Add built-in overlays
1. Create `.ai/overlays/` in blueprint source (`src/ai/overlays/`).
2. Add exactly five concise files:
   - `value.md`
   - `system.md`
   - `ux.md`
   - `data.md`
   - `security.md`
3. Ensure each file contains:
   - Purpose
   - When to apply
   - Output focus

### Phase 2: Add plan artifact
1. Add `src/ai/plans/03-create-overlays.md`.
2. Keep style aligned with existing plan files (`01-bootstrap.md`, `02-refresh-context.md`).
3. Include clear goal/non-goals/scope/steps and verification.

### Phase 3: Wire overlays into core prompts
1. Update agent prompts:
   - `src/ai/agents/conductor.md`
   - `src/ai/agents/planner.md`
   - `src/ai/agents/builder.md`
   - `src/ai/agents/validator.md`
2. Update workflow docs:
   - `src/ai/workflows/change.md`
   - `src/ai/workflows/investigate.md`
   - `src/ai/workflows/document.md`
   - `src/ai/workflows/trivial-change.md`
3. Add default overlay combinations by workflow intent.
4. State precedence clearly: workflow gates/approved plans override overlays.

### Phase 4: Installer integration
1. Update `install.sh` to include overlays in default install/copy behavior.
2. Preserve existing behavior for all other directories/files.
3. Do not overwrite existing custom overlays unintentionally.

### Phase 5: Documentation updates
1. Update:
   - `AGENTS.md` (repo root)
   - `src/ai/AGENTS.md`
   - `src/ai/HUMANS.md`
   - `src/ai/docs/patterns/architecture.md`
2. Reflect model: workflows > roles > overlays.

## Verification
- Confirm `src/ai/overlays/` exists with exactly 5 built-ins.
- Confirm `src/ai/plans/03-create-overlays.md` exists.
- Confirm `install.sh` includes overlays in copy/install flow.
- Run quick grep/read checks for overlay references across agents/workflows/docs.

## Doc impact
- `AGENTS.md`
- `src/ai/AGENTS.md`
- `src/ai/HUMANS.md`
- `src/ai/docs/patterns/architecture.md`
- `src/ai/agents/*.md` (overlay defaults and precedence)
- `src/ai/workflows/*.md` (overlay defaults and precedence)

## Rollback
If overlay rollout is incorrect:
1. Remove `src/ai/overlays/*` files.
2. Revert overlay-related prompt/doc updates.
3. Restore installer logic to previous behavior.
4. Re-run verification and apply minimal fixes.
