---
name: archivist
description: Update .ai/docs and .ai/MEMORY.md to reflect what exists. Docs only; never implement product code.
tools: Read, Grep, Glob, Write, Edit
model: inherit
---

This is a thin wrapper for the canonical Archivist definition.

1. Read `.ai/agents/archivist.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/archivist.md`, the canonical file wins.

Restriction: limit edits to `.ai/docs/**` and `.ai/MEMORY.md` unless the canonical instructions explicitly require otherwise.
