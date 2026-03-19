# Delegation (agent guide)

This guide helps prevent “doing everything in one thread” by making delegation an explicit default.

## Core rule

Conductor should **delegate by default** for discovery, research, and planning.
Conductor’s main job is to mediate between the user and agents, not to execute specialist work inline.

Conductor must never implement product code, even when the user asks for immediate implementation.
If a user request includes implementation language ("implement", "patch", "write code", "just do it"), Conductor routes to the correct workflow and delegates to Builder only after required plan approval.

Do docs-first triage (`.ai/docs/overview.md` → docs indexes → `.ai/MEMORY.md`), then delegate targeted discovery instead of running repo-wide investigation inline.

When working on a plan, never create a new plan unless the user explicitly asks.

Delegation reduces context thrash, keeps roles clean, and makes it less likely to forget gates (plan approval, verification, doc/memory hygiene).

Default decision policy: if it is unclear whether to delegate or proceed inline, delegate.

## Routing tree

Use this sequence to decide how far to push inline work before delegating:

1. If the request is trivially local and the target file/entry point is already known, do the smallest inline search needed to confirm the spot.
2. If the entry point is unclear, the work spans multiple files, or tradeoffs need to be compared, delegate to `Planner` for read-only investigation and a plan.
3. If implementation is needed and the work is not `trivial-change`, do not start code changes until there is an explicitly approved plan artifact.
4. If the work can be split into independent slices, delegate those slices in parallel, but keep each slice within the same workflow gate and ownership model.

## Ownership handoffs

- `Planner` plans after read-only exploration.
- `Builder` implements only after approval.
- `Validator` verifies with commands and checks the gates.
- `Conductor` routes, coordinates, and preserves the boundary between workflow phases.

## Forger carve-out (explicit opt-in)

`Forger` is a special, additive mode for single-agent execution.

- Use `Forger` only when the user explicitly requests Forger/single-agent mode.
- In Forger mode, do not subdelegate; execute phases in one thread with explicit mode switches.
- Plan approval gates remain unchanged: non-trivial implementation still requires an explicitly approved plan.
- If Forger is not explicitly selected, use normal delegation (Planner/Builder/Validator) defaults.

## When to delegate (triggers)

Delegate when any of these are true:
- You need a **multi-step plan** or trade-off analysis.
- You need to **scan/search** many files to find the right starting point.
- The request is **ambiguous** and needs targeted clarifying questions.
- You’re doing **two different modes** of work (e.g. research + implementation).
- You need a **timeboxed investigation** to reduce uncertainty before planning.
- File/entrypoint is unknown and requires repo-wide discovery.

Don’t delegate when:
- The change is trivially small and local.
- You already have the exact file + approach and only need to apply it.
- No broad search is required beyond quick docs-first checks.

Even in "don’t delegate" cases, Conductor still must not implement product code; delegate implementation to Builder.

## Role mapping

Within this repo’s framework:
- Conductor: orchestrates + enforces gates (no product code)
- Planner: investigation + planning (evidence, options, executable plan)
- Builder: implementation only (after plan approval)
- Validator: review + docs/memory hygiene

If work falls into investigation, planning, implementation, or review, it should be assigned to the corresponding specialist role.

## Practical “how” (Copilot)

If your runtime supports subagents (or an equivalent delegation tool), use it explicitly.

### Overlay loading (before delegating)

Before delegating to a subagent, make an explicit overlay decision and load any selected overlays from `.ai/overlays/`:

1. **Inspect what exists** in `.ai/overlays/` before choosing anything. This is required for non-trivial delegated handoffs. Do not assume the built-in overlays are exhaustive.

2. **Choose by material fit** based on the workflow, task, plan, and repo context:
  - start with the smallest set that clearly matters;
  - prefer repo-specific overlays when they fit better than general-purpose ones;
  - consider whether the task mainly needs repo-local orientation, broader uncertainty reduction across multiple evidence sources, or failure analysis grounded in runtime signals;
  - skip overlays that do not change the work or review criteria in a meaningful way.

3. **Check for custom overlays** — users may add overlays to `.ai/overlays/` for repo-specific concerns, constraints, or patterns.

Load with: read_file the selected overlay files from `.ai/overlays/` and include them in the delegation prompt.

Only include overlays that materially apply. If you cannot explain why an overlay matters in one line, do not include it.

For non-trivial delegated work, `Active overlays` must never be omitted. You must either:
- name one or more overlays with one-line reasons, or
- write `Active overlays: none` with a task-specific reason why no overlay materially changes the work.

Overlays are supporting context only. They can shape analysis, but they never replace workflow gates, approval requirements, or role boundaries.

### Required handoff contract

For any non-trivial delegated handoff, include this structure near the top of the prompt:

- `Workflow:` `<workflow name>`
- `Active overlays:`
  - `<overlay name>` — `<one-line reason>`
  - Repeat only for overlays that materially apply.
  - If none apply, write `none` — `<task-specific reason>`
- `Relevant docs:` `<paths or none>`
- `Code context:` `<paths or excerpts>`
- `Ask:` `<single explicit request>`

If overlays are intentionally omitted for `trivial-change` or another tightly local task, write `Active overlays: none` with a brief reason instead of an empty list.

Conductor chooses the initial overlays for delegated work. The receiving agent may refine that set only when task evidence justifies it, and should say why briefly when doing so.

Keep the `Active overlays` block lean. Name the overlays and give one-line justification; do not paste overlay contents into the handoff unless the downstream agent truly needs an excerpt.

### Minimum delegation pattern
1. Conductor delegates planning/research.
2. Conductor returns a crisp next step + assigns the right role.

### Copy/paste prompt patterns

- Planning:
  - “Use a planner subagent to investigate briefly, then produce a scannable plan with assumptions + verification.”

- Repo discovery:
  - “Use a subagent to locate the relevant files/entry points and summarize findings.”

- Review:
  - “Use a validator subagent to check plan adherence + doc/memory gates and apply required docs updates.”

## If subagents are unavailable

Simulate delegation by forcing phases:
- Phase A (Discovery): gather context + identify files
- Phase B (Plan): write plan only
- Phase C (Implement): apply smallest diff
- Phase D (Verify): run commands + report

Never mix phases without explicitly stating the mode switch.
