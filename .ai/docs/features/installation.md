# Feature: Template Installation

## What it is

The repository ships an install script that copies the template into a target repo. It installs the `.ai/` blueprint, places `AGENTS.md` in the repo root, and optionally adds a tool-specific wrapper.

## How it works

- `install.sh` copies `src/ai/` into `.ai/` in the target repo.
- If `.ai/docs/`, `.ai/MEMORY.md`, or `.ai/plans/` already exist, the script preserves them and only refreshes the bootstrap and refresh plans.
- If `SRC_DIR` is set, the script copies from that local path.
- Otherwise, it downloads the template from GitHub and uses that as the source.

## Tool wrapper option

If a tool name is passed, the script also copies the corresponding wrapper from `src/tools/<tool-name>/` into the target repo root.

## See also

- [install.sh](../../../install.sh) - Installer script
- [tool-wrappers.md](tool-wrappers.md) - Wrapper templates included in this repo
