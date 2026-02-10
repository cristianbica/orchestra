# Claude Code project instructions

This repository uses `.ai/` as the canonical source of agent roles, workflows, plans, and documentation.

## Start here
- Read `.ai/README.md`.
- Use workflows in `.ai/workflows/`.

## Hard gate
- For any non-trivial code change: require a plan in `.ai/plans/` and explicit user approval before implementing.

## How to use subagents
This repo provides project subagents under `.claude/agents/` (see `/agents` in Claude Code).
Use them explicitly, for example:
- “Use the conductor subagent to pick the correct workflow for this request.”
- “Use the architect subagent to write a plan in `.ai/plans/`.”
- “Use the builder subagent to implement the approved plan.”
- “Use the inspector subagent to review the diff against the plan.”
- “Use the archivist subagent to update `.ai/docs/**` and `.ai/MEMORY.md`.”

## Required reporting at the end of work
- Verification: exact tests/commands run (or why none)
- doc impact: updated | none | deferred
- memory impact: add a short bullet to `.ai/MEMORY.md` when a durable repo fact is discovered
