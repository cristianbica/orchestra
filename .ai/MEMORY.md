# Memory (curated)

Max ~200 lines. Prune oldest/least-used when full. One agent updates per session to avoid conflicts.

## Commands (verified)

This is a template distribution repo. No traditional build/test/lint commands apply.

- **Install**: `bash ./install.sh [tool-name]` - Copy `src/ai/` into `.ai/` and an optional tool wrapper (verified by temporary installer smoke tests)
- **Installer syntax check**: `bash -n install.sh` - Validate installer shell syntax without executing it
- **App checks**: No app-specific build, test, or lint commands (template repository)
- **Focused control-plane verification**: `scripts/verify-control-plane.sh` - Checks route, role, operation, playbook, and adapter contracts
- **Repo verification**: `scripts/verify.sh` - Runs focused control-plane checks plus installer/adapter smoke checks, structured Codex TOML checks, and instruction budgets

## Conventions

- **Development workflows**: `document`, `investigate`, `change`, `trivial-change`
- **Workflow wrapper**: `guided` (step-by-step wrapper over target workflows or operations)
- **Operations**: `bootstrap`, `refresh-context`, `create-overlays`, `define-playbook`, `run-playbook`
- **Plan files**: `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md` (dated, index-ordered, descriptive slug)
- **Doc files**: `.ai/docs/{overview,features,patterns,templates}/`
- **Agent roles**: Conductor, Planner, Builder, Validator, and opt-in Forger (strict boundaries)
- **Built-in overlays**: Select available overlays by material task fit; overlays never replace route gates
- **Overlay precedence**: workflow gates, operation gates, and approved plans override overlays
- **Routing/gate ownership**: The template contract lives in `src/ai/agents/guides/routing.md` and installs as `.ai/agents/guides/routing.md`; adapters reference it rather than duplicating policy
- **Approval**: Plans, previews, and invocation approvals are route-specific; only routes whose matrix row requires approval receive that gate
- **Planning / verification**: Planner product/source discovery is read-only while route-owned plans/reports may be written; Builder runs every applicable verification category, and Validator verifies adversarially with command-backed evidence
- **Playbooks**: Reusable procedures live in `.ai/playbooks/`; `define-playbook` operation creates/updates them, `run-playbook` operation executes them, and stricter playbook approval gates win when policies overlap
- **Quality-test playbook**: Automatically selects a public merged Ruby PR with bounded `bundle install` and no external-service requirement; after exact-command approval it compares direct clean-room vanilla implementation with bootstrapped Orchestra plan-then-implement runs, supports one optional `orchestra-<ref>`, excludes bootstrap metrics, inspects actual last, and uses explicit unattended Codex/OpenCode/Claude/Copilot commands
- **Core rules**: Orchestra changes must preserve controllable flow, context-aware development, token economics, tool portability, and evidence-based trust
- **Memory**: Only durable facts (commands, conventions, invariants, layout); max ~200 lines total
- **Canonical sources**: `src/ai/` + `src/tools/` are the template sources when present
- **Context budget**: Keep always-on context lean; load roles/workflows/operations/overlays/docs on demand; load `.ai/plans/**` only for the active plan or explicit plan-review requests; non-trivial handoffs include `Active overlays` and `Do not load`
- **Prompt compaction**: Reduce cost through smaller prompts, phased handoffs, and role-specific context
- **Codex adapter**: `.codex/config.toml` carries the minimal Orchestra conductor identity inline; project custom agents are standalone `.codex/agents/*.toml` files with `name`, `description`, and `developer_instructions`; `[agents]` config defaults to `max_threads = 1`, `max_depth = 1`
- **Shipped agent defaults**: Codex uses Luna/xhigh for Conductor, Terra/xhigh for Builder, and Sol/high for Planner/Validator/Forger; its five repository-local agent TOMLs byte-match `src/tools/codex/.codex/agents/`; Claude uses Sonnet 5 for Conductor/Builder, Fable 5 for Planner/Forger, and Opus 4.8 for Validator.
- **Delegation approvals**: Conductor does not ask for separate user permission just to delegate to subagents; normal plan, destructive-command, playbook, production/external, and sensitive-data approval gates still apply
- **Docs source of truth (this repo)**: `.ai/docs/**` is canonical project context; `src/ai/docs/**` is boilerplate template content
- **Repo editing policy (this repo)**: Edit only `.ai/docs/`, `.ai/plans/`, `.ai/MEMORY.md`; never edit `.ai/agents/`, `.ai/workflows/`, `.ai/templates/`, `.ai/HUMANS.md`; treat `src/` as canonical and keep it generic (distributed)

