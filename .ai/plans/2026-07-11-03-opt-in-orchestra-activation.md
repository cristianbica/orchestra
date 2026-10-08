# Opt-in Orchestra activation

- Status: proposed, feasibility-reviewed (three passes); implementation requires explicit approval
- Date: 2026-07-11
- Route: `change` / framework behavior refactor
- Active overlays: `system`, `dx`, `integration`

## Goal

Installing Orchestra should enrich an AI tool's normal repository experience with
on-demand access to `.ai/docs/**`, without making Orchestra's roles, routes,
rules, gates, workflows, operations, playbooks, overlays, or reporting conventions
the default. Full Orchestra behavior becomes an explicit mode selected through a
native profile/agent or an unambiguous activation phrase.

## Evidence and constraints

- `src/ai/AGENTS.md` currently activates routing and points at the whole control
  plane. Codex and OpenCode actually discover the root `AGENTS.md`; their nested
  `.codex/AGENTS.md` and `.opencode/AGENTS.md` are not general root-session entry
  points. Claude loads `.claude/CLAUDE.md`, and Copilot loads its repository-wide
  instructions (and, depending on surface, root agent instructions).
- `install.sh` currently overwrites root `AGENTS.md`, copies engine directories,
  and preserves existing tool-wrapper files unless `FORCE` is set. A naive update
  would overwrite repo guidance on new installs but leave old always-on wrappers
  active on upgrades.
