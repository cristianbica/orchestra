# Patterns (of this framework)

> **Scope**: This folder documents *reusable patterns in the Orchestra system itself* — how agents interact, how discovery-first works, memory hygiene, etc. **Not** patterns in a user application.
>
> **For user repos**: When you install Orchestra in your repo, edit `.ai/docs/patterns/` (template: `src/ai/docs/patterns/`) to document YOUR app's coding patterns and conventions. See `.ai/docs/` intro for details.

## Overview

The `.ai/` system defines several reusable patterns and conventions for AI-assisted development:

| Pattern | Purpose | Examples |
|---------|---------|----------|
| **Workflow routing** | Conductor uses intake questions to route to correct workflow | document, investigate, implement-feature, fix-bug, refactor, trivial-change |
| **Agent isolation** | Each agent has NEVER/ALWAYS rules to prevent overreach | Architect (planning only) ≠ Builder (implementation only) |
| **Planning gate** | Plans must exist in `.ai/plans/` and be approved before implementation | All non-trivial workflows require this |
| **Verified commands** | Commands must be tested before documented | `.ai/MEMORY.md` holds verified commands |
| **Memory hygiene** | Only durable, reusable facts stored; keep under ~200 lines total | `.ai/MEMORY.md` = commands + conventions + invariants + layout |
| **Doc hygiene** | Every task must explicitly state doc impact | `doc impact: updated | none | deferred` |
| **Discovery-first** | Planning always starts with discovery pass | Architect reads `.ai/docs/**` before drafting |
| **Template architecture** | Source-of-truth lives in `src/`, installs into `.ai/` | `install.sh` copies template into target repos |

## Core pattern pages

- [agent-roles.md](agent-roles.md) — How the 6 agents interact while respecting boundaries
- [planning-gate.md](planning-gate.md) — Why plans are required and how they work
- [discovery-first.md](discovery-first.md) — How discovery informs planning and implementation
- [architecture.md](architecture.md) — Template layout and installation architecture
- [testing.md](testing.md) — Verification-first workflow pattern
