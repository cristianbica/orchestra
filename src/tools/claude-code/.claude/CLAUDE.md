# Claude Code project instructions

This repository uses `.ai/` as the canonical source of agent roles, workflows, plans, and documentation.

## Start here
- Read /AGENTS.md (repo root).
- Use `.ai/agents/guides/routing.md` for the authoritative route and gate contract.
- Load workflows and operations on demand for the selected route.

## Hard gate
- For a plan-required change: require an inline or `.ai/plans/**` plan artifact and explicit user approval before implementing.

## How to use subagents
This repo provides project subagents under `.claude/agents/` (see `/agents` in Claude Code).
Use them explicitly, for example:
- "Use the conductor subagent to pick the correct workflow for this request."
- "Use the planner subagent to investigate as needed and produce an inline or file plan."
- "Use the builder subagent to implement the approved plan."
- "Use the validator subagent to review the diff against the plan and handle docs/memory hygiene."

Keep subagent prompts thin: reference canonical `.ai/**` files by path, include task evidence, and state what not to load for non-trivial work.

## Required reporting at the end of work
- Verification: exact tests/commands run (or why none)
- doc impact: updated | none | deferred
- memory impact: add a short bullet to `.ai/MEMORY.md` when a durable repo fact is discovered
