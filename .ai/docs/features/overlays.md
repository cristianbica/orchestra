# Feature: Overlays

## What it is

Overlays are reusable guidance layers loaded from `.ai/overlays/` and applied during planning/delegation to keep decisions focused and consistent.

Built-in overlays:
- `value`
- `system`
- `ux`
- `data`
- `security`

## Why it exists

Overlays provide lightweight, task-specific context without changing workflow gates:
- Keep planning aligned to value, architecture, UX, data, and security concerns
- Reduce missed constraints during investigation and implementation handoffs
- Standardize context loading before delegation

## Default combinations

Workflow defaults currently documented in `.ai/workflows/`:

| Workflow | Default overlays |
|----------|------------------|
| `change` | Feature: `value + system + ux`; Refactor: `system + security`; Bug: `system` (+ `data`/`security` as needed) |
| `investigate` | `system + data` (add `security` when sensitive) |
| `document` | `value + ux + system` |
| `trivial-change` | `ux` |

## Precedence and boundaries

- Workflow gates and approved plans override overlay guidance.
- Overlays inform decisions; they do not grant permission to bypass planning/approval rules.
- Custom overlays may be added in `.ai/overlays/` by repos using this framework.

## How to load overlays

Delegation guide reference: `.ai/agents/guides/delegation.md`.

Baseline process:
1. Start from workflow defaults.
2. Add overlays relevant to current task risk/scope.
3. Include loaded overlay content in the delegation prompt context.

## Source files

- `.ai/overlays/value.md`
- `.ai/overlays/system.md`
- `.ai/overlays/ux.md`
- `.ai/overlays/data.md`
- `.ai/overlays/security.md`
