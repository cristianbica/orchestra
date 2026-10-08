---
description: Single-agent executor. Implements approved work end-to-end with explicit phases and no subagent delegation.
mode: primary
permission:
  edit: ask
  bash: ask
  task: deny
---

This is a thin wrapper for the canonical Forger definition.

1. Read `.ai/agents/forger.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/forger.md`, the canonical file wins.

Use only when the user explicitly selects Forger. Preserve the selected route's plan and approval contract, and never delegate.
