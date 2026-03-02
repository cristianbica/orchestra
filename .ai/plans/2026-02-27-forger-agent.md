# Plan: Implement Forger agent (single, hat-switching, non-delegating)

Date: 2026-03-03

## Goal
- Add a new `Forger` agent that executes end-to-end work in one agent (phase hats, no subagent delegation) while preserving existing workflow gates and approval rules.

## Non-goals
- Do not implement product/app code.
- Do not remove existing agents (`Conductor`, `Planner`, `Builder`, `Validator`).
- Do not relax plan approval requirements for non-trivial changes.
- Do not redesign all workflows; only adjust workflow interactions needed to support `Forger`.

## Scope + assumptions
- Reuse this plan file as the approval artifact for the implementation phase.
- Follow canonical source conventions under `src/ai/` and `src/tools/`; implementation targets are `src/**` only for this change.
- `Forger` is additive and opt-in only: available as an all-in-one option when explicitly selected, not a forced replacement.
- Gate precedence remains unchanged: workflows and approved plans override overlays.

## Implementation artifacts in scope
- Agent definition:
  - `src/ai/agents/forger.md` (canonical behavior and constraints).
- Tool wrappers:
  - `src/tools/copilot/.github/agents/forger.agent.md`
  - `src/tools/claude-code/.claude/agents/forger.md`
  - `src/tools/codex/.codex/agents/forger.md`
  - `src/tools/opencode/.opencode/agents/forger.md`
- Workflow interaction docs (minimal updates):
  - `src/ai/agents/conductor.md` (routing rules for explicit opt-in selection of `Forger`).
  - `src/ai/agents/guides/delegation.md` (explicit carve-out for non-delegating `Forger` mode).
  - `src/ai/workflows/change.md` and optionally `investigate.md`/`guided.md` only where role references must include `Forger` path.
- Docs + memory hygiene:
  - update relevant `src/ai/docs/**` entries if agent model/conventions changed.
  - append one durable convention bullet to `.ai/MEMORY.md` if a stable `Forger` operating rule is introduced.

## Steps
1. Confirm acceptance criteria for `Forger` activation and coexistence policy (additive, opt-in only routing).
2. Add canonical `Forger` agent spec with strict constraints:
   - single-agent execution,
   - explicit phase/hat switches,
   - no subagent delegation,
   - unchanged gate enforcement.
3. Add `Forger` wrappers across supported tool templates (`copilot`, `claude-code`, `codex`, `opencode`) using existing wrapper style.
4. Update orchestration docs to describe `Forger` interaction points without weakening hard gates.
5. Update docs/memory artifacts required by changed behavior/conventions.
6. Run verification commands and publish `doc impact` + `memory impact` in closeout.

## Verification
- File presence checks:
  - `test -f src/ai/agents/forger.md`
  - `test -f src/tools/copilot/.github/agents/forger.agent.md`
  - `test -f src/tools/claude-code/.claude/agents/forger.md`
  - `test -f src/tools/codex/.codex/agents/forger.md`
  - `test -f src/tools/opencode/.opencode/agents/forger.md`
- Consistency checks:
  - `rg -n "Forger|forger" src/ai src/tools`
  - `rg -n "explicitly approved|approval" src/ai/agents src/ai/workflows`
- Installer sanity (if installer paths are touched):
  - `bash -n install.sh`
  - smoke install into temp dir with `SRC_DIR` and verify `Forger` files are copied.

## Doc impact
- `doc impact: updated` (agent/workflow conventions).
- Expected updates: agent/workflow docs that describe role routing and gate behavior.

## Memory impact
- Add one durable bullet to `.ai/MEMORY.md` only if implementation introduces a stable convention (for example, when `Forger` is allowed and which gates still apply).

## Approval gate
- Implementation must not start until this plan is explicitly approved by the user (`Approved`, `LGTM`, or equivalent).

## Rollback (if applicable)
- Remove `Forger` agent/wrapper files and revert orchestration/doc references in the same commit/PR.
