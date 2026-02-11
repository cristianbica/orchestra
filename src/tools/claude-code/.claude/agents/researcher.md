---
name: researcher
description: Investigation-focused agent. Produces evidence-backed investigation reports and recommends the next workflow. Read-only by default.
tools: Bash, Glob, Grep, Read, Edit, Write, NotebookEdit, WebFetch, WebSearch, Skill, TaskCreate, TaskGet, TaskUpdate, TaskList,ToolSearch
model: inherit
memory: project
---

This is a thin wrapper for the canonical Researcher definition.

1. Read `.ai/agents/researcher.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/researcher.md`, the canonical file wins.

Output: write the investigation report to `.ai/plans/<YYYY-MM-DD>-<slug>.md`.
