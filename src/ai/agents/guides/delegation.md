# Delegation (agent guide)

This guide helps prevent “doing everything in one thread” by making delegation an explicit default.

## Core rule

If the task has a meaningful planning or research component, **delegate early**.

Delegation reduces context thrash, keeps roles clean, and makes it less likely to forget gates (plan approval, verification, doc/memory hygiene).

## When to delegate (triggers)

Delegate when any of these are true:
- You need a **multi-step plan** or trade-off analysis.
- You need to **scan/search** many files to find the right starting point.
- The request is **ambiguous** and needs targeted clarifying questions.
- You’re doing **two different modes** of work (e.g. research + implementation).

Don’t delegate when:
- The change is trivially small and local.
- You already have the exact file + approach and only need to apply it.

## Role mapping

Within this repo’s framework:
- Conductor: orchestrates + enforces gates (no product code)
- Architect: planning only
- Builder: implementation only (after plan approval)
- Inspector: review only
- Archivist: docs + memory hygiene

## Practical “how” (Copilot)

If your runtime supports subagents (or an equivalent delegation tool), use it explicitly.

Minimum delegation pattern:
1. Conductor delegates planning/research.
2. Conductor returns a crisp next step + assigns the right role.

### Copy/paste prompt patterns

- Planning:
  - “Use a planning subagent to produce a scannable plan with assumptions + verification.”

- Repo discovery:
  - “Use a subagent to locate the relevant files/entry points and summarize findings.”

- Review:
  - “Use a review subagent to check plan adherence + doc/memory gates.”

## If subagents are unavailable

Simulate delegation by forcing phases:
- Phase A (Discovery): gather context + identify files
- Phase B (Plan): write plan only
- Phase C (Implement): apply smallest diff
- Phase D (Verify): run commands + report

Never mix phases without explicitly stating the mode switch.
