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

Before delegating to a subagent, load relevant overlays from `.ai/overlays/`:

1. **Start with defaults** based on workflow type:
   - **Feature**: `value.md`, `system.md`, `ux.md`
   - **Refactor**: `system.md`, `security.md`
   - **Bug**: `system.md` (add `data.md` for DB issues, `security.md` for sensitive impact)
   - **Investigate**: `system.md`, `data.md` (add `security.md` for risk-sensitive topics)
   - **Document**: `value.md`, `ux.md`, `system.md`

2. **Adjust based on the task** — check if additional overlays apply:
   - `data.md`: data model, storage, analytics, DB changes
   - `security.md`: authn, authz, privacy, sensitive data, risk
   - `ux.md`: UI/UX changes, accessibility, i18n
   - `value.md`: business value, metrics, user impact
   - `system.md`: architecture, dependencies, integration

3. **Check for custom overlays** — users may add overlays to `.ai/overlays/` for repo-specific concerns (e.g., compliance, performance, legacy patterns).

Load with: read_file the overlay files from `.ai/overlays/` and include them in the delegation prompt.

Overlays are supporting context only. They can shape analysis, but they never replace workflow gates, approval requirements, or role boundaries.

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
