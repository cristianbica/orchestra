# Plan: Enforce Downstream Overlay Visibility in Delegation

Date: 2026-03-19

## Goal
- Ensure Orchestra-installed downstream repos explicitly select, load, and surface active overlays during non-trivial delegation and planning handoffs.
- Make overlay usage visible enough that Conductor-to-Planner and later delegated handoffs do not silently drop overlay context.
- Preserve the current precedence model: workflow gates and approved plans still override overlays.

## Non-goals
- No changes to overlay contents in `src/ai/overlays/`.
- No installer behavior changes unless verification proves distribution is broken.
- No new workflow types, no plan-gate changes, and no product-code implementation.
- No blanket requirement to apply overlays to `trivial-change` or tiny local edits.

## Scope + assumptions
- Canonical changes belong in `src/ai/**` and `src/tools/**`, because `install.sh` already copies `src/ai/` plus the selected tool wrapper into downstream repos.
- The current gap is prompt enforcement, not overlay file availability: `src/ai/agents/conductor.md` and `src/ai/agents/guides/delegation.md` mention overlays, but wrapper prompts do not require a visible handoff contract.
- Existing wrapper files are intentionally thin, so a small but explicit overlay-handoff rule must be added in multiple layers: canonical agent/workflow guidance plus tool-specific wrapper prompts.

## Evidence summary
- `install.sh` already distributes `src/ai/*` and the selected `src/tools/<tool>/*`, so downstream behavior is driven by prompt content, not missing files.
- `src/ai/agents/conductor.md` says to include relevant overlays for delegated work, but it does not require a named `Active overlays` section in the handoff.
- `src/ai/agents/guides/delegation.md` says to read overlay files and include them in the delegation prompt, but it does not define a required handoff format or a `none` path for low-scope work beyond general guidance.
- `src/ai/workflows/change.md`, `src/ai/workflows/investigate.md`, and `src/ai/workflows/document.md` define overlay defaults, but they do not require those overlays to be surfaced in delegated prompts or plan outputs.
- Tool wrappers under `src/tools/copilot/`, `src/tools/claude-code/`, `src/tools/codex/`, and `src/tools/opencode/` mostly say to follow canonical files; they do not add tool-specific enforcement that the delegation message must name active overlays.
- Existing plan `.ai/plans/2026-02-26-overlay-integration.md` improved overlay loading guidance, but not downstream visibility or handoff enforcement.

## Exact source files to change
- `src/ai/agents/conductor.md`
- `src/ai/agents/planner.md`
- `src/ai/agents/guides/delegation.md`
- `src/ai/agents/guides/context-management.md`
- `src/ai/workflows/change.md`
- `src/ai/workflows/investigate.md`
- `src/ai/workflows/document.md`
- `src/tools/copilot/.github/copilot-instructions.md`
- `src/tools/copilot/.github/agents/conductor.agent.md`
- `src/tools/copilot/.github/agents/planner.agent.md`
- `src/tools/claude-code/.claude/CLAUDE.md`
- `src/tools/claude-code/.claude/agents/conductor.md`
- `src/tools/claude-code/.claude/agents/planner.md`
- `src/tools/codex/.codex/AGENTS.md`
- `src/tools/codex/.codex/agents/conductor.md`
- `src/tools/codex/.codex/agents/planner.md`
- `src/tools/opencode/.opencode/AGENTS.md`
- `src/tools/opencode/.opencode/agents/conductor.md`
- `src/tools/opencode/.opencode/agents/planner.md`

## Enforcement recommendation
- Put enforcement in multiple layers.
- Canonical agent and workflow prompts should define the policy and the required handoff shape.
- Wrapper prompts should restate the minimum enforcement needed for each runtime so installed downstream repos preserve the behavior even when the runtime strongly weights local wrapper text.
- Do not rely on wrapper prompts alone: they are too thin today and can drift from canonical behavior.

## Steps
1. Define a required overlay-handoff contract in the canonical prompt sources.
   - Update `src/ai/agents/conductor.md` to require that any non-trivial delegated handoff includes an `Active overlays` section.
   - Require the section to contain: selected workflow, overlay names, overlay file paths loaded, and a one-line reason for each overlay or overlay group.
   - Require an explicit `Active overlays: none` line for `trivial-change` and other tightly local tasks where overlays are intentionally not applied.

