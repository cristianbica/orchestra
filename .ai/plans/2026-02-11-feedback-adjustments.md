# Plan: Never create a new plan unless asked

Date: 2026-02-11

## Goal
- Ensure that whenever working on a plan, agents never create a new plan unless the user explicitly asks.

## Non-goals
- Changing how plans are approved or how workflows are selected.
- Altering any product code or tooling outside the workflow and agent documentation.

## Scope + assumptions
- Update workflow docs in `src/ai/` to require staying on the current plan and never creating a new one unless explicitly requested.
- Update Conductor and agent guide text in `src/ai/` to reinforce the rule during plan execution.
- Assumption: `.ai/agents`, `.ai/workflows`, `.ai/templates`, `.ai/HUMANS.md` are read-only; only `.ai/docs`, `.ai/plans`, and `.ai/MEMORY.md` are writable.

## Steps
1. Update workflow files in `src/ai/workflows/` to replace any guidance that allows creating a new plan with "never create a new plan unless the user explicitly asks":
   - `src/ai/workflows/implement-feature.md`
   - `src/ai/workflows/fix-bug.md`
   - `src/ai/workflows/refactor.md`
   - `src/ai/workflows/document.md`
2. Update Conductor guidance in `src/ai/agents/conductor.md` to enforce the same rule.
3. Update an agent guide in `src/ai/agents/guides/` to codify the rule for planners/builders (likely `delegation.md`).

## Verification
- Manual review of the updated workflow + guide + conductor files to confirm the rule and trigger phrases are present and consistent.

## Doc impact
- Update: `.ai/docs/features/workflows.md` (if it mentions plan adjustments), plus any relevant pattern docs if they mention plan creation rules.
- OR: "doc impact: none" if no feature/pattern docs mention this rule.

## Rollback (if applicable)
- Revert the wording changes in the workflow and guide documents.
