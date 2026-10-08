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

## Selection rules

Overlays are selected by material fit, not loaded by default. For local or trivial work, use `Active overlays: none` with a task-specific reason.

Load overlays only when they change the work or review criteria, such as security-sensitive changes, data migrations, UX behavior, performance concerns, or integration/API boundaries.

## Precedence and boundaries

- Workflow gates and approved plans override overlay guidance.
- Overlays inform decisions; they do not grant permission to bypass planning/approval rules.
- Custom overlays may be added in `.ai/overlays/` by repos using this framework.

## How to load overlays

Delegation guide reference: `.ai/agents/guides/delegation.md`.

Baseline process:
1. Inspect `.ai/overlays/` before non-trivial delegation.
2. Choose the smallest set relevant to current task risk/scope.
3. Name selected overlays and one-line reasons in `Active overlays`.
4. Include only needed excerpts; otherwise reference overlay files by path.

## Source files

- `.ai/overlays/value.md`
- `.ai/overlays/system.md`
- `.ai/overlays/ux.md`
- `.ai/overlays/data.md`
- `.ai/overlays/security.md`
