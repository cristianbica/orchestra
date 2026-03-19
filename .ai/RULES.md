# Repository Rules

This file defines repo-local rules for agents.

## Binding syntax

Only bullets that start with `- MUST` or `- MUST NOT` are binding.
Other text is guidance.

- MUST load `.ai/RULES.md` when present.
- MUST treat only `- MUST` and `- MUST NOT` bullets as binding from `Global` + role section.

## Precedence

1. Workflow hard gates, approved plan, and role `NEVER` boundaries
2. This file (`.ai/RULES.md`)
3. Overlays and other soft guidance

Within this file, role sections override `Global` on conflict.

- MUST apply precedence: workflow hard gates + approved plan + role `NEVER` boundaries > `.ai/RULES.md` > overlays/soft guidance.
- MUST apply `.ai/RULES.md` precedence: role section overrides `Global` on conflict.
- MUST report any `.ai/RULES.md` rules ignored due to higher-precedence constraints.

## Global

- MUST keep changes within the user-approved scope.
- MUST confirm understanding of the user request/question and MUST NOT assume missing requirements; ask clarifying questions when anything is ambiguous.
- MUST NOT invent facts, outputs, or verification results.
- MUST NOT bypass required workflow gates.
- MUST NOT perform writing git operations (e.g., `git stash`, `git commit`, `git restore`) unless the user explicitly requests them.
- MUST treat `src/**` as the canonical editable source for distributed template changes in this repository.
- MUST limit edits under `.ai/**` to `.ai/docs/**`, `.ai/plans/**`, `.ai/MEMORY.md`, and `.ai/RULES.md` unless the user explicitly requests a different `.ai/**` path.
- MUST NOT edit `.ai/agents/**`, `.ai/workflows/**`, `.ai/templates/**`, or `.ai/HUMANS.md` unless the user explicitly requests it.
- MUST NOT edit top-level tool wrapper or agent-control directories such as `.claude/**`, `.github/**`, `.codex/**`, `.opencode/**`, or similar hidden runtime/tooling directories unless the user explicitly requests it.

## Conductor

- MUST select and enforce the correct workflow before execution.
- MUST NOT implement product code.

## Planner

- MUST ground plans in concrete evidence from the repository.
- MUST NOT implement product code.

## Builder

- MUST implement only after required plan approval is explicit.
- MUST NOT expand scope beyond the approved plan.

## Validator

- MUST validate plan adherence, scope, and required hygiene gates.
- MUST NOT approve changes that violate required gates.

## Forger

- MUST execute phases explicitly in order: discovery, plan check, implement, verify, closeout.
- MUST NOT delegate work to subagents in Forger mode.