- Codex loads root `AGENTS.md` before work, supports project agents under
  `.codex/agents/`, and supports nested agents through `max_depth`. Project config
  cannot define/select profiles; profile files live in `$CODEX_HOME` and are
  selected with `--profile`. Sources: [AGENTS.md](https://developers.openai.com/codex/guides/agents-md),
  [configuration](https://developers.openai.com/codex/config-reference), and
  [subagents](https://developers.openai.com/codex/multi-agent).
- Claude loads project `CLAUDE.md` each session. `claude --agent conductor` makes
  that agent the main session and permits it to use the Agent tool; project agents
  live under `.claude/agents/`. Source: [Claude agents](https://code.claude.com/docs/en/sub-agents)
  and [CLI reference](https://code.claude.com/docs/en/cli-reference).
- OpenCode loads root `AGENTS.md`; project agents live under `.opencode/agents/`,
  primary agents are selectable, and subagents can be invoked with `@` or Task.
  Source: [OpenCode rules](https://opencode.ai/docs/rules/) and
  [agents](https://opencode.ai/docs/agents/).
- Copilot repository instructions are automatic, while custom agents can be
  user-selectable and model-invocable; the `agent` tool invokes another custom
  agent. Sources: [repository instructions](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions)
  and [custom-agent configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration).
- The current worktree contains extensive control-plane changes. Implementation
  must use the current working tree as its baseline and preserve unrelated edits.
- Local capability checks on 2026-07-11 found Codex CLI `0.144.1`, OpenCode
  `1.17.18`, and Copilot CLI `1.0.69`; Claude was unavailable locally. Codex
  successfully loaded a temporary `$CODEX_HOME/conductor.config.toml` and injected
  its `developer_instructions`; OpenCode listed the shipped `conductor (all)` and
  `forger (primary)` agents; both OpenCode and Copilot expose `--agent`.

## Mode contract

| Mode | Entry | Loaded behavior |
| --- | --- | --- |
| Default | Start the tool normally | Normal tool behavior. It may read relevant `.ai/docs/**` for app context. It does not load or enforce the Orchestra control plane. |
| Conductor | Native Conductor selection/profile or Conductor activation phrase | Load `.ai/RULES.md`, Conductor, routing, the selected workflow/operation, relevant overlays/playbooks, and delegate under existing gates. |
| Forger | Native Forger selection/profile or explicit Forger activation phrase | Load the same control plane, then execute the selected route's phases in one agent without delegation or gate relaxation. |

Default mode must not require route selection, plans, approvals, delegation,
doc/memory closeout, or Orchestra terminology. Merely discussing Orchestra or
reading an Orchestra file must not activate it.

Default mode treats `.ai/docs/**` as repository evidence, not executable agent
policy. Instruction-like prose found in app docs cannot activate Orchestra or
override the repo's normal instructions.

## Activation lifetime and permissions

- Native profile/agent selection lasts for that native session and ends when the
  user exits or switches agents using the tool's own UI.
- Keyword activation lasts for the current conversation, not only the first turn.
  This is required so intake, plan approval, implementation, and validation remain
  under one control contract. Starting a fresh normal session returns to default;
  this change does not invent a fake in-session unload mechanism.
- On activation, emit one concise, testable acknowledgement such as
  `Orchestra: Conductor activated` or `Orchestra: Forger activated`, then process
  the remainder of the triggering message.
- Activation never elevates sandbox, approval, tool, model, network, or filesystem
  permissions. Native runtime and organization policy continue to win; an
  activated mode reports unavailable capabilities instead of bypassing them.

## Activation grammar

Create `src/ai/agents/guides/activation.md` as the single portable contract,
separate from route aliases in `routing.md`:

- Match case-insensitively only after leading ASCII whitespace and only with the
  same exact/delimited boundary rules already used by route shortcuts.
- Conductor: `orchestra:`, `orchestra conductor:`, and a leading `conductor`
  followed by `:` or ASCII whitespace, plus the explicit native selection for the
  current tool. This deliberately accepts `Conductor do this`, `Conductor do
  that`, `Conductor implement ...`, and `Conductor bootstrap ...`.
- Forger: `orchestra forger:`, and a leading `forger` followed by `:` or ASCII
  whitespace, or explicit native Forger selection.
- The legacy leading phrase `run playbook` activates Conductor because it is an
  established, distinctive Orchestra entry point. Explicit slash forms also
  activate: `/bootstrap`, `/refresh-context`, `/create-overlays`,
  `/define-playbook`, and `/run-playbook`.
- Bare `bootstrap`, `refresh context`, `create overlay`, and `define playbook` do
  not activate Orchestra because they are plausible normal development requests.
  They route normally after an explicit `Conductor`, `Forger`, or `orchestra:`
  activation prefix.
- Generic lifecycle words and aliases (`change`, `document`, `investigate`,
  `feature`, `bug`, `refactor`, and similar) do not activate Orchestra by
  themselves. They regain their existing routing meaning after activation.
- Forger remains explicit-only; no inference from task size, desire for speed, or
  incidental mention may select it.
- For namespace/role activation, remove only the leading activator and delimiter;
  the remainder becomes the first task message. If no remainder exists, activate
  and ask for the task. For `run playbook` and slash-operation activation, retain
  the complete message because the matched words are also the route request. No
  user intent or operation name may be dropped.

## Adapter design

| Tool | Native full-mode entry | Keyword entry |
| --- | --- | --- |
| Codex | Install optional `$CODEX_HOME/conductor.config.toml` and `forger.config.toml`; run `codex --profile conductor` or `codex --profile forger`. | Root bridge spawns project `conductor`; project agent capacity allows Conductor to spawn one phase specialist. Explicit Forger activation spawns project `forger`. |
| Claude Code | `claude --agent conductor` or `claude --agent forger`. | The main session loads and assumes the selected canonical role. Do not depend on a subagent spawning nested phase agents; Conductor-as-main remains the recommended fully native path. |
| OpenCode | Select the Conductor or Forger primary agent, or run `opencode --agent conductor` / `opencode --agent forger`. | The current primary session assumes the selected canonical role, then Conductor invokes phase subagents directly. Do not add a default -> Conductor -> specialist nesting requirement. |
| Copilot | Select from the agent picker or run `copilot --agent Conductor` / `copilot --agent Forger`. | The current session assumes the canonical role and Conductor invokes phase agents directly. Do not model-invoke the Conductor or Forger custom agent for keyword dispatch. |

Adapters translate activation only. Canonical mode behavior remains in `.ai/**`;
tool wrappers must not duplicate routing tables or gates.

Native profile/agent selection is the deterministic path. Keyword activation is
prompt-dispatched by each tool's always-on repository guidance. The plan therefore
minimizes keyword-path nesting and tests compliance, but does not describe prompt
matching as a client-enforced hook.

A base install without a tool adapter provides the context-only root bridge and
portable inline activation instructions. Guaranteed named-role discovery,
tool-specific permissions, and documented native entry commands require installing
the matching supported adapter (`codex`, `claude-code`, `copilot`, or `opencode`).

## Always-on instruction topology

- Root `AGENTS.md` owns the portable context-only bridge and activation prefilter.
  Keep it short enough for every supported tool's normal instruction budget.
- Codex project config must stop assigning Conductor identity. Profiles and project
  custom-agent TOMLs load full-mode instructions; `.codex/AGENTS.md` becomes an
  on-demand adapter reference rather than an assumed root entry point.
- OpenCode relies on root `AGENTS.md` plus `.opencode/agents/**`; do not depend on
  `.opencode/AGENTS.md` being loaded when OpenCode starts at the repo root.
- Claude's `.claude/CLAUDE.md` imports or points to the root bridge and adds only
  Claude-native `--agent`/Agent mapping.
- Copilot's `.github/copilot-instructions.md` adds only Copilot-native mapping.
  Its path-specific `.github/instructions/ai.instructions.md` must not silently
  re-enable Orchestra merely because default mode reads or edits `.ai/**`.
- The root bridge contains only the cheap activation prefilter. It loads the full
  `activation.md` contract and control plane only after a candidate prefix matches.

## Implementation phases

1. **Canonical separation**
   - Replace distributed `src/ai/AGENTS.md` with a compact context-and-activation
     bridge: default docs access, activation grammar pointer, and explicit control-
     plane non-loading rules.
   - Add `activation.md`; adjust `routing.md`, Conductor, and Forger only where
     needed to define the handoff from activation to existing route intake.
   - Preserve all current route, approval, playbook, overlay, and role boundaries
     once a full mode is active.
   - Define activated-session persistence, the activation acknowledgement, prompt
     remainder transfer, and the rule that runtime permissions cannot be elevated.

2. **Tool adapters**
   - Implement the instruction topology above. Convert only files a tool actually
     loads into default-mode dispatchers; turn other adapter files into on-demand
     references and remove Codex's always-on Conductor `developer_instructions`.
   - Keep Planner, Builder, Validator, Conductor, and Forger agent definitions as
     full-mode wrappers. Make user visibility and invocation match the mode
     contract: Conductor user-selectable, Forger user-selectable but never inferred,
     and phase specialists delegation-only.
   - For Copilot, set both Conductor and Forger to
     `disable-model-invocation: true`; keyword mode runs inline while phase agents
     remain programmatically available to Conductor. This avoids accidental full-
     mode entry on ordinary requests.
   - For OpenCode, make Conductor and Forger `primary` agents and keep Planner,
     Builder, and Validator as subagents. Keyword mode runs inline in the current
     primary agent; native `--agent`/picker selection starts the dedicated role.
     Give native Conductor a `permission.task` map that denies `*` then allows only
     Planner, Builder, and Validator; Forger continues to deny Task entirely.
     Mark phase specialists `hidden: true` so OpenCode's normal picker emphasizes
     only the two user-facing modes while Task can still invoke them.
   - For Claude, narrow Conductor/Forger descriptions to explicit activation and
     prefer `--agent` for deterministic entry. Do not add an unverified permission
     deny or attempt to merge `.claude/settings.json` in shell. Claude has no
     Copilot-equivalent per-agent inference switch, so ordinary-prompt regression
     tests are mandatory and this limitation must be documented. When Conductor
     is the main `--agent`, use `Agent(planner, builder, validator)` rather than an
     unrestricted Agent tool; Forger exposes no Agent tool.
   - For Codex keyword nesting, set a bounded project capacity sufficient for
     default -> Conductor -> one specialist (expected `max_depth = 2` and no more
     than three open threads), then verify rather than assuming exact semantics.

3. **Codex profiles**
   - Add profile templates outside the normally copied project wrapper, under a
     dedicated `src/profiles/codex/` source path.
   - Extend installer syntax with explicit `codex --profiles`. Copy profiles to
     `$CODEX_HOME` only after this flag; never mutate user-global config during a
     normal repo install. Preserve collisions and require the dedicated
     `ORCHESTRA_PROFILE_FORCE=1` flag to replace them.
   - Profiles must fail clearly outside an Orchestra repo and must not embed
     project paths, models, credentials, providers, or approval-policy overrides.

4. **Safe installation and migration**
   - Preflight every managed entry path and profile collision before changing any
     file. A customized legacy always-on Orchestra wrapper is a blocking migration
     conflict: print the exact path and resolution choices, make no managed-entry
     changes, and exit non-zero rather than reporting a context-only install that
     is still always-on.
   - Treat existing symlinked instruction/profile targets as blocking conflicts;
     do not replace the symlink or mutate its referent implicitly. Preserve regular
     files' permission bits when staging replacements, and honor the user's umask
     for newly created files.
   - Stop blindly overwriting a pre-existing root `AGENTS.md`. Create it when
     absent; otherwise add/update a bounded `orchestra:context` managed block while
     preserving native repository instructions.
   - Apply equivalent managed-block handling to always-on tool instruction files.
     Use `<!-- orchestra:context:start v1 -->` and
     `<!-- orchestra:context:end -->` markers so future installs can update only
     Orchestra-owned text.
   - Treat multiple, nested, reversed, or unbalanced managed markers as blocking
     conflicts. Preserve surrounding repository text, final-newline state, and
     CRLF/LF style when adding or replacing a valid managed block.
   - Recognize exact known legacy Orchestra entry files from supported released
     baselines and migrate them only when `cmp -s` proves byte equality with a
     committed, immutable legacy fixture. Checksums may index fixtures but never
     authorize replacement. Never treat the uncommitted implementation baseline
     as a released migration source. A legacy signature without an exact byte
     match or managed block is the blocking conflict described above.
   - Keep repo-local `.ai/docs/**`, `.ai/playbooks/**`, `.ai/plans/**`, memory,
     custom agents, models, permissions, and tool configuration preservation rules.
   - Move current legacy cleanup and file-vs-directory collision handling behind
     preflight. The transaction covers every installer-owned write/removal in the
     run, including `.ai` engine refreshes, wrapper copies, legacy cleanup, managed
     blocks, and optional profiles; otherwise a late failure could leave a new
     bridge with a partial or old control plane.
   - Stage replacements beside their destinations so rename stays on the same
     filesystem. Keep a temporary manifest and byte-preserving backups; validate
     all staged files; apply only after preflight succeeds; on failure restore
     modified/removed paths and remove only run-created paths/directories. Report
     every created, updated, removed, preserved, rolled-back, and conflicted path.

5. **Self-hosting and documentation**
   - Update the framework repo's root/tool mirrors only after canonical `src/**`
     changes are correct, without overwriting unrelated dirty-worktree changes.
   - Update `README.md`, `.ai/docs/features/{installation,tool-wrappers,workflows}.md`,
     `.ai/docs/patterns/{agent-roles,context-budget}.md`, indexes, overview, and the
     generic `src/ai/docs/**` templates where installed repos need the concept.
   - Add one durable memory entry for the default/context-only versus activated
     control-plane invariant; prune first if memory approaches its size limit.

## Primary implementation surfaces

- Canonical engine: `src/ai/AGENTS.md`, `src/ai/agents/guides/{activation,routing}.md`,
  and narrowly required role/delegation files.
- Adapters: `src/tools/{codex,claude-code,copilot,opencode}/**` and Codex profiles
  under `src/profiles/codex/`; Copilot's path-specific
  `.github/instructions/ai.instructions.md` must also become default-mode-safe.
- Distribution/migration: `install.sh`, immutable byte-exact legacy entry fixtures
  under `src/migrations/`, and `scripts/{verify,verify-control-plane}.sh` plus an
  optional focused activation verifier.
- Product documentation: `README.md`, named `.ai/docs/**` files, matching generic
  `src/ai/docs/**` templates, and `.ai/MEMORY.md`.
- Self-hosted mirrors: root `AGENTS.md` and applicable `.codex/**`, `.claude/**`,
  `.github/**`, and `.opencode/**` files only after canonical sources pass checks.

## Verification strategy

- Static contract checks: default entry files contain docs-only and activation
  language but no mandatory route, plan, approval, role, or closeout rules.
- Activation fixtures: positive Conductor/Forger/operation prefixes, mixed case,
  leading whitespace, boundary cases, prompt-remainder preservation, and negative
  incidental/generic phrases. Bare `bootstrap`, `refresh context`, `create
  overlay`, and `define playbook` are required negative cases.
- Default-context fixtures: instruction-like text inside `.ai/docs/**` remains
  evidence rather than policy and cannot activate or override the root bridge.
- Installer matrix for all tools: empty repo, existing custom root instructions,
  exact legacy wrapper, customized legacy wrapper, reinstall, `FORCE`, file-vs-dir
  collisions, profile opt-in, profile collision, malformed/duplicate managed
  markers, LF, CRLF, no-final-newline, and simulated mid-update failure. Exact
  migration fixtures must pass `cmp`; near matches must block. Blocking conflicts
  leave every managed entry file byte-unchanged.
- Installer preservation fixtures: symlink targets block safely; regular file
  modes, surrounding bytes, final-newline state, and line endings survive managed
  block updates; injected failures after legacy cleanup and engine staging restore
  every pre-run path and remove only paths created by that run.
- Parse every TOML/YAML/frontmatter artifact and validate all referenced `.ai/**`
  paths. Keep source/mirror equality checks where mirrors are intentionally exact.
- Adapter permission checks: Claude native Conductor exposes only the three phase
  agent types; OpenCode hides phase agents and allows Conductor Task calls only to
  those types; Copilot cannot model-invoke Conductor/Forger but can invoke phase
  agents from an active Conductor; every Forger denies delegation.
- Codex smoke tests: normal prompt stays default; `orchestra:` invokes Conductor;
  nested Planner delegation fits configured limits; both profiles load; Forger is
  not inferred. Parse profile templates with the installed CLI using
  `codex --profile <name> debug prompt-input` when available, and inspect prompt
  input to prove normal startup no longer assigns Conductor identity.
- Claude smoke tests: normal prompt stays default; `--agent conductor` and Forger
  work as main sessions; keyword fallback activates without relying on unsupported
  nested delegation.
- OpenCode/Copilot smoke tests: `--agent` and picker/manual selection, inline
  keyword activation, phase-agent delegation visibility, and non-inference of
  Conductor and Forger on ordinary prompts. If a runtime is unavailable,
  distinguish schema/static evidence from native runtime evidence.
- Multi-turn behavioral tests: activation acknowledgement appears once, plan
  approval and later phases stay in the activated mode, and insufficient runtime
  permissions fail normally without an attempted elevation.
- Run `bash -n install.sh`, `scripts/verify-control-plane.sh`, and
  `scripts/verify.sh`; add a focused activation/installer verifier if keeping these
  concerns separate makes failures clearer.

## Acceptance criteria

- A normal session behaves like the unmodified tool except that relevant app docs
  are discoverable; no Orchestra gate appears without activation.
- Every supported tool has documented native Conductor and Forger entry points and
  keyword activation with an explicit adapter behavior.
- Base installation documents its inline fallback; full named-role isolation and
  native entry guarantees are claimed only when the matching adapter is installed.
- `orchestra: <task>` reaches Conductor; `run playbook: <slug>` activates and routes
  the operation; `Conductor <task>` activates and forwards `<task>` unchanged;
  explicit Orchestra slash operations activate; generic requests, bare operation
  words such as `bootstrap`, and non-leading mentions do not activate Orchestra.
- Keyword activation acknowledges the selected mode once and remains active across
  the conversation's intake, approval, implementation, and validation turns.
- Forger cannot be selected implicitly. All activated modes preserve current route
  and approval gates, and none can broaden native runtime permissions.
- Normal installation never writes user-global configuration, and Codex profile
  installation is a separate, collision-safe opt-in.
- Existing repo/tool instructions and customized wrappers survive installation;
  exact legacy Orchestra wrappers migrate, while customized legacy always-on
  wrappers block migration with actionable resolution instructions and no partial
  managed-entry update.
- Verification demonstrates both halves of the invariant: default remains normal,
  activated mode is fully Orchestra-enabled.

## Non-goals and risks

- Do not redesign workflows, route gates, playbook policy, overlays, role ownership,
  model selection, or approval policy as part of this change.
- Do not claim identical subagent nesting across tools; maintain semantic parity
  through adapter-specific dispatch and document reduced-capability fallbacks.
- Prompt keyword dispatch is behavioral guidance, not a client-enforced parser.
  Tests should measure compliance and keep native profile/agent selection as the
  deterministic entry for users who require guaranteed full mode.
- Claude and Codex do not expose the same checked per-agent inference disable used
  by Copilot. Their agent descriptions and root bridge must be narrowly scoped,
  and release evidence must include ordinary prompts that do not activate or spawn
  Orchestra roles. This remains a model-compliance risk, not a hard security gate.
- No in-session `orchestra off` command is introduced: prompts cannot reliably
  unload already-applied system/developer instructions. A new normal session, or a
  tool-native agent switch where supported, is the honest return to default.
- App docs are model-readable and therefore not a security boundary. The default
  bridge must explicitly label them as evidence, while existing tool sandbox and
  approval controls remain the enforcement layer.
- The principal migration risk is a mixed install where the root bridge is new but
  an old tool wrapper still forces Conductor. Release only when the installer can
  detect and report that state.

## Approval gate

Implementation may start only after explicit approval of this plan. Any later
decision to change activation phrases, write user-global profiles by default, or
redesign existing workflow gates requires a plan update and renewed approval.
