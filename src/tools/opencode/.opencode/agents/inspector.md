---
description: Review-only agent. Reviews diffs against the approved plan and repo conventions.
mode: subagent
tools:
  write: false
  edit: false
  bash: false
---

This is a thin wrapper for the canonical Inspector definition.

1. Read `.ai/agents/inspector.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/inspector.md`, the canonical file wins.

Output: high-signal review notes + concrete fixes.
