# Features (of this framework)

> **Scope**: This folder documents *features of the Orchestra framework itself* - how the multi-agent system works, what workflows provide, and how route-specific gates function. **Not** documentation of a user application.
>
> **For user repos**: When you install Orchestra in your repo, edit `.ai/docs/features/` (template: `src/ai/docs/features/`) to document YOUR app's features. See `.ai/docs/` intro for details.

## Overview

The `.ai/` template provides structured workflows and roles for AI-assisted development. Once installed in a target repo, it enables:

| Feature | Purpose |
|---------|---------|
| **Workflow routing** | Conductor picks the right development lifecycle workflow |
| **Operations** | Built-in side tasks live outside workflows |
| **Route-specific gates** | Uses plans, previews, or planless evidence exactly where the canonical route requires them |
| **Agent isolation** | Each role has strict responsibilities and constraints |
| **Documentation sync** | Docs update alongside changes and durable facts |
| **Verified commands** | Commands are tested before documented in memory |
| **Memory curation** | Only durable, reusable facts stored (keep <200 lines) |
| **Invariant enforcement** | Binding role and route boundaries prevent approval and ownership drift |
| **Overlays** | Reusable guidance layers selected by material task fit for workflow/delegation context |
| **Playbooks** | Reusable, permissioned procedures that workflows and operations can compose |
| **Template installation** | `install.sh` copies the template into target repos |
| **Tool wrappers** | Optional wrappers for Copilot, Claude Code, OpenCode, Codex |

## Feature pages

- [workflows.md](workflows.md) - Current workflow set and gate behavior
- [operations.md](operations.md) - Side-task taxonomy and built-in operations
- [implement-feature.md](implement-feature.md) - `change` workflow usage for feature/bug/refactor work
- [overlays.md](overlays.md) - Overlay set, default combinations, and precedence
- [playbooks.md](playbooks.md) - Reusable procedures, invocation policies, and execution gates
- [installation.md](installation.md) - How the template is distributed into target repos
- [tool-wrappers.md](tool-wrappers.md) - Tool-specific wrapper templates bundled with the repo
