# Feature: Tool Wrappers

## What they are

The optional templates under `src/tools/` translate Orchestra roles into each
tool's native configuration shape. Canonical route and role policy remains in
`.ai/agents/guides/routing.md` and `.ai/agents/**`; wrappers must stay thin and
must not maintain a competing route list.

## Template capabilities

| Wrapper | Relevant declared capability |
| --- | --- |
| [Codex](../../../src/tools/codex/) | Planner uses a writable sandbox so it can persist route-owned `.ai/plans/**` artifacts; canonical role rules still prohibit product implementation |
| [Claude Code](../../../src/tools/claude-code/) | Conductor declares the native `Agent` delegation tool; always-on guidance accepts inline or file plans |
| [Copilot](../../../src/tools/copilot/) | Planner accepts inline or file plans; Forger is user-invocable but disables model invocation and declares no delegation tool |
| [OpenCode](../../../src/tools/opencode/) | Validator may request edits only for `.ai/docs/**` and `.ai/MEMORY.md`; Forger denies task delegation and remains explicit opt-in |

Other wrapper structure remains tool-specific:

- Codex uses `.codex/agents/*.toml` custom agents and a compact conductor entry.
- Claude Code uses `CLAUDE.md` plus project agents; no project skills are assumed.
- Copilot uses global instructions, path-specific instructions, and custom agents.
- OpenCode uses agent frontmatter permissions to translate write and delegation
  boundaries.

## Shipped subagent defaults

| Role | Codex | Claude Code |
| --- | --- | --- |
| Conductor | `gpt-5.6-luna` / `xhigh` | `claude-sonnet-5` / `medium` |
| Planner | `gpt-5.6-sol` / `high` | `claude-fable-5` / `high` |
| Builder | `gpt-5.6-terra` / `xhigh` | `claude-sonnet-5` / `high` |
| Validator | `gpt-5.6-sol` / `high` | `claude-opus-4-8` / `high` |
| Forger | `gpt-5.6-sol` / `high` | `claude-fable-5` / `xhigh` |

The five Codex agent TOMLs under `src/tools/codex/` are the distributed source;
their repository-local `.codex/agents/` counterparts must remain byte-identical.

Codex, Copilot, and OpenCode expose only Conductor and opt-in Forger to users;
the other roles are delegation-only. Codex caps delegation at one active
subagent and depth one. Copilot and OpenCode instruct user-facing roles to seek
explicit approval before a second subagent for the same request. Claude Code
does not provide a native restriction on direct custom-agent selection, so its
user-selection behavior remains unchanged. Fable use requires acceptance of its
retention policy and may route safety-sensitive work to Opus 4.8.

These statements describe the checked-in templates and repository semantic
checks. Native runtime discovery is separate evidence; do not treat template
inspection as proof that a locally unavailable Claude Code or Copilot runtime
loaded the configuration.

## Installation boundary

Installer behavior is unchanged by the control-plane consistency work. See the
installation page for copy and overwrite behavior rather than inferring it from
role capabilities.

## See also

- [installation](installation.md)
- [agent roles](../patterns/agent-roles.md)
- [workflow routes](workflows.md)
