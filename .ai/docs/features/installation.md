# Feature: Template Installation

## What it is

The repository ships an install script that copies the template into a target repo. It installs the `.ai/` blueprint, places `AGENTS.md` in the repo root, and optionally adds a tool-specific wrapper.

## How it works

- `install.sh` copies `src/ai/` into `.ai/` in the target repo.
- If `.ai/docs/`, `.ai/playbooks/`, `.ai/MEMORY.md`, or `.ai/plans/` already exist, the script preserves repo-local content.
- Built-in side tasks install under `.ai/operations/`; legacy built-in side-task files are removed from `.ai/workflows/` and `.ai/plans/`.
- If `SRC_DIR` is set, the script copies from that local path.
- Otherwise, it downloads the template from GitHub and uses that as the source.

## Tool wrapper option

If a tool name is passed, the script also copies the corresponding wrapper from `src/tools/<tool-name>/` into the target repo root.

Existing tool wrapper files are preserved by default. If a wrapper file already exists, the installer leaves it unchanged so configured models, tools, permissions, and similar runtime parameters survive reinstall.

Set `ORCHESTRA_INSTALL_FORCE=1` to replace existing tool wrapper files with the template versions. Codex adapter installs still clean up stale Markdown role wrappers (`.codex/agents/*.md`) before copying TOML custom-agent files.

## See also

- [install.sh](../../../install.sh) - Installer script
- [tool-wrappers.md](tool-wrappers.md) - Wrapper templates included in this repo
