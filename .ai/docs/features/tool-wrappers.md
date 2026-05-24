# Feature: Tool Wrappers

## What it is

The repo includes optional wrappers that tailor Orchestra instructions to specific tools. These are installed alongside `.ai/` when `install.sh` is called with a tool name.

## Available wrappers

- **Copilot**: [src/tools/copilot/](../../../src/tools/copilot/) - `.github/` wrapper content
- **Claude Code**: [src/tools/claude-code/](../../../src/tools/claude-code/) - `.claude/` wrapper content
- **OpenCode**: [src/tools/opencode/](../../../src/tools/opencode/) - `.opencode/` wrapper content
- **Codex**: [src/tools/codex/](../../../src/tools/codex/) - `.codex/` wrapper content

## Adapter shape

- Wrappers stay thin and point to canonical `.ai/agents/**` and `.ai/workflows/**`.
- Codex uses standalone `.codex/agents/*.toml` custom-agent files plus `[agents]` limits in `.codex/config.toml`.
- Codex keeps the minimal Orchestra conductor identity directly in `.codex/config.toml`, then points to `.codex/AGENTS.md` and canonical `.ai/**` instructions for full role behavior.
- Claude Code includes `CLAUDE.md` and role agents; it does not install project skills.
- Copilot keeps global instructions lean and adds `.github/instructions/*.instructions.md` for path-specific guidance.
- OpenCode agent wrappers use permissions to keep planning/validation read-only and implementation edit-capable.

## Installation behavior

`install.sh` copies the wrapper directory contents into the target repo root after installing `.ai/`. Codex installs also remove old Markdown role wrappers from `.codex/agents/`.

## See also

- [installation.md](installation.md) - Installation flow and script behavior
