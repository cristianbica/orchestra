# Repository Rules

This file defines repo-local rules for agents.

## Binding syntax

Only bullets that start with `- MUST` or `- MUST NOT` are binding.
Other text is guidance.

- MUST load `.ai/RULES.md` when present.
- MUST treat only `- MUST` and `- MUST NOT` bullets as binding from `Global` + role section.

## Precedence

1. Selected route hard gates, approved plan, and role `NEVER` boundaries
2. This file (`.ai/RULES.md`)
3. Overlays and other soft guidance

Within this file, role sections override `Global` on conflict.

- MUST apply precedence: selected route hard gates + approved plan + role `NEVER` boundaries > `.ai/RULES.md` > overlays/soft guidance.
- MUST apply `.ai/RULES.md` precedence: role section overrides `Global` on conflict.
- MUST report any `.ai/RULES.md` rules ignored due to higher-precedence constraints.

## Global

- MUST keep changes within the user-approved scope.
- MUST confirm understanding of the user request/question and MUST NOT assume missing requirements; ask clarifying questions when anything is ambiguous.
- MUST NOT invent facts, outputs, or verification results.
- MUST NOT bypass required workflow gates.
- MUST select exactly one executable target route from `.ai/agents/guides/routing.md` and enforce that row's intake, writes, plan, approval, ownership, validation, and terminal contract; `guided` is only a modifier of that selected target.
- MUST treat shortcut aliases as intent classification only and MUST NOT use incidental substring matching or bypass the selected route's gates.
- MUST NOT perform writing git operations (e.g., `git stash`, `git commit`, `git restore`) unless the user explicitly requests them.
- MUST keep context lean: reference canonical files by path unless an excerpt is necessary for the task.
- MUST include "what not to load" in non-trivial delegation when broad folders or large files could waste context.
- MUST NOT inspect or load `.ai/plans/**` unless working from a specific plan for the active task, or the user explicitly asks to review existing plans.
- MUST, when working from a plan file, load only that active plan file and not neighboring, similarly named, or historical plans.

## Conductor

- MUST select and enforce the correct route before execution.
- MUST allow `direct answer` when its routing row applies.
- MUST NOT implement product code.
- MUST choose overlays by material task fit; default to no overlays for trivial/local work.

## Planner

- MUST ground plans in concrete evidence from the repository.
- MUST NOT implement product code.
- MUST limit writes to plan/report artifacts owned by the selected route.

## Builder

- MUST implement only after required plan approval is explicit.
- MUST implement only within the selected route's approved plan or planless requested scope.
- MUST run every applicable verification category and report explicit skips.

## Validator

- MUST NOT implement product/app code.
- MUST validate plan adherence when a plan is required; otherwise MUST validate requested scope plus diff and route evidence.
- MUST NOT approve changes that violate required gates.
- MUST limit self-authored changes to owned `.ai/docs/**` and `.ai/MEMORY.md` hygiene, except writes explicitly assigned by a selected operation.

## Forger

- MUST execute phases explicitly in order: discovery, plan creation, approval stop, implement, verify, closeout.
- MUST NOT delegate work to subagents in Forger mode.
- MUST, when explicitly selected, assume each route-named Planner, Builder, and Validator phase in order with only that phase's allowed writes.
