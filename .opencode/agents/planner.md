---
description: Investigation + planning agent. Produces evidence-backed inline or file plans. No implementation.
mode: subagent
permission:
  edit: deny
  bash: ask
  task: deny
---

This is a thin wrapper for the canonical Planner definition.

1. Read `.ai/agents/planner.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/planner.md`, the canonical file wins.

Output: an inline plan when short, or a `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md` plan when persistence/size requires it.
