# Agent Instructions (Global)

This file lives at the project root.

# Canonical authoring source

This project has two modes:

- If `src/ai/` exists: canonical authoring source is `src/ai/` and `src/tools/`.
- Otherwise: `.ai/` is the working area and effectively canonical.

Plans are always authored under `.ai/plans/`.

Start here for app context: `.ai/docs/overview.md` (installed repos) or `src/ai/docs/overview.md` (template repo)

## How to work

- For first-time setup: Copy [.ai/plans/01-bootstrap.md](.ai/plans/01-bootstrap.md) into your repo and run `src/ai/workflows/document.md` (template repo) or `.ai/workflows/document.md` (installed repos)
- For major refresh/migration: Use [.ai/plans/02-refresh-context.md](.ai/plans/02-refresh-context.md) via `src/ai/workflows/document.md` (template) or `.ai/workflows/document.md` (installed)
- For context refresh: `src/ai/workflows/document.md` (template) or `.ai/workflows/document.md` (installed)
- For changes, pick one:
	- `src/ai/workflows/trivial-change.md` (template) or `.ai/workflows/trivial-change.md` (installed)
	- `src/ai/workflows/implement-feature.md` (template) or `.ai/workflows/implement-feature.md` (installed)
	- `src/ai/workflows/fix-bug.md` (template) or `.ai/workflows/fix-bug.md` (installed)
	- `src/ai/workflows/refactor.md` (template) or `.ai/workflows/refactor.md` (installed)

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
- When assembling/pasting context for an agent, follow `src/ai/agents/guides/context-management.md` (template) or `.ai/agents/guides/context-management.md` (installed).
- If you discover a durable fact (commands, conventions, layout), update `src/ai/MEMORY.md` (template) or `.ai/MEMORY.md` (installed) (keep it under ~200 lines).
- When changing a feature or a coding convention, ensure related docs are updated under `src/ai/docs/` (template) or `.ai/docs/` (installed) (or explicitly note "doc impact: none").
- Use the workflows in `src/ai/workflows/` (template) or `.ai/workflows/` (installed).
