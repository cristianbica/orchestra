# Pattern: Planning Gate

## What it is

The **planning gate** is a hard requirement: non-trivial changes cannot be implemented until an approved plan exists.

Plans go in `.ai/plans/<YYYY-MM-DD>-<slug>.md`.

## Why it matters

Without a plan:
- ❌ Scope creep (feature expands mid-implementation)
- ❌ Missed context (builder doesn't know all constraints)
- ❌ Lost requirements (intake questions were never asked)
- ❌ No verification strategy (how will we know it's done?)

With a plan:
- ✓ Requirements are explicit (intake captured them)
- ✓ Scope is bounded (builder knows what NOT to do)
- ✓ Verification is planned (tests/commands defined upfront)
- ✓ Changes are traceable (future maintainers see the "why")

## How it works

1. **User** requests a change (e.g., "implement-feature workflow")
2. **Conductor** routes to Architect
3. **Architect** writes `.ai/plans/<date>-<slug>.md` (planning only, no implementation)
4. **User** reads and explicitly approves the plan
5. **Builder** implements ONLY the approved plan
6. **Verification** & **Archivist** close out the task

## Types of changes

| Task | Plan required? | Approval required? |
|------|----------------|--------------------|
| Typo fix | No | No |
| Formatting only | No | No |
| Bug fix | Yes | Yes |
| Feature | Yes | Yes |
| Refactor | Yes | Yes |
| Docs update | Depends* | No |

*Docs: Use bootstrap/refresh plans for major updates; incremental updates during feature/bug/refactor flows.

## See also

- [src/ai/plans/01-bootstrap.md](../../src/ai/plans/01-bootstrap.md) — Example plan structure (Phase 1–4)
- [src/ai/templates/plan.template.md](../../src/ai/templates/plan.template.md) — Plan template
- [src/ai/agents/architect.md](../../src/ai/agents/architect.md) — Architect role + discovery checklist
