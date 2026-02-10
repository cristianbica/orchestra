# GitHub Copilot Instructions

This repository uses `.ai/` as the canonical source of agent roles, workflows, plans, and documentation.

## Start here
- Read `.ai/README.md`.
- Use workflows in `.ai/workflows/`.
- When starting a workflow, answer the intake questions (max 3 blocking ones; "unknown" is ok) to ensure smooth delegation.

## Hard gates
- For any non-trivial code change: require a plan in `.ai/plans/` and explicit user approval before implementing.
- Do not expand scope beyond the approved plan.

## Delegation
- When the task requires planning or repo-wide discovery, delegate to the appropriate agent role instead of doing everything inline.
- Follow: `.ai/agents/guides/delegation.md`.

## Required reporting (end of each task)
- Verification: list the exact tests/commands run (or explain why none).
- `doc impact`: updated | none | deferred (and link to what changed).
- `memory impact`: if a durable repo fact (commands, conventions, layout) was discovered, append 1 short bullet to `.ai/MEMORY.md`.

## Where to look for truth
- App context: `.ai/docs/overview.md`
- Feature docs: `.ai/docs/features/`
- Pattern docs: `.ai/docs/patterns/`
- Agent operation guides: `.ai/agents/guides/`
- Curated memory: `.ai/MEMORY.md`

## Agents
Custom Copilot agents live under `.github/agents/` and are thin wrappers around `.ai/agents/`.
If wrapper text conflicts with canonical `.ai/agents/*.md`, the canonical file wins.
