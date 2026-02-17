# Features (of this framework)

> **Scope**: This folder documents *features of the Orchestra framework itself* — how the multi-agent system works, what workflows provide, and how the planning/approval gate mechanism functions. **Not** documentation of a user application.
>
> **For user repos**: When you install Orchestra in your repo, edit `.ai/docs/features/` (template: `src/ai/docs/features/`) to document YOUR app's features. See `.ai/docs/` intro for details.

## Overview

The `.ai/` template provides structured workflows and roles for AI-assisted development. Once installed in a target repo, it enables:

| Feature | Purpose |
|---------|---------|
| **Workflow routing** | Conductor picks the right workflow for each task |
| **Planning gate** | Requires explicit plan approval before implementation |
| **Agent isolation** | Each role has strict responsibilities and constraints |
| **Documentation sync** | Docs update alongside changes and durable facts |
| **Verified commands** | Commands are tested before documented in memory |
| **Memory curation** | Only durable, reusable facts stored (keep <200 lines) |
| **Invariant enforcement** | Hard rules (NEVER, ALWAYS) prevent common mistakes |
| **Template installation** | `install.sh` copies the template into target repos |
| **Tool wrappers** | Optional wrappers for Copilot, Claude Code, OpenCode, Codex |

## Feature pages

- [workflows.md](workflows.md) — Current workflow set and gate behavior
- [implement-feature.md](implement-feature.md) — `change` workflow usage for feature/bug/refactor work
- [installation.md](installation.md) — How the template is distributed into target repos
- [tool-wrappers.md](tool-wrappers.md) — Tool-specific wrapper templates bundled with the repo
