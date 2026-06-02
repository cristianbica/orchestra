# Pattern: Context Budget

## What it is

Orchestra uses lean always-on context and lazy-loads detailed files only when a task needs them.

Orchestra reduces cost through compact prompts, lazy loading, and phase-sized handoffs.

## Rules

- Always-on context stays to root instructions, `.ai/RULES.md`, tool entry files, and pointers.
- Role files, workflows, overlays, docs, and plans are loaded on demand.
- `.ai/plans/**` is loaded only for the active plan file, or when the user explicitly asks to review existing plans.
- Handoffs name files by path and include only task evidence needed for the current phase.
- Non-trivial handoffs include `Active overlays` and `Do not load`.
- Short plans should be inline; use `.ai/plans/` when size, persistence, or user request justifies it.
- Planner gets enough context to make a decision-complete plan; Builder gets the approved plan and target files; Validator gets the plan, diff summary, and verification evidence.
- Broad work is split into phases instead of packed into one large prompt.

## See also

- [src/ai/agents/guides/context-management.md](../../../src/ai/agents/guides/context-management.md)
- [src/ai/agents/guides/delegation.md](../../../src/ai/agents/guides/delegation.md)
