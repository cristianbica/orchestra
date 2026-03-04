# Plan: Enforce delegation-first Conductor behavior (plans in .ai, canonical edits in src)

Date: 2026-02-26

## Goal
- Reduce Conductor drift toward self-implementation by making delegation + plan-gate behavior explicit and runtime-agnostic.

## Non-goals
- No product feature/code changes.
- No changes to Builder/Planner/Validator responsibilities.
- No workflow expansion beyond delegation guardrails.

## Scope + assumptions
- Plan artifact location: `.ai/plans/`.
- Canonical source for instruction edits: `src/`.
- Tool/runtime wrappers in `src/tools/**` should mirror canonical delegation intent.

## Steps
1. Tighten Conductor guardrails in `src/ai/agents/conductor.md` (delegate-by-default, no inline implementation, explicit escalation on implementation asks).
2. Tighten anti-drift guidance in `src/ai/agents/guides/delegation.md` (default action policy + “implementation request => delegate Builder only after approved plan”).
3. Align tool-specific Conductor wrappers under `src/tools/**` with a short explicit rule: Conductor must not implement and must delegate planning/implementation roles.
4. Verify with grep across updated conductor files for required phrases (`delegate by default`, `NEVER implement`, `approved plan`).

## Verification
- Run targeted search checks for delegation/plan-gate wording in all modified Conductor docs/wrappers.
- Confirm change set is limited to Conductor/delegation instruction files.

## Doc impact
- updated: operational docs for Conductor/delegation behavior in agent instructions.

## Rollback (if applicable)
- Revert only touched Conductor/delegation instruction files.
