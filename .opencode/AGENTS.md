# OpenCode project rules (AGENTS.md)

This repository uses `.ai/` as the canonical source of agent roles, workflows, plans, and documentation.

## Start here
- Read /AGENTS.md (repo root).
- Use workflows in `.ai/workflows/`.

## Hard gates
- Prefer minimal scope; do not expand requirements.
- For any non-trivial code change: require a plan in `.ai/plans/` and explicit user approval before implementing.

## Working modes (roles)

When asked to act in a role, follow the canonical role file:
- Conductor: `.ai/agents/conductor.md` (orchestrate; do not implement product code)
- Planner: `.ai/agents/planner.md` (investigation + planning only)
- Builder: `.ai/agents/builder.md` (implement only after plan approval)
- Validator: `.ai/agents/validator.md` (review diffs vs plan + docs/memory hygiene)

If anything in this file conflicts with `.ai/agents/*.md`, the canonical file wins.

## Required reporting (end of each task)
- Verification: exact tests/commands run (or explain why none).
- doc impact: updated | none | deferred
- memory impact: add a short bullet to `.ai/MEMORY.md` when a durable repo fact is discovered.
