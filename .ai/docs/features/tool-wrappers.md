# Feature: Tool Wrappers

## What it is

The repo includes optional wrappers that tailor Orchestra instructions to specific tools. These are installed alongside `.ai/` when `install.sh` is called with a tool name.

## Available wrappers

- **Copilot**: [src/tools/copilot/](../../../src/tools/copilot/) - `.github/` wrapper content
- **Claude Code**: [src/tools/claude-code/](../../../src/tools/claude-code/) - `.claude/` wrapper content
- **OpenCode**: [src/tools/opencode/](../../../src/tools/opencode/) - `.opencode/` wrapper content
- **Codex**: [src/tools/codex/](../../../src/tools/codex/) - `.codex/` wrapper content

## Installation behavior

`install.sh` copies the wrapper directory contents into the target repo root after installing `.ai/`.

## See also

- [installation.md](installation.md) - Installation flow and script behavior
