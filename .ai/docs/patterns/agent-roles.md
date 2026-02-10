# Pattern: Agent Roles & Isolation

## What it is

The `.ai/` system has five specialized agent roles, each with NEVER/ALWAYS rules that prevent overreach and enforce separation of concerns.

## The five agents

| Role | Job | NEVER | ALWAYS |
|------|-----|-------|--------|
| **Conductor** | Route requests, enforce gates | Implement product code | Enforce doc + memory hygiene |
| **Architect** | Write plans, do discovery | Implement product code | Do discovery pass before drafting |
| **Builder** | Implement approved plans | Implement without approved plan | Do smallest change that satisfies plan |
| **Inspector** | Review changes against plan + conventions | Approve without reviewing | Check for i18n, doc impact, correctness |
| **Archivist** | Update docs and memory after changes | Implement product code | Document only what exists (no speculation) |

## Why isolation matters

- **Builder without Architect** → scope creep, missing requirements
- **Architect without Builder separation** → plans that are too prescriptive or implementer-focused
- **Archivist without doc path** → docs drift from code
- **Conductor without role clarity** → confusion about who does what

## Example: Implementing a feature

1. **Conductor** asks intake questions, routes to Architect
2. **Architect** (ALONE) discovers, writes plan, does NOT implement
3. **User** approves plan (explicit approval required)
4. **Builder** implements plan (ALONE), reports results
5. **Archivist** updates docs (after Builder completes)
6. **Inspector** reviews against plan + repo conventions

No agent skips their role or extends beyond their boundaries.

## See also

- [src/ai/agents/](../../src/ai/agents/) — Full agent role definitions
- [planning-gate.md](planning-gate.md) — Why the gate exists and how approval works
