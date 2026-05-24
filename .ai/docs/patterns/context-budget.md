# Pattern: Context Budget

## What it is

Orchestra uses lean always-on context and lazy-loads detailed files only when a task needs them.

## Rules

- Always-on context stays to root instructions, `.ai/RULES.md`, tool entry files, and pointers.
- Role files, workflows, overlays, docs, and plans are loaded on demand.
- Handoffs name files by path and include only task evidence needed for the current phase.
- Non-trivial handoffs include `Active overlays` and `Do not load`.
- Short plans should be inline; use `.ai/plans/` when size, persistence, or user request justifies it.

## See also

- [src/ai/agents/guides/context-management.md](../../../src/ai/agents/guides/context-management.md)
- [src/ai/agents/guides/delegation.md](../../../src/ai/agents/guides/delegation.md)
