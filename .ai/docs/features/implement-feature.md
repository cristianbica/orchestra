# Feature: Change Workflow (feature | bug | refactor)

## What it is

The **change workflow** is the implementation workflow for `feature`, `bug`, and `refactor` requests. It enforces planning, explicit approval, and verification gates.

## Intake questions

Conductor asks (max 3):
1. **Change type + summary** — Is this a `feature`, `bug`, or `refactor`, and what is the goal?
2. **Outcome criteria** — Top acceptance criteria (or expected vs actual + repro for bugs).
3. **Constraints** — Hard limits (API/schema/UX), compatibility, timeline, and risk notes.

Optional:
- Security/data sensitivity, authz, i18n, tenant/role scope.

## Execution phases

1. **Conductor** routes to Planner
2. **Planner** writes plan artifact in `.ai/plans/` (discovery-first)
3. **Plan approval gate** — do NOT implement until explicitly approved
4. **Builder** implements the approved plan (smallest safe change)
5. **Verification** — run tests/commands from `.ai/MEMORY.md`; record results
6. **Validator** validates: plan adherence, correctness, i18n, docs/memory hygiene
8. **Closeout** — explicitly state `doc impact` and `memory impact`

## Key rules

| Agent | Rule |
|-------|------|
| **Planner** | Investigation/planning only; NEVER implement; ALWAYS do discovery before drafting |
| **Builder** | NEVER implement without approved plan; do smallest change that satisfies plan |
| **Validator** | Validate against plan + repo conventions; update docs/memory when needed |

## See also

- [src/ai/workflows/change.md](../../../src/ai/workflows/change.md) — Full workflow definition
- [src/ai/agents/planner.md](../../../src/ai/agents/planner.md) — Planner role & discovery checklist
- [src/ai/plans/01-bootstrap.md](../../../src/ai/plans/01-bootstrap.md) — Example plan structure
