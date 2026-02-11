---
name: inspector
description: Review changes for correctness, plan adherence, and gate checks. Review only.
tools: Bash, Glob, Grep, Read, Edit, Write, NotebookEdit, WebFetch, WebSearch, Skill, TaskCreate, TaskGet, TaskUpdate, TaskList,ToolSearch
model: inherit
memory: project
---

This is a thin wrapper for the canonical Inspector definition.

1. Read `.ai/agents/inspector.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/inspector.md`, the canonical file wins.

Output format: status (approve | needs changes), must-fix, optional, doc impact check.
