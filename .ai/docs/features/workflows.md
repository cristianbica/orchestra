# Feature: Current Workflow Set

## What it is

The `.ai/` system uses five development lifecycle workflows:

| Workflow | When to use | Approver required? | Planning required? |
|----------|-------------|-------------------|--------------------|
| **document** (primary) | Create/refresh `.ai/docs/**` | No | Uses bootstrap/refresh operations for major setup |
| **change** (primary) | Implement `feature`, `bug`, or `refactor` work | Yes (plan approval) | Yes |
| **investigate** (primary) | Reduce uncertainty and produce a recommendation/report | No (unless promoted to implementation workflow) | Yes |
| **trivial-change** (primary) | Typos, formatting only | No | No |
| **guided** (wrapper) | Run a target workflow step-by-step with user confirmation | Follows target workflow gates | Follows target workflow rules |

Side tasks live in `.ai/operations/`, not `.ai/workflows/`: `bootstrap`, `refresh-context`, `create-overlays`, `define-playbook`, and `run-playbook`.

## Intake & gates

Each non-trivial workflow follows this pattern:

1. **Conductor intake** (asks 1–3 blocking questions)
2. **Planner discovery & plan/report** (writes to `.ai/plans/` by default)
3. **Plan approval gate** (user explicitly approves)
4. **Builder implementation** (executes plan only)
5. **Verification** (run tests/commands + record results)
6. **Validator review + docs/memory hygiene** (update `.ai/docs/**` and `.ai/MEMORY.md` as needed)

## Context budget

Handoffs should name files to load instead of pasting full canonical files. Non-trivial handoffs include `Active overlays` and `Do not load` so agents avoid unrelated folders, stale plans, and irrelevant adapter files.

## Key invariants

- **NEVER implement without an approved plan** (on non-trivial workflows)
- **NEVER bypass playbook invocation policy** when a workflow or operation uses a playbook
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
- [src/ai/workflows/guided.md](../../../src/ai/workflows/guided.md) — Hand-held wrapper over target workflows
- [src/ai/operations/README.md](../../../src/ai/operations/README.md) — Built-in operation taxonomy
