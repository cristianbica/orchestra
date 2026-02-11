---
description: Investigation-focused agent. Produces evidence-backed investigation reports and recommends the next workflow. Read-only by default.
mode: subagent
tools:
  write: false
  edit: false
  bash: false
---

This is a thin wrapper for the canonical Researcher definition.

1. Read `.ai/agents/researcher.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/researcher.md`, the canonical file wins.

Output: an investigation report intended for `.ai/plans/<YYYY-MM-DD>-<slug>.md` using the repo’s report template.