2. Make active overlays visible in planning outputs, not just delegation messages.
   - Update `src/ai/agents/planner.md` so plan artifacts include a short `Active overlays` line or section when overlays shaped the plan.
   - Update `src/ai/workflows/change.md`, `src/ai/workflows/investigate.md`, and `src/ai/workflows/document.md` so overlay defaults are paired with a requirement to surface them in the delegated prompt and resulting plan/report.
   - Keep the plan format lean: list overlay names plus why they apply, not full overlay contents.

3. Tighten the delegation and context-packing guides around overlay packaging.
   - Update `src/ai/agents/guides/delegation.md` with a concrete handoff template such as: workflow, active overlays, relevant docs, code context, ask.
   - Update `src/ai/agents/guides/context-management.md` to place active overlays in the durable-instructions block before task-specific code excerpts and before the final ask.
   - Explicitly say that custom overlays in `.ai/overlays/` should be included only when they materially apply.

4. Keep overlays from being over-applied.
   - Preserve `trivial-change` default behavior: no overlays by default.
   - Add a narrow rule in canonical prompts: for local wording, formatting, or obvious single-file tasks, omit overlays unless the user or task explicitly invokes a risk/domain concern.
   - Require a justification threshold for additional overlays beyond workflow defaults: if the prompt cannot explain why the overlay matters, do not include it.

5. Align each installed-tool wrapper with the canonical handoff contract.
   - In Copilot wrappers, explicitly require conductor/planner delegation text to name `Active overlays` and follow the delegation guide.
   - In Claude Code wrappers, add the same requirement to the project instructions and conductor/planner wrappers so subagent requests visibly carry overlay context.
   - In Codex wrappers, update the `spawn_agent` guidance so the message payload explicitly includes `Active overlays` and loaded file paths.
   - In OpenCode wrappers, mirror the same handoff contract in the project instructions and conductor/planner wrappers.
   - Keep wrapper changes minimal and tool-specific: they should reinforce, not redefine, the canonical policy.

6. Verify downstream-installed behavior with installation-level checks.
   - Create temporary repos and install from local source with `SRC_DIR` for each tool: `copilot`, `claude-code`, `codex`, `opencode`.
   - Confirm the installed `.ai/agents/conductor.md`, `.ai/agents/planner.md`, `.ai/agents/guides/delegation.md`, and tool wrapper files contain the `Active overlays` handoff contract.
   - Confirm no installer changes were required unless a temp install proves otherwise.

## Exact verification steps
- Static prompt checks:
  - `rg -n "Active overlays|overlay file paths|trivial-change|include only when explicitly useful" src/ai src/tools`
  - `rg -n "spawn_agent|subagent|delegate" src/tools/codex src/tools/claude-code src/tools/copilot src/tools/opencode`
- Downstream install checks:
  - `tmpdir=$(mktemp -d)`
  - `cd "$tmpdir"`
  - `SRC_DIR=/home/cristi/Projects/bcd/ai bash /home/cristi/Projects/bcd/ai/install.sh copilot`
  - Repeat for `claude-code`, `codex`, and `opencode` in separate temp dirs.
  - After each install, run `rg -n "Active overlays|overlay file paths" .ai .github .claude .codex .opencode`
- Scope checks:
  - Confirm `install.sh` is unchanged unless installation verification demonstrates a real distribution gap.
  - Confirm `src/ai/workflows/trivial-change.md` remains unchanged unless the implementation needs a one-line clarification to preserve the no-overlay default.

## Doc impact
- `updated`
- Limit documentation changes to operational guidance that affects downstream users of Orchestra prompts:
  - `src/ai/agents/guides/delegation.md`
  - `src/ai/agents/guides/context-management.md`
- Avoid a broad docs sweep unless implementation uncovers a real mismatch in user-facing framework docs.

## Memory impact
- `none` expected.
- Only update memory if implementation establishes a durable repo convention such as a permanent required `Active overlays` handoff block across all wrappers.

## Rollback
- Revert only the touched prompt and wrapper files under `src/ai/**` and `src/tools/**`.
- Re-run the static grep checks and one temp install per tool to confirm the repo returned to the prior behavior.
