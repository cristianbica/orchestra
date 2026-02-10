# AI Docs + Agents Template

## What's this about

This repo is a copy-paste **template** for running AI-assisted development with clear roles, repeatable workflows, and a hard planning gate.

It’s designed to help you build and maintain shared project context over time via:

- `.ai/docs/` (overview + feature docs)
- `.ai/docs/patterns/` (architecture/convention decisions)

It includes:

- 5 agent roles (Conductor, Architect, Builder, Inspector, Archivist)
- 5 workflows (`document`, `implement-feature`, `fix-bug`, `refactor`, `trivial-change`)
- A canonical `.ai/` folder layout for plans, docs, patterns, and agent guides
- Optional tool wrappers you can drop into your repo (VS Code Copilot, Claude Code, OpenCode)

For the full operating guide, start with [.ai/HUMANS.md](.ai/HUMANS.md).

## Examples

### Implement a feature (plan gate enforced)

```
User: Conductor implement feature: add a dark mode toggle

Conductor: asks 1–3 intake questions
Architect: writes a plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Inspector: reviews for correctness + plan adherence
Archivist: updates docs/memory as needed
```

### Fix a bug

```
User: Conductor fix bug: API returns stale cached data

Conductor: intake questions (expected vs actual, repro, evidence)
Architect: writes a fix plan
Builder: implements the fix
Inspector: verifies the change matches the plan
```

## How to install

This template installs into an existing repo by copying `.ai/` plus a root `AGENTS.md`, and (optionally) a tool-specific wrapper.

### Install from GitHub

Run this from your target repository root:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/master/install.sh | sh
```

To include a tool wrapper during install:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/master/install.sh | sh -s -- vscode-copilot
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/master/install.sh | sh -s -- claude-code
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/master/install.sh | sh -s -- opencode
```

### Manual copy (no script)

From your target repository root:

```sh
mkdir -p .ai
cp -R /path/to/orchestra/src/. .ai/
cp /path/to/orchestra/src/AGENTS.md ./AGENTS.md

# Optional: tool-specific wrapper
cp -R /path/to/orchestra/src/tools/vscode-copilot/. .
cp -R /path/to/orchestra/src/tools/claude-code/. .
cp -R /path/to/orchestra/src/tools/opencode/. .
```

### After install: bootstrap initial context

Once installed in your target repo, bootstrap the initial documentation/context:

```
User: Conductor bootstrap this

Outcome: your repo gets initial context seeded under .ai/docs/ (and patterns under .ai/docs/patterns/ as needed)
```

## Contributing

- Follow the same process the template enforces: non-trivial changes should have a plan in `.ai/plans/` and explicit approval.
- Keep docs high-signal: update `.ai/docs/` when behavior or conventions change.
- Keep memory durable: add only long-lived conventions to `.ai/MEMORY.md`.

If you’re contributing changes to this template itself, open a PR and include verification notes (commands run, doc impact, memory impact).
