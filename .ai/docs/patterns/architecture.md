# Pattern: Template Architecture

## What it is

Orchestra uses a two-tier layout:

- `src/ai/` and `src/tools/` are the canonical sources in this template repo.
- `.ai/` is the installed output in user repos (and a local mirror in this repo).

`install.sh` copies the template into a target repo, preserving existing `.ai/docs/`, `.ai/playbooks/`, `.ai/plans/`, and `.ai/MEMORY.md` content that a team has already customized.

Playbooks add a reusable-procedure layer under `.ai/playbooks/`. They are copied from `src/ai/playbooks/` when first installed, then treated as repo-local operational knowledge.

Operations add a built-in side-task layer under `.ai/operations/`. They are copied from `src/ai/operations/` and keep bootstrap, refresh, overlay creation, and playbook tasks out of lifecycle workflows.

For contributors to **this repository**, follow the repo operating rules documented in `.ai/docs/overview.md`:

- Treat `src/` as the canonical source of what gets distributed to users.
- Treat `.ai/` as a working copy/mirror used to exercise workflows.
- Only edit `.ai/docs/`, `.ai/plans/`, and `.ai/MEMORY.md` under `.ai/`.
- Never edit `.ai/agents/`, `.ai/workflows/`, `.ai/templates/`, or `.ai/HUMANS.md`.

Coordination precedence:

- Workflow gates, operation gates, role boundaries, approved plan scope, and playbook invocation policy all constrain execution.
- Stricter approval requirements win when constraints overlap.
- Overlays remain supporting context only.

## Why it matters

- Keeps the template source clean and versioned (`src/`)
- Ensures user repos customize `.ai/` without editing the template
- Avoids overwriting docs and memory already curated by a team

## See also

- [installation.md](../features/installation.md) - Installation behavior
- [tool-wrappers.md](../features/tool-wrappers.md) - Tool wrapper templates
