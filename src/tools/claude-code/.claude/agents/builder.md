---
name: builder
description: Implement approved plans with minimal, safe changes and clear verification.
tools: Bash, Glob, Grep, Read, Edit, Write, NotebookEdit, WebFetch, WebSearch, Skill, TaskCreate, TaskGet, TaskUpdate, TaskList, ToolSearch
model: claude-sonnet-5
effort: high
memory: project
---

This is a thin wrapper for the canonical Builder definition.

1. Read `.ai/agents/builder.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/builder.md`, the canonical file wins.

Hard gate: when the selected route requires a plan, do not implement without explicit approval of its inline or `.ai/plans/**` plan artifact.
