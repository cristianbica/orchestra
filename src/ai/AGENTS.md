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

Select one route before loading detailed instructions:

- Direct answer: answer questions/opinions that do not require file changes.
- Operation: use `.ai/operations/` for Orchestra side tasks: meta-tasks about the `.ai/` system, not product/app changes.
	- [.ai/operations/bootstrap.md](.ai/operations/bootstrap.md)
	- [.ai/operations/refresh-context.md](.ai/operations/refresh-context.md)
	- [.ai/operations/create-overlays.md](.ai/operations/create-overlays.md)
	- [.ai/operations/define-playbook.md](.ai/operations/define-playbook.md)
	- [.ai/operations/run-playbook.md](.ai/operations/run-playbook.md)
- Workflow: use `.ai/workflows/` for development lifecycle work.
	- [.ai/workflows/trivial-change.md](.ai/workflows/trivial-change.md) (typos, formatting only)
	- [.ai/workflows/document.md](.ai/workflows/document.md)
	- [.ai/workflows/investigate.md](.ai/workflows/investigate.md)
	- [.ai/workflows/guided.md](.ai/workflows/guided.md) (hand-held, step-by-step wrapper)
	- [.ai/workflows/change.md](.ai/workflows/change.md) (`feature` | `bug` | `refactor`)
- Mixed requests: split into operation and workflow phases instead of treating the task as both at once.

## Precedence model

- First select one route: direct answer, workflow, or operation.
- Then apply that route's gates and role boundaries.
- Approved plans constrain implementation inside the selected route.
- Playbook policy applies only when a playbook is invoked.
- Overlays provide supporting context and never override gates.

## Output conventions

- Plans: `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md`
- Feature docs: `.ai/docs/features/<slug>.md` (plus index)
- Pattern docs: `.ai/docs/patterns/<slug>.md` (plus index)

## Keep it small

- Each doc file should generally stay under 150 lines.
- Prefer linking to other docs over repeating content.
- Prefer inline plans when <= 30 non-empty lines; use plan files when larger, multi-session/persistent, or explicitly requested.
- Handoffs should name exact files to load, selected overlays, current evidence, and what not to load.
- Playbook handoffs should name relevant `.ai/playbooks/**` files and the invocation policy.

- Required `.ai` files missing/empty: stop and ask.
- Optional docs missing/empty: continue only if not needed, and note the gap.
- Do not invent missing canonical contents.
Rules:
- Prefer minimal scope; do not expand requirements.
- Keep docs short; link instead of duplicating content.
- When assembling/pasting context for an agent, follow [.ai/agents/guides/context-management.md](.ai/agents/guides/context-management.md).
- Overlay precedence: workflow gates, operation gates, and approved plans override overlays.
- If you discover a durable fact (commands, conventions, layout), update [.ai/MEMORY.md](.ai/MEMORY.md). If it is near or over 200 lines, consolidate/prune stale entries before appending.
- When changing a feature or a coding convention, ensure related docs are updated under `.ai/docs/` (or explicitly note "doc impact: none").
- Use `.ai/workflows/` for development lifecycle work and `.ai/operations/` for Orchestra side tasks.
