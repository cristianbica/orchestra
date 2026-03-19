# Plan: Claude + Superpowers Orchestra Prompt Merge

Date: 2026-03-19

## Goal
- Merge the strongest ideas from the Claude Code and Superpowers prompt plans into one Orchestra prompt update.
- Make routing, planning, delegation, and verification more operational without changing the workflow model.
- Keep the result template-safe so it can ship through `src/ai/**` into installed repos.

## Non-goals
- Adding new workflows, roles, overlays, or plan gates.
- Changing the overall Conductor/Planner/Builder/Validator split.
- Editing product/app code outside the Orchestra template sources.

## Scope + assumptions
- Scope is limited to the canonical prompt sources under `src/ai/**`.
- Preserve the existing hard gates: no non-trivial implementation without an approved plan.
- Assume the best outcome comes from clearer instructions, better handoffs, and better verification discipline.

## Research Summary
The two source plans converge on the same set of improvements:
1. Explicit read-only planning phases with a clear stop/approval point.
2. A deterministic route between direct search, broader exploration, and delegation.
3. Worker briefs that are self-contained and easy to execute independently.
4. Verification that is command-backed and skeptical/adversarial, not code-reading-only.
5. Concise handoffs with absolute file references and minimal prose.
6. Better operator-facing guidance where Orchestra’s overlays and docs need to explain the model clearly.

## Plan

### Phase 1: Tighten Conductor routing guidance
- Update `src/ai/agents/conductor.md` and `src/ai/agents/guides/delegation.md`.
- Make the search/plan/execute decision tree explicit.
- Clarify when to use direct search, broader investigation, or parallel subagents.
- Make ownership handoffs explicit: who plans, who implements, who verifies, and when approval is required.
- Clarify how overlays should be loaded and treated as supporting context, not a substitute for workflow gates.

### Phase 2: Strengthen Planner output contract
- Update `src/ai/agents/planner.md`, `src/ai/workflows/change.md`, and `src/ai/workflows/investigate.md`.
- Require read-only exploration while planning.
- Require reuse of existing code, patterns, and reusable utilities first.
- Require critical files, reusable functions, and verification steps in the plan.
- Make the plan ready to execute, not a prose summary of options.
- Add a lean-context option for independent work units so smaller tasks do not inherit unnecessary plan text.

### Phase 3: Upgrade Validator expectations
- Update `src/ai/agents/validator.md`.
- Make verification explicitly adversarial and command-backed.
- Require at least one negative or edge-case probe where appropriate.
- Clarify how to distinguish environment limits from actual feature failures.
- Require reports to be crisp, with commands and observed output rather than narrative-only conclusions.

### Phase 4: Align docs with the new prompt behavior
- Update `src/ai/docs/overview.md` if the orchestration model needs operator-facing explanation.
- Update `src/ai/docs/patterns/architecture.md` if the role/delegation precedence or overlay model needs to be documented more clearly.
- Update `src/ai/docs/patterns/testing.md` only if the verification expectations need a short operator-facing note.
- Keep documentation concise and link-oriented rather than duplicating the prompt text verbatim.

### Phase 5: Verify and close out
- Review the diff for prompt clarity and hard-gate preservation.
- Confirm the updated text still routes the same way and does not weaken approval requirements.
- Confirm any docs updates match the new behavior and do not overstate capabilities.
- Note any durable repo fact worth recording in memory if it emerges during implementation.

## Files likely to change
- `src/ai/agents/conductor.md` - route decisions, delegation defaults, and handoff rules
- `src/ai/agents/guides/delegation.md` - clearer when-to-delegate guidance and subagent briefing patterns
- `src/ai/agents/planner.md` - planning output contract and plan shape expectations
- `src/ai/agents/validator.md` - verification rubric and reporting format
- `src/ai/workflows/change.md` - plan/approval/execution/verification sequencing
- `src/ai/workflows/investigate.md` - investigation boundaries and handoff to planning
- `src/ai/docs/overview.md` - operator-facing summary of the orchestration model
- `src/ai/docs/patterns/architecture.md` - role/delegation/overlay precedence guidance
- `src/ai/docs/patterns/testing.md` - verification expectations if a brief operator note is needed

## Verification
- Read the resulting prompt text and confirm the new guidance is clear, concise, and consistent.
- Confirm no hard gate was weakened: non-trivial work still requires an approved plan before implementation.
- Confirm Conductor still delegates by default and does not take on product-code work.
- Confirm Planner still produces read-only plans with explicit approval gates.
- Confirm Validator still requires command-backed verification and reports results clearly.
- Confirm docs, if updated, describe the overlay and verification model without implying a new workflow system.

## Doc impact
- none expected unless the final prompt edits require operator-facing documentation updates

## Memory impact
- none expected unless implementation surfaces a durable repo convention worth retaining
