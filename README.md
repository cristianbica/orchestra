# Orchestra: AI Docs + Agents Template

Orchestra is an operating model for AI-assisted development, built around workflows, operations, role-based execution, playbooks, and overlays.

It keeps changes predictable: shared context lives in `.ai/`, development work follows explicit workflow boundaries, side tasks live in operations, reusable procedures live in playbooks, and overlays specialize guidance without changing the core gates.

It keeps token cost down through prompt design: compact always-on instructions, phase-sized handoffs, role-specific context, and path references instead of repeated pasted docs.

## What You Get

- Canonical project context in `.ai/`:
  - docs, patterns, operations, workflows, playbooks, overlays, plans, and memory
- Role-based execution:
  - `Conductor`, `Planner`, `Builder`, `Validator`, and opt-in `Forger`
- Development lifecycle workflows:
  - `change`, `investigate`, `document`, `trivial-change`, and `guided`
- Built-in operations:
  - `bootstrap`, `refresh-context`, `create-overlays`, `define-playbook`, and `run-playbook`
- A hard approval gate for non-trivial implementation
- Tool wrappers for Codex, Claude Code, GitHub Copilot, and OpenCode

## Core Operating Loop

1. Start with `Conductor` and select a workflow or operation.
2. For non-trivial work, `Planner` creates a plan artifact.
3. Human explicitly approves the plan.
4. `Builder` implements only approved scope, or `Forger` runs the flow if explicitly selected.
5. `Validator` checks correctness, plan adherence, and docs/memory hygiene.

## Agents

| Agent | Directive |
| --- | --- |
| `Conductor` | Route requests to the right workflow or operation, enforce gates, and coordinate delegation. |
| `Planner` | Investigate quickly and produce evidence-backed executable plans. |
| `Builder` | Implement approved plans with minimal, safe, scoped changes. |
| `Validator` | Validate correctness, plan adherence, and docs/memory hygiene. |
| `Forger` (opt-in) | Run the full flow in one agent thread with explicit phase boundaries. |

## Workflows

Workflows are for the development lifecycle only.

| Workflow | Description |
| --- | --- |
| `change` | Feature/bug/refactor workflow with planning and explicit approval. |
| `investigate` | Timeboxed investigation to reduce uncertainty and recommend a next step. |
| `document` | Create or refresh `.ai/docs/` from the current source of truth. |
| `trivial-change` | Tiny no-behavior edits, such as typos or formatting. |
| `guided` | Hand-held wrapper that keeps normal workflow gates intact. |

## Operations

Operations are Orchestra side tasks stored in `.ai/operations/`. They may use normal roles and plan approval gates, but they are not development lifecycle workflows.

| Operation | Description |
| --- | --- |
| `bootstrap` | Establish initial `.ai/docs/**` and `.ai/MEMORY.md` context. |
| `refresh-context` | Refresh stale context after major repo or framework changes. |
| `create-overlays` | Add or update overlay guidance. |
| `define-playbook` | Create or update a reusable procedure with explicit policy, risks, inputs, and evidence. |
| `run-playbook` | Execute one reusable procedure while enforcing its invocation policy and approval gates. |

## Playbooks

Playbooks are reusable procedures stored in `.ai/playbooks/`. Use them for complex repo-local operations such as running UI smoke tests, fetching issue context, preparing local investigation data, or validating a release path.

Each playbook defines when to use it, invocation policy, allowed roles, required inputs, side effects, approval gates, steps, evidence, and failure handling.

Workflows and operations may compose playbooks. A user may directly run one with:

```text
Conductor run playbook: <playbook-slug>
```

## Overlays

Overlays specialize agent guidance for architecture, product domain, and risk profile without changing core workflows. Load them only when they materially affect the task; trivial/local work should usually use no overlays.

Built-in overlays include `value`, `ux`, `system`, `data`, `security`, `webdev`, `frontend`, `api`, `integration`, `devops`, `performance`, `testing`, `review`, `payments`, `privacy`, `dx`, `i18n`, `reliability`, and `mobile`.

## Conductor vs Forger

Use `Conductor` by default for larger or more involved tasks. Delegation keeps context focused per phase, improves gate discipline, and reduces context saturation.

Conductor should pass only the current phase's evidence: Planner gets enough to plan, Builder gets the approved plan plus target files, and Validator gets the plan, diff summary, and verification output.

Some runtimes require explicit permission before Conductor can spawn subagents. To avoid an extra prompt, start with:

```text
Use Conductor and delegate as needed.
```

That authorizes Planner, Builder, and Validator subagents for the current request. It does not approve implementation plans, destructive commands, production access, or other separate approval gates.

Use `Forger` only when you explicitly want faster single-agent execution for tightly scoped work.

## Install

Run from the root of the repository where you want Orchestra installed:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh
```

Install with a tool wrapper:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- codex
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- claude-code
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- copilot
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- opencode
```

Install from a specific branch, tag, or SHA:

```sh
curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/next/install.sh | REF=next sh
```

Manual copy from a local checkout:

```sh
mkdir -p .ai
cp -R /path/to/orchestra/src/ai/. .ai/
cp /path/to/orchestra/src/ai/AGENTS.md ./AGENTS.md

# Optional: tool-specific wrapper
cp -R /path/to/orchestra/src/tools/codex/. .
cp -R /path/to/orchestra/src/tools/claude-code/. .
cp -R /path/to/orchestra/src/tools/copilot/. .
cp -R /path/to/orchestra/src/tools/opencode/. .
```

## Quick Start

After installing, bootstrap initial context:

```text
User: Conductor bootstrap this
```

Then use the normal operating loop:

```text
User: Use Conductor and delegate as needed. Change: feature add a dark mode toggle.

Conductor: asks intake questions
Planner: writes a plan in .ai/plans/
User: explicitly approves the plan
Builder: implements only the approved plan
Validator: reviews correctness, verification, docs, and memory
```

Run a playbook:

```text
User: Conductor run playbook: rails-ui-smoke
```

## Repository Notes

This repository is the canonical Orchestra template. Template sources live under `src/ai/` and `src/tools/`.

When installed into another repository:

- `.ai/` is copied from `src/ai/`
- tool wrappers are copied from `src/tools/<tool-name>/`
- user repos customize their local `.ai/docs/**`, `.ai/MEMORY.md`, `.ai/plans/**`, and `.ai/playbooks/**`

## Verification

For this repository, run:

```sh
scripts/verify.sh
```

The verifier checks installer behavior, tool wrapper references, Codex agent metadata, operation/playbook layout, and root instruction size.

## Contributing

- Use Orchestra’s own process: non-trivial changes require a plan and explicit approval.
- Keep docs high-signal and update `.ai/docs/**` when behavior or conventions change.
- Keep memory durable: add only long-lived facts to `.ai/MEMORY.md`.
- Include verification notes in PRs: commands run, doc impact, and memory impact.
