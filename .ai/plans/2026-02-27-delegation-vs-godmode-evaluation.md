# Plan: Evaluate delegation-first vs god-mode execution

Date: 2026-02-27

## Goal
- Determine how delegation (Conductor + subagents) affects speed and result quality compared with a single-agent "god mode" approach.

## Non-goals
- No framework behavior changes yet.
- No agent prompt rewrites during this plan.
- No conclusions based on anecdotes only.

## Scope + assumptions
- Plan artifact is in `.ai/plans/`; canonical framework artifacts remain under `src/`.
- Compare two operating modes:
  - **Mode A**: current system (Conductor + workflows + subagents + overlays).
  - **Mode B**: single agent + workflows + richer overlays ("hats").
- Evaluate across common task types: `trivial-change`, `investigate`, `change`.

## Steps
1. Define evaluation rubric and task buckets.
   - Buckets: trivial/local, moderate/known-entrypoint, complex/ambiguous.
   - Required metrics: time to first useful output, end-to-end completion time, rework count, first-pass validation rate, gate-compliance rate.
2. Build a matched task set (minimum 18 tasks, balanced across bug/feature/refactor/investigate).
3. Run baseline trials in **Mode A** using current workflow/gate policy.
4. Run comparison trials in **Mode B** with the same workflow gates preserved.
5. Score each run using one shared rubric and normalize by task complexity.
6. Produce a comparison report with:
   - median speed metrics,
   - quality/gate compliance deltas,
   - failure-mode analysis,
   - recommendation by task class.
7. Decide operating policy:
   - Keep delegation default, or
   - adopt hybrid routing rules (when to allow god mode).

## Verification
- Confirm each run records: task type, complexity, timestamps, mode, gate checks, review outcome.
- Verify equal task distribution across modes and no missing metrics.
- Ensure recommendation cites measured deltas, not opinion-only rationale.

## Decision criteria
- Prefer god mode for a task class only if:
  - median completion time improves by >= 20%, and
  - first-pass validation and gate compliance remain within 5% of delegation baseline.
- Keep delegation default if quality/gate drift exceeds thresholds.

## Doc impact
- `doc impact: deferred` until experiment results are available.
- If policy changes, update:
  - `src/ai/agents/conductor.md`
  - `src/ai/agents/guides/delegation.md`
  - relevant `src/ai/workflows/*.md`

## Rollback (if applicable)
- Not applicable (investigation plan only; no behavior changes in this plan).
