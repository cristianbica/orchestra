# Agent Instructions (Global)

This file lives at the project root. The `.ai/` folder lives in the project root as well.

# .ai — Canonical AI Context

The `.ai/` folder is the canonical source of truth for:
- Agent roles: [.ai/agents/](.ai/agents/)
- Workflows: [.ai/workflows/](.ai/workflows/)
- Templates: [.ai/templates/](.ai/templates/)
- App documentation: [.ai/docs/](.ai/docs/)
- Planning artifacts: [.ai/plans/](.ai/plans/)
- Curated memory: [.ai/MEMORY.md](.ai/MEMORY.md)

Start here for app context: [.ai/docs/overview.md](.ai/docs/overview.md)

## How to work

- For first-time setup: Copy [.ai/plans/01-bootstrap.md](.ai/plans/01-bootstrap.md) into your repo and run [.ai/workflows/document.md](.ai/workflows/document.md) to execute it
- For major refresh/migration: Use [.ai/plans/02-refresh-context.md](.ai/plans/02-refresh-context.md) via [.ai/workflows/document.md](.ai/workflows/document.md)
- For context refresh: [.ai/workflows/document.md](.ai/workflows/document.md)
- For changes, pick one:
	- [.ai/workflows/trivial-change.md](.ai/workflows/trivial-change.md) (typos, formatting only)
	- [.ai/workflows/document.md](.ai/workflows/document.md)
	- [.ai/workflows/investigate.md](.ai/workflows/investigate.md)
	- [.ai/workflows/implement-feature.md](.ai/workflows/implement-feature.md)
	- [.ai/workflows/fix-bug.md](.ai/workflows/fix-bug.md)
	- [.ai/workflows/refactor.md](.ai/workflows/refactor.md)

## Output conventions

- Plans: `.ai/plans/<YYYY-MM-DD>-<slug>.md`
- Feature docs: `.ai/docs/features/<slug>.md` (plus index)
- Pattern docs: `.ai/docs/patterns/<slug>.md` (plus index)

## Keep it small

- Each doc file should aim to fit on one screen.
- Prefer linking to other docs over repeating content.

Rules:
- Prefer minimal scope; do not expand requirements.
- Keep docs short; link instead of duplicating content.
- When assembling/pasting context for an agent, follow [.ai/agents/guides/context-management.md](.ai/agents/guides/context-management.md).
- If you discover a durable fact (commands, conventions, layout), update [.ai/MEMORY.md](.ai/MEMORY.md) (keep it under ~200 lines).
- When changing a feature or a coding convention, ensure related docs are updated under `.ai/docs/` (or explicitly note "doc impact: none").
- Use the workflows in `.ai/workflows/`.
