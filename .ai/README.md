# .ai — Canonical AI Context

This folder is the canonical source of truth for:
- Agent roles: [.ai/agents/](agents/)
- Workflows: [.ai/workflows/](workflows/)
- Templates: [.ai/templates/](templates/)
- App documentation: [.ai/docs/](docs/)
- Planning artifacts: [.ai/plans/](plans/)
- Curated memory: [.ai/MEMORY.md](MEMORY.md)

Start here for app context: [.ai/docs/overview.md](docs/overview.md)

## How to work

- For first-time setup: Copy [plans/0000-00-01-bootstrap.md](plans/0000-00-01-bootstrap.md) into your repo and run [workflows/document.md](workflows/document.md) to execute it
- For major refresh/migration: Use [plans/0000-00-02-refresh-context.md](plans/0000-00-02-refresh-context.md) via [workflows/document.md](workflows/document.md)
- For context refresh: [workflows/document.md](workflows/document.md)
- For changes, pick one:
  - [workflows/trivial-change.md](workflows/trivial-change.md) (typos, formatting only)
  - [workflows/implement-feature.md](workflows/implement-feature.md)
  - [workflows/fix-bug.md](workflows/fix-bug.md)
  - [workflows/refactor.md](workflows/refactor.md)

## Output conventions

- Plans: `.ai/plans/<YYYY-MM-DD>-<slug>.md`
- Feature docs: `.ai/docs/features/<slug>.md` (plus index)
- Pattern docs: `.ai/docs/patterns/<slug>.md` (plus index)

## Keep it small

- Each doc file should aim to fit on one screen.
- Prefer linking to other docs over repeating content.
