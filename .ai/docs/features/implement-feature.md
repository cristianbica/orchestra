# Feature: Implement-Feature Workflow

## What it is

The **implement-feature workflow** is for building new features with planning, approval, and verification gates.

## Intake questions

Conductor asks (max 3):
1. **Feature summary** — What are we building (1–2 sentences) + top 3 acceptance criteria?
2. **References** — Any similar existing flow/file/feature to mirror? (link/path or "none")
3. **Constraints** — Any hard constraints? (e.g. no schema change, behind a flag, backwards-compatible, timeline)

Optional:
- Security/data: authz rules, PII, audit logging?
- UX surface: which screens/routes/APIs affected?

## Execution phases

1. **Conductor** routes to Architect
2. **Architect** writes plan in `.ai/plans/` (discovery-first)
3. **Plan approval gate** — do NOT implement until explicitly approved
4. **Builder** implements the approved plan (smallest safe change)
5. **Verification** — run tests/commands from `.ai/MEMORY.md`; record results
6. **Archivist** updates `.ai/docs/` for the feature + affected patterns
7. **Inspector** reviews: plan adherence, correctness, i18n, docs
8. **Closeout** — explicitly state `doc impact` and `memory impact`

## Key rules

| Agent | Rule |
|-------|------|
| **Architect** | Planning only; NEVER implement; ALWAYS do discovery before drafting |
| **Builder** | NEVER implement without approved plan; do smallest change that satisfies plan |
| **Archivist** | Docs only; update feature/pattern pages + `.ai/MEMORY.md` if durable facts learned |
| **Inspector** | Verify against plan + repo conventions before approval |

## See also

- [src/ai/workflows/implement-feature.md](../../src/ai/workflows/implement-feature.md) — Full workflow definition
- [src/ai/agents/architect.md](../../src/ai/agents/architect.md) — Architect role & discovery checklist
- [src/ai/plans/01-bootstrap.md](../../src/ai/plans/01-bootstrap.md) — Example plan structure
