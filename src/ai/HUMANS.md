# Humans: how to work with Orchestra

Orchestra is the operating model for AI-assisted development in this repo, built around overlays, workflows, and role-based execution.

It exists to keep changes predictable: shared context in `.ai/`, explicit workflow boundaries, and specialization through overlays.

## Core operating loop

1. Start with `Conductor` and select a workflow.
2. For non-trivial work, `Planner` creates a plan artifact (inline for short plans; `.ai/plans/` file for larger plans).
3. Human explicitly approves the plan.
4. `Builder` implements only approved scope (or `Forger` if explicitly selected).
5. `Validator` checks correctness, plan adherence, and docs/memory hygiene.

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

You can define additional workflows for your repo when needed.

## Overlays

Overlays let you specialize agent guidance for your architecture, product domain, and risk profile without changing core workflows; they keep decisions contextual while preserving shared gates and consistency. Current built-in overlays include `value.md`, `ux.md`, `system.md`, `data.md`, `security.md`, `webdev.md`, `frontend.md`, `api.md`, `integration.md`, `devops.md`, `performance.md`, `testing.md`, `review.md`, `payments.md`, `privacy.md`, `dx.md`, `i18n.md`, `reliability.md`, and `mobile.md`. You can also define your own overlays for your repo.

## Conductor vs Forger

Use `Conductor` by default for larger or more involved tasks. Delegation keeps context focused per phase, improves gate discipline, and reduces context saturation that can increase hallucination risk.

Use `Forger` when you explicitly want faster single-agent execution for tightly scoped work. This can be quicker, but long or complex tasks can fill context faster and increase risk of drift.

## Precedence rules

- Workflows and workflow gates are highest priority.
- Roles execute inside the selected workflow.
- Overlays in `.ai/overlays/` are supporting context.
- Approved plans and workflow gates override overlays.

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

### Investigate (timeboxed, read-only by default)

```
User: Conductor investigate: figure out why billing exports are slow

Conductor: asks 1–3 intake questions (question, references, constraints + timebox)
Planner: investigates and writes an evidence-backed report in .ai/plans/
Conductor: confirms recommended handoff to change / document
```

### Fix a bug

```
User: Conductor fix bug: API returns stale cached data

Conductor: intake questions (expected vs actual, repro, evidence)
Planner: writes a fix plan
Builder: implements the fix
Validator: verifies the change matches the plan and docs/memory gates
```

### Refactor code (plan gate enforced)

```
User: Conductor refactor: clean up user authentication flow
Conductor: asks 1–3 intake questions
Planner: writes a refactor plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Validator: reviews for correctness + plan adherence and updates docs/memory as needed
```

### Fix a security issue (plan gate enforced)

```
User: Conductor fix security issue: patch vulnerable dependency
Conductor: asks 1–3 intake questions (vulnerability details, repro, evidence)
Planner: writes a security fix plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Validator: reviews for correctness + plan adherence and updates docs/memory as needed
```

### Update documentation

```
User: Conductor document: update API docs for user endpoints
Conductor: asks 1–3 intake questions (target doc, audience/intent, source of truth)
Validator: updates docs based on intake answers
```

### Refresh context

```
User: Conductor refresh context
Conductor: routes to Validator to execute refresh plan
Validator: executes context refresh plan in .ai/plans/02-refresh-context.md
```

### Trivial change (no plan required)

```
User: Conductor trivial-change: fix typos in docs

Conductor: confirms wording-only scope
Builder: applies minimal doc edit
Validator: quick spot-check
```