## Invariants (non-negotiable)

1. **NEVER implement outside Builder ownership** - Conductor, Planner, and Validator do not implement product/app code; opted-in Forger implements only during its Builder phase
2. **NEVER bypass the selected route's gate** - `change` requires an approved inline/file plan; `document`, `investigate`, and `trivial-change` are planless; `bootstrap` and `refresh-context` use approved per-run previews
3. **NEVER bypass doc hygiene** — Every task must state `doc impact: updated | none | deferred`
4. **NEVER bypass memory hygiene** — Only durable, reusable facts; keep under ~200 lines
5. **ALWAYS ground specialist work first** - Read relevant `.ai/docs/**`; load only the active plan when one exists, and do not invent plans for planless routes
6. **ALWAYS verify commands before documenting** - Record observed command results and label unavailable or unverified checks explicitly

## Repo layout

**Two-tier structure**:
1. **`src/ai/`** — Canonical authoring source (this template repo)
   - Contains definitions: agents, workflows, operations, docs, plans
   - Distributed via `install.sh` to user repos

2. **`.ai/`** — Canonical in installed user repos
   - Copied from `src/ai/` during installation
   - User repos edit `.ai/` directly; never touch `src/ai/`
   - In this template repo, `.ai/` is a mirror of `src/ai/`

**Key directories**:
- `.ai/agents/` - Conductor, Planner, Builder, Validator, and Forger definitions
- `.ai/agents/guides/` - canonical routing plus delegation and context-management principles
- `.ai/workflows/` — document, investigate, change, trivial-change, guided
- `.ai/operations/` — bootstrap, refresh-context, create-overlays, define-playbook, run-playbook
- `.ai/playbooks/` — repo-local reusable procedures such as Orchestra validation
- `.ai/plans/` — approval/execution artifacts created during work
- `.ai/docs/` — Framework documentation (overview, features, patterns)
  - **In user repos**: Customize these docs to describe YOUR app
- `.ai/MEMORY.md` — Curated facts about this framework/repo (commands, conventions, invariants)

**Tool integrations**:
- `src/tools/copilot/`, `src/tools/claude-code/`, `src/tools/opencode/`, `src/tools/codex/` — Tool-specific wrappers

## Business domains / Conceptual domains

**Not applicable** — This is a framework/template repo, not a domain application.

**Conceptual areas:**
- **Agent orchestration** — Conductor role, workflow routing, plan gates
- **Planning & architecture** — Planner role, discovery patterns, plan structure
- **Implementation** — Builder role, minimal changes, verification
- **Validation + documentation** — Validator role, verification, plan adherence, docs/memory hygiene

## Discovered quirks & notes

- 2026-02-10: `.ai/` mirror updated alongside `src/ai/` to exercise workflows in this repo
- install.sh pulls from GitHub by default or uses `SRC_DIR` when provided
- install.sh preserves existing `.ai/docs/`, `.ai/playbooks/`, `.ai/MEMORY.md`, and `.ai/plans/` when present
- install.sh preserves existing tool wrapper files by default; set `FORCE` to any value to overwrite wrappers
- Built-in side tasks live in `.ai/operations/`; `.ai/plans/` is reserved for generated/approved artifacts
- Agent roles are strict: Conductor, Planner, Builder, Validator, and opt-in Forger preserve route ownership and phase boundaries
- Memory discipline critical: `.ai/MEMORY.md` must stay under ~200 lines or older entries are pruned
