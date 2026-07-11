# Plan: Configure shipped subagent models and delegation controls

Date: 2026-07-11

## Goal
- Configure the shipped Codex and Claude Code subagents with the agreed model and reasoning/effort defaults.
- Restrict user-facing roles and delegation topology in the shipped Codex, Copilot, and OpenCode wrappers.

## Non-goals
- Do not change Claude Code's user-selection behavior; its native agent configuration has no supported direct-invocation restriction.
- Do not change canonical role instructions, sandbox/tool permissions unrelated to delegation, or the local `.codex/**` runtime fixture.
- Do not enable GPT-5.6 `ultra`, which conflicts with Forger's no-delegation contract.

## Scope + assumptions
- Edit only `src/tools/codex/**`, `src/tools/claude-code/**`, `src/tools/copilot/**`, `src/tools/opencode/**`, focused verification, `.ai/docs/**`, and `.ai/MEMORY.md`.
- The agreed allocation is: Conductor Luna/medium + Sonnet 5/medium; Planner Sol/high + Fable 5/high; Builder Terra/high + Sonnet 5/high; Validator Sol/high + Opus 4.8/high; Forger Sol/max + Fable 5/xhigh.
- Fable use is permitted only where its retention policy is acceptable; safety rerouting to Opus 4.8 is an expected fallback.
- Across Codex, Copilot, and OpenCode, only Conductor and Forger are user-invocable where the runtime supports that distinction; Planner, Builder, and Validator remain delegation-only.
- Subagent depth is one. At most one subagent may run at a time, and launching more than one subagent for a request requires the user's explicit approval before the additional launch.

## Steps
1. Confirm the current Codex custom-agent schema for a per-agent reasoning setting, then use its documented field name rather than assuming one.
2. Add the selected `model` and reasoning setting to each shipped Codex agent TOML in `src/tools/codex/.codex/agents/`; set `[agents]` to `max_threads = 1` and retain `max_depth = 1`.
3. Replace `model: inherit` and add `effort` in each shipped Claude Code agent frontmatter under `src/tools/claude-code/.claude/agents/`, retaining its existing direct-selection behavior, tools, and project memory.
4. In the Copilot wrappers, keep only Conductor and Forger `user-invocable`; make Planner, Builder, and Validator delegation-only, and remove their `agent` tool access so nested delegation is impossible.
5. In the OpenCode wrappers, retain Conductor as `all`, Forger as `primary`, and the other roles as `subagent`; deny task delegation outside Conductor and add the one-at-a-time and explicit-multiple-approval contract to the user-facing wrappers.
6. Add the same delegation contract to the Codex and Copilot user-facing wrappers; do not enable `multi_agent_v2` or any undocumented runtime flag.
7. Extend `scripts/verify-control-plane.sh` with exact role-to-model/effort assertions, user-invocation policy, agent-tool/task-denial checks, and Codex thread/depth limits; update stale assertions in `scripts/verify.sh`.
8. Update `.ai/docs/features/tool-wrappers.md` to document the model matrix, user-facing role policy, concurrency/approval rule, and Claude Code's native limitation.
9. Add one concise durable-fact entry to `.ai/MEMORY.md` for the shipped model and delegation-control defaults.
10. Review the resulting diff to ensure source templates—not local wrapper fixtures—are the only adapter definitions changed.

## Verification
- Run `scripts/verify-control-plane.sh`.
- Run `scripts/verify.sh` to cover TOML parsing, installer behavior, and adapter smoke checks.
- Run `git diff --check`.
- Confirm every role matches the allocation in Scope + assumptions, non-user-facing roles cannot nest-delegate, and the only parallelism limit is Codex's documented `max_threads = 1` control.

## Doc impact
- Update: `.ai/docs/features/tool-wrappers.md`.

## Rollback
- Revert the model/reasoning and delegation-control fields with their matching verification, documentation, and memory changes as one focused change.

## Approved amendment (2026-07-11)
- Rename the installer overwrite switch from `ORCHESTRA_INSTALL_FORCE=1` to presence-based `FORCE`.
- Remove support for the old variable, update all checked-in documentation and installer smoke tests, and verify any set `FORCE` value overwrites wrappers.
