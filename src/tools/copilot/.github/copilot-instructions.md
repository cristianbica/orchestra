# GitHub Copilot Instructions

This repository uses `.ai/` as the canonical source of agent roles, workflows, plans, and documentation.

## Always-on context
- Read /AGENTS.md (repo root).
- Use `.ai/agents/guides/routing.md` for the authoritative route and gate contract.
- Load role, workflow, overlay, docs, and plan files on demand.
- Keep task handoffs lean: name files to load, include selected overlays, and state what not to load for non-trivial work.

## Hard gates
- For a plan-required change: require an inline or `.ai/plans/**` plan artifact and explicit user approval before implementing.
- Do not expand scope beyond the approved plan.

## Delegation
- When the task requires planning or repo-wide discovery, delegate to the appropriate agent role instead of doing everything inline.
- Follow: `.ai/agents/guides/delegation.md`.
- Treat Conductor and opt-in Forger as the only user-facing roles; Planner, Builder, and Validator are delegation-only.
- Run at most one subagent at a time. Obtain the user's explicit approval before launching a second subagent for the same request, including after the first completes.

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
- Path-specific `.ai/**` guidance: `.github/instructions/ai.instructions.md`

## Agents
Custom Copilot agents live under `.github/agents/` and are thin wrappers around `.ai/agents/`.
If wrapper text conflicts with canonical `.ai/agents/*.md`, the canonical file wins.
