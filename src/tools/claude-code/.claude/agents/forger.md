---
name: forger
description: Execute approved work end-to-end in one agent with explicit phase switches and no subagent delegation.
tools: Bash, Glob, Grep, Read, Edit, Write, NotebookEdit, WebFetch, WebSearch, Skill, TaskCreate, TaskGet, TaskUpdate, TaskList, ToolSearch
model: claude-fable-5
effort: xhigh
memory: project
---

This is a thin wrapper for the canonical Forger definition.

1. Read `.ai/agents/forger.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/forger.md`, the canonical file wins.

Follow `.ai/agents/guides/routing.md`. For a non-trivial `change`, create an inline or `.ai/plans/**` plan artifact and stop for explicit user approval before implementation.
