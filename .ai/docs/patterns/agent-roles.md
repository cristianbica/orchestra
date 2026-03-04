# Pattern: Agent Roles & Isolation

## What it is

The `.ai/` system has four specialized agent roles, each with NEVER/ALWAYS rules that prevent overreach and enforce separation of concerns.

## The four agents

| Role | Job | NEVER | ALWAYS |
|------|-----|-------|--------|
| **Conductor** | Route requests, enforce gates | Implement product code | Enforce doc + memory hygiene |
| **Planner** | Investigate and write plans/reports | Implement product code | Do discovery pass before drafting |
| **Builder** | Implement approved plans | Implement without approved plan | Do smallest change that satisfies plan |
| **Validator** | Validate gates and maintain docs/memory hygiene | Approve without reviewing | Check plan adherence, i18n, docs, memory |

## Why isolation matters

- **Builder without Planner** → scope creep, missing requirements
- **Planner without Builder separation** → plans that are too prescriptive or implementer-focused
- **Validator without doc path** → docs drift from code
- **Conductor without role clarity** → confusion about who does what

## Example: Implementing a feature

1. **Conductor** asks intake questions, routes to Planner
2. **Planner** (ALONE) discovers, writes plan, does NOT implement
3. **User** approves plan (explicit approval required)
4. **Builder** implements plan (ALONE), reports results
5. **Validator** reviews against plan + repo conventions
6. **Validator** updates docs/memory only where needed

No agent skips their role or extends beyond their boundaries.

## See also

- [src/ai/agents/](../../../src/ai/agents/) — Full agent role definitions
- [planning-gate.md](planning-gate.md) — Why the gate exists and how approval works
