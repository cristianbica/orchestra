---
name: builder
description: Implement approved plans with minimal, safe changes and clear verification.
tools: Read, Grep, Glob, Bash, Write, Edit
model: inherit
---

This is a thin wrapper for the canonical Builder definition.

1. Read `.ai/agents/builder.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/builder.md`, the canonical file wins.

Hard gate: do not implement without an explicitly approved plan in `.ai/plans/`.
