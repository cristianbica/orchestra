# App overview (this framework)

> **Important**: This is the **Orchestra template/framework repository itself**. If you're using Orchestra in your own repo, you edit and develop in `.ai/docs/` (which was copied from `src/ai/docs/`). This file documents the Orchestra system, not your application.

## What this app does

This is the **canonical template for AI-assisted development workflows**. It provides:
- A multi-agent system (5 roles: Conductor, Architect, Builder, Inspector, Archivist)
- Five structured workflows for common development tasks
- Reusable documentation templates and agent guides
- Tool-specific wrappers (GitHub Copilot, Claude Code, OpenCode)
- An installation system to bootstrap `.ai/` dirs in target repositories

Designed for teams building with AI agents, this system enforces planning gates, documentation hygiene, and verified commands before implementation.

## Tech stack

- **Format**: Markdown + POSIX shell scripts
- **Distribution**: GitHub (`cristianbica/orchestra`)
- **Installation**: `bash install.sh [tool-name]` (copies template to target repo)
- **Tool integrations**: GitHub Copilot, Claude Code, OpenCode
- **No runtime dependencies**: Pure docs + scripts

## Repo landmarks

- **Canonical sources** (this framework repo):
  - [src/ai/](../../src/ai/) — agent roles, workflows, templates, docs
  - [src/tools/](../../src/tools/) — tool-specific wrapper templates
- **Installed in user repos as**: `.ai/` (copy of `src/ai/`)
  - User repos edit `.ai/` locally; never edit `src/ai/` directly
  - `src/ai/docs/` serves as a template; user repos copy it and customize for their app
- **Local mirror**: `.ai/` (this repo only) — a working copy used to exercise the workflows
- **Agent definitions**: [src/ai/agents/](../../src/ai/agents/) — Conductor, Architect, Builder, Inspector, Archivist
- **Workflow definitions**: [src/ai/workflows/](../../src/ai/workflows/) — document, implement-feature, fix-bug, refactor, trivial-change
- **Documentation templates**: [src/ai/docs/](../../src/ai/docs/) — overview, features, patterns
- **Bootstrap plan**: [src/ai/plans/01-bootstrap.md](../../src/ai/plans/01-bootstrap.md) — initial setup for target repos
- **Installation script**: [install.sh](../../install.sh) — distributes `.ai/` and tool wrappers to target repos
- **Tool templates**: [src/tools/](../../src/tools/) — Copilot, Claude Code, OpenCode wrappers

## Business domains

Not applicable (this is a template/framework, not a domain application).

**Instead, conceptual domains:**
- **Agent orchestration**: Conductor role, workflow routing, plan gates
- **Planning & architecture**: Architect role, plan structure, discovery patterns
- **Implementation**: Builder role, minimal safe changes, verification
- **Documentation**: Archivist role, feature/pattern docs, memory curation
- **Review & quality**: Inspector role, verification, adherence checks
