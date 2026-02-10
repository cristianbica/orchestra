# Pattern: Template Architecture

## What it is

Orchestra uses a two-tier layout:

- `src/ai/` and `src/tools/` are the canonical sources in this template repo.
- `.ai/` is the installed output in user repos (and a local mirror in this repo).

`install.sh` copies the template into a target repo, preserving any existing `.ai/docs/` and `.ai/MEMORY.md` that a team has already customized.

## Why it matters

- Keeps the template source clean and versioned (`src/`)
- Ensures user repos customize `.ai/` without editing the template
- Avoids overwriting docs and memory already curated by a team

## See also

- [installation.md](../features/installation.md) - Installation behavior
- [tool-wrappers.md](../features/tool-wrappers.md) - Tool wrapper templates
