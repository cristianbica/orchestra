# Orchestra: AI Docs + Agents Template

## What Orchestra is

Orchestra is a copy-paste operating model for AI-assisted development, built around overlays, workflows, and role-based execution.

It helps teams build and maintain project documentation so agents work with stronger context, follow clear workflows with explicit boundaries, and use overlays for specialization when domain needs differ.

In practice, Orchestra gives your repo:

- Canonical project context in `.ai/` (docs, patterns, plans, overlays, memory)
- Role-based execution (`Conductor`, `Planner`, `Builder`, `Validator`, optional `Forger`)
- Repeatable workflows with gates (`change`, `investigate`, `document`, `trivial-change`, `guided`)
- A hard plan/approval gate for non-trivial changes

## Agents

| Agent | Directive |
| --- | --- |
| `Conductor` | Route requests to the right workflow, enforce gates, and coordinate delegation. |
| `Planner` | Investigate quickly and produce evidence-backed executable plans. |
| `Builder` | Implement approved plans with minimal, safe, scoped changes. |
| `Validator` | Validate correctness, plan adherence, and docs/memory hygiene. |
| `Forger` (opt-in) | Run the full flow in one agent thread with explicit phase boundaries. |

## Workflows

| Workflow | Description |
| --- | --- |
| `change` | Feature/bug/refactor workflow with planning + explicit approval gate. |
| `investigate` | Timeboxed investigation to reduce uncertainty and recommend next workflow. |
| `document` | Create or refresh `.ai/docs/` from current source of truth. |
| `trivial-change` | Tiny no-behavior edits (typos/formatting/docs wording), no plan required. |
| `guided` | Hand-held wrapper that keeps normal workflow gates intact. |

Note: you can define your own workflows for your repo when the defaults are not enough.

## Overlays

Overlays let you specialize agent guidance for your architecture, product domain, and risk profile without changing core workflows; they keep decisions contextual while preserving shared gates and consistency. Current overlays: `value.md`, `ux.md`, `system.md`, `data.md`, `security.md`. You can also define your own overlays for your repo.

## Conductor vs Forger

Use `Conductor` by default for larger or more involved tasks. Delegation keeps context focused per phase, improves gate discipline, and reduces context saturation that can increase hallucination risk.

Use `Forger` when you explicitly want faster single-agent execution for tightly scoped work. This can be quicker, but long or complex tasks can fill context faster and increase risk of drift.

## Quick start

### Install Orchestra into your repository root:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh
```

<details>
<summary>Other install options</summary>

Install from a specific branch/tag/SHA:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/next/install.sh | REF=next sh
```

Include a tool wrapper during install:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- copilot
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- claude-code
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- opencode
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- codex
```

Manual copy (no script), from your target repository root:

```sh
mkdir -p .ai
cp -R /path/to/orchestra/src/. .ai/
cp /path/to/orchestra/src/AGENTS.md ./AGENTS.md

# Optional: tool-specific wrapper
cp -R /path/to/orchestra/src/tools/copilot/. .
cp -R /path/to/orchestra/src/tools/claude-code/. .
cp -R /path/to/orchestra/src/tools/opencode/. .
cp -R /path/to/orchestra/src/tools/codex/. .
```

</details>

### Then bootstrap initial context:

```
User: Conductor bootstrap this

Outcome: initial context is seeded under .ai/docs/ (and patterns under .ai/docs/patterns/ as needed)
```

## Examples

### Implement a feature (plan gate enforced)

```
User: Conductor change: feature add a dark mode toggle

Conductor: asks 1–3 intake questions
Planner: writes a plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Validator: reviews for correctness + plan adherence and updates docs/memory as needed
```

### Fix a bug

```
User: Conductor fix bug: API returns stale cached data

Conductor: intake questions (expected vs actual, repro, evidence)
Planner: writes a fix plan
Builder: implements the fix
Validator: verifies the change matches the plan
```

### Trivial change (no plan required)

```
User: Conductor trivial-change: fix typos in docs

Conductor: confirms wording-only scope
Builder: applies minimal doc edit
Validator: quick spot-check
```

## Contributing

- Follow the same process Orchestra enforces: non-trivial changes require a plan in `.ai/plans/` and explicit approval before implementation.
- Keep docs high-signal: update `.ai/docs/` when behavior or conventions change.
- Keep memory durable: add only long-lived conventions to `.ai/MEMORY.md`.

If you’re contributing changes to this template itself, open a PR and include verification notes (commands run, doc impact, memory impact).
