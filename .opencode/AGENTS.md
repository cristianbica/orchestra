# OpenCode project rules (AGENTS.md)

This repository uses `.ai/` as the canonical source of agent roles, workflows, plans, and documentation.

## Start here
- Read /AGENTS.md (repo root).
- Use `.ai/agents/guides/routing.md` for the authoritative route and gate contract.
- Load workflows and operations on demand for the selected route.

## Hard gates
- Prefer minimal scope; do not expand requirements.
- For a plan-required change: require an inline or `.ai/plans/**` plan artifact and explicit user approval before implementing.
- Keep always-on context lean; load role, workflow, overlay, docs, and plan files on demand.

## Working modes (roles)

When asked to act in a role, follow the canonical role file:
- Conductor: `.ai/agents/conductor.md` (orchestrate; do not implement product code)
- Planner: `.ai/agents/planner.md` (investigation + planning only)
- Builder: `.ai/agents/builder.md` (implement only after plan approval)
- Validator: `.ai/agents/validator.md` (review diffs vs plan + docs/memory hygiene)

Agent wrappers use OpenCode permissions to translate each canonical role's write and delegation boundaries.

## Delegation limits
- Treat Conductor and opt-in Forger as the only user-facing roles; Planner, Builder, and Validator are delegation-only.
- Run at most one subagent at a time. Obtain the user's explicit approval before launching a second subagent for the same request, including after the first completes.

If anything in this file conflicts with `.ai/agents/*.md`, the canonical file wins.

## Required reporting (end of each task)
- Verification: exact tests/commands run (or explain why none).
- doc impact: updated | none | deferred
- memory impact: add a short bullet to `.ai/MEMORY.md` when a durable repo fact is discovered.
