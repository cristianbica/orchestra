# Agent Instructions (Global)

This file lives at the project root. The `.ai/` folder lives in the project root as well.

# .ai — Canonical AI Context

The `.ai/` folder is the canonical source of truth for:
- Agent roles: [.ai/agents/](.ai/agents/)
- Workflows: [.ai/workflows/](.ai/workflows/)
- Operations: [.ai/operations/](.ai/operations/)
- Overlays: [.ai/overlays/](.ai/overlays/)
- Playbooks: [.ai/playbooks/](.ai/playbooks/)
- Templates: [.ai/templates/](.ai/templates/)
- App documentation: [.ai/docs/](.ai/docs/)
- Planning artifacts: [.ai/plans/](.ai/plans/)
- Curated memory: [.ai/MEMORY.md](.ai/MEMORY.md)

Start here for app context: [.ai/docs/overview.md](.ai/docs/overview.md).

## Context tiers

- Always-on: this root `AGENTS.md`, `.ai/RULES.md`, tool-wrapper entry files, and pointers only.
- On-demand: role files, workflow files, operation files, playbooks, overlays, guides, docs, and plans.
- Task evidence: focused code excerpts, command output, diffs, and acceptance criteria.

Do not paste full role/workflow/operation/playbook/overlay files into handoffs when naming the path is enough.

## How to work

- For first-time setup: use the [.ai/operations/bootstrap.md](.ai/operations/bootstrap.md) operation.
- For major refresh/migration: use the [.ai/operations/refresh-context.md](.ai/operations/refresh-context.md) operation.
- For context refresh: use the [.ai/operations/refresh-context.md](.ai/operations/refresh-context.md) operation.
- For changes, pick one:
	- [.ai/workflows/trivial-change.md](.ai/workflows/trivial-change.md) (typos, formatting only)
	- [.ai/workflows/document.md](.ai/workflows/document.md)
	- [.ai/workflows/investigate.md](.ai/workflows/investigate.md)
	- [.ai/workflows/guided.md](.ai/workflows/guided.md) (hand-held, step-by-step wrapper)
	- [.ai/workflows/change.md](.ai/workflows/change.md) (`feature` | `bug` | `refactor`)
- For Orchestra side tasks and reusable procedures:
	- [.ai/operations/bootstrap.md](.ai/operations/bootstrap.md)
	- [.ai/operations/refresh-context.md](.ai/operations/refresh-context.md)
	- [.ai/operations/create-overlays.md](.ai/operations/create-overlays.md)
	- [.ai/operations/define-playbook.md](.ai/operations/define-playbook.md)
	- [.ai/operations/run-playbook.md](.ai/operations/run-playbook.md)

## Precedence model

- Workflows and their gates are highest priority.
- Roles execute inside the selected workflow or operation.
- Operations cover built-in side tasks and carry their own steps/gates.
- Playbook invocation policy constrains reusable procedure execution.
- Overlays provide supporting context and are lowest priority.
- Approved plans, workflow gates, operation gates, and stricter playbook approval requirements override overlay guidance.

## Output conventions

- Plans: `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md`
- Feature docs: `.ai/docs/features/<slug>.md` (plus index)
- Pattern docs: `.ai/docs/patterns/<slug>.md` (plus index)

## Keep it small

- Each doc file should aim to fit on one screen.
- Prefer linking to other docs over repeating content.
- Prefer short inline plans; use plan files only when the plan is large, persistent, or explicitly requested.
- Handoffs should name files to load, selected overlays, and what not to load for non-trivial delegation.
- Playbook handoffs should name relevant `.ai/playbooks/**` files and the invocation policy.

Rules:
- Prefer minimal scope; do not expand requirements.
- Keep docs short; link instead of duplicating content.
- When assembling/pasting context for an agent, follow [.ai/agents/guides/context-management.md](.ai/agents/guides/context-management.md).
- Overlay precedence: workflow gates, operation gates, and approved plans override overlays.
- If you discover a durable fact (commands, conventions, layout), update [.ai/MEMORY.md](.ai/MEMORY.md) (keep it under ~200 lines).
- When changing a feature or a coding convention, ensure related docs are updated under `.ai/docs/` (or explicitly note "doc impact: none").
- Use `.ai/workflows/` for development lifecycle work and `.ai/operations/` for Orchestra side tasks.
