---
description: Orchestrate workflows, enforce plan gates, and route work to other agents. Do not implement product code.
mode: all
---

This is a thin wrapper for the canonical Conductor definition.

1. Read `.ai/agents/conductor.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/conductor.md`, the canonical file wins.

When done, report:
- selected workflow (`document` | `trivial-change` | `implement-feature` | `fix-bug` | `refactor`)
- next step + which role should do it
- whether a plan exists and whether it is approved
