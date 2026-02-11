# Pattern: Template Architecture

## What it is

Orchestra uses a two-tier layout:

- `src/ai/` and `src/tools/` are the canonical sources in this template repo.
- `.ai/` is the installed output in user repos (and a local mirror in this repo).

`install.sh` copies the template into a target repo, preserving any existing `.ai/docs/` and `.ai/MEMORY.md` that a team has already customized.

For contributors to **this repository**, follow the repo operating rules documented in `.ai/docs/overview.md`:

- Treat `src/` as the canonical source of what gets distributed to users.
- Treat `.ai/` as a working copy/mirror used to exercise workflows.
- Only edit `.ai/docs/`, `.ai/plans/`, and `.ai/MEMORY.md` under `.ai/`.
- Never edit `.ai/agents/`, `.ai/workflows/`, `.ai/templates/`, or `.ai/HUMANS.md`.

## Why it matters

- Keeps the template source clean and versioned (`src/`)
- Ensures user repos customize `.ai/` without editing the template
- Avoids overwriting docs and memory already curated by a team

## See also

- [installation.md](../features/installation.md) - Installation behavior
- [tool-wrappers.md](../features/tool-wrappers.md) - Tool wrapper templates
