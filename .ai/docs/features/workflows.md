# Feature: 5 Structured Workflows

## What it is

Five specialized workflows drive development in the `.ai/` system, each designed for a specific type of task:

| Workflow | When to use | Approver required? | Planning required? |
|----------|-------------|-------------------|--------------------|
| **document** | Create/refresh `.ai/docs/**` | No | Yes (bootstrap/refresh) |
| **implement-feature** | Build a new feature | Yes (plan approval) | Yes |
| **fix-bug** | Fix a bug | Yes (plan approval) | Yes |
| **refactor** | Refactor code safely | Yes (plan approval) | Yes |
| **trivial-change** | Typos, formatting only | No | No |

## Intake & gates

Each non-trivial workflow follows this pattern:

1. **Conductor intake** (asks 1–3 blocking questions)
2. **Architect discovery & plan** (writes to `.ai/plans/`)
3. **Plan approval gate** (user explicitly approves)
4. **Builder implementation** (executes plan only)
5. **Verification** (run tests/commands + record results)
6. **Archivist documentation** (update `.ai/docs/**` and `.ai/MEMORY.md`)

## Key invariants

- **NEVER implement without an approved plan** (on non-trivial workflows)
- **NEVER create a new plan unless the user explicitly asks** (when working on a plan)
- **ALWAYS enforce doc hygiene** — use `doc impact: updated | none | deferred`
- **ALWAYS enforce memory hygiene** — add durable facts only (max ~200 lines total in MEMORY.md)
- **Verify before documenting** — Phase 2 of bootstrap validates all commands

## See also

- [src/ai/workflows/document.md](../../src/ai/workflows/document.md) — Full workflow definition
- [src/ai/workflows/implement-feature.md](../../src/ai/workflows/implement-feature.md) — Feature implementation workflow
- [src/ai/plans/01-bootstrap.md](../../src/ai/plans/01-bootstrap.md) — Initial setup plan (4-phase discovery & documentation)
