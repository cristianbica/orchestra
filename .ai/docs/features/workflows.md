# Feature: Current Workflow Set

## What it is

Four specialized workflows drive development in the `.ai/` system, each designed for a specific type of task:

| Workflow | When to use | Approver required? | Planning required? |
|----------|-------------|-------------------|--------------------|
| **document** | Create/refresh `.ai/docs/**` | No | Yes (bootstrap/refresh) |
| **change** | Implement `feature`, `bug`, or `refactor` work | Yes (plan approval) | Yes |
| **investigate** | Reduce uncertainty and produce a recommendation/report | No (unless promoted to `change`) | Yes |
| **trivial-change** | Typos, formatting only | No | No |

## Intake & gates

Each non-trivial workflow follows this pattern:

1. **Conductor intake** (asks 1–3 blocking questions)
2. **Planner discovery & plan/report** (writes to `.ai/plans/` by default)
3. **Plan approval gate** (user explicitly approves)
4. **Builder implementation** (executes plan only)
5. **Verification** (run tests/commands + record results)
6. **Validator review + docs/memory hygiene** (update `.ai/docs/**` and `.ai/MEMORY.md` as needed)

## Key invariants

- **NEVER implement without an approved plan** (on non-trivial workflows)
- **NEVER create a new plan unless the user explicitly asks** (when working on a plan)
- **ALWAYS enforce doc hygiene** — use `doc impact: updated | none | deferred`
- **ALWAYS enforce memory hygiene** — add durable facts only (max ~200 lines total in MEMORY.md)
- **Verify before documenting** — validation relies on evidence (commands run or explicit constraints)

## Legacy phrase mapping

- `implement feature`, `fix bug`, and `refactor` are treated as `change` workflow requests.

## See also

- [src/ai/workflows/document.md](../../../src/ai/workflows/document.md) — Full workflow definition
- [src/ai/workflows/change.md](../../../src/ai/workflows/change.md) — Feature/bug/refactor workflow
- [src/ai/workflows/investigate.md](../../../src/ai/workflows/investigate.md) — Investigation workflow
- [src/ai/plans/01-bootstrap.md](../../../src/ai/plans/01-bootstrap.md) — Initial setup plan (4-phase discovery & documentation)
