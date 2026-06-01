# Patterns (of this framework)

> **Scope**: This folder documents *reusable patterns in the Orchestra system itself* — how agents interact, how discovery-first works, memory hygiene, etc. **Not** patterns in a user application.
>
> **For user repos**: When you install Orchestra in your repo, edit `.ai/docs/patterns/` (template: `src/ai/docs/patterns/`) to document YOUR app's coding patterns and conventions. See `.ai/docs/` intro for details.

## Overview

The `.ai/` system defines several reusable patterns and conventions for AI-assisted development:

| Pattern | Purpose | Examples |
|---------|---------|----------|
| **Workflow routing** | Conductor uses intake questions to route to correct lifecycle workflow | document, investigate, change, trivial-change, guided |
| **Operation routing** | Conductor routes Orchestra side tasks outside workflows | bootstrap, refresh-context, create-overlays, define-playbook, run-playbook |
| **Agent isolation** | Each agent has NEVER/ALWAYS rules to prevent overreach | Planner (planning only) ≠ Builder (implementation only) |
| **Planning gate** | Plans must exist in `.ai/plans/` and be approved before implementation | All non-trivial workflows and operations require this |
| **Verified commands** | Commands must be tested before documented | `.ai/MEMORY.md` holds verified commands |
| **Playbooks** | Complex reusable procedures carry invocation policy and evidence rules | `.ai/playbooks/` |
| **Memory hygiene** | Only durable, reusable facts stored; keep under ~200 lines total | `.ai/MEMORY.md` = commands + conventions + invariants + layout |
| **Doc hygiene** | Every task must explicitly state doc impact | `doc impact: updated | none | deferred` |
| **Discovery-first** | Planning always starts with discovery pass | Planner reads `.ai/docs/**` before drafting |
| **Template architecture** | Source-of-truth lives in `src/`, installs into `.ai/` | `install.sh` copies template into target repos |
| **Context budget** | Handoffs name files and task evidence instead of dumping full docs | `Active overlays`, `Do not load`, inline plans when short |

## Core pattern pages

- [agent-roles.md](agent-roles.md) — How Conductor/Planner/Builder/Validator interact while respecting boundaries
- [planning-gate.md](planning-gate.md) — Why plans are required and how they work
- [discovery-first.md](discovery-first.md) — How discovery informs planning and implementation
- [architecture.md](architecture.md) — Template layout and installation architecture
- [i18n.md](i18n.md) — String and localization hygiene conventions
- [testing.md](testing.md) — Verification-first workflow pattern
- [context-budget.md](context-budget.md) — Lean always-on context and lazy loading
