# Memory (curated)

Max ~200 lines. Prune oldest/least-used when full. One agent updates per session to avoid conflicts.

## Commands (verified)

This is a template distribution repo. No traditional build/test/lint commands apply.

- **Install**: `bash ./install.sh [tool-name]` - Copy `src/ai/` into `.ai/` and optional tool wrapper (inspected; not executed in this refresh)
- **Installer syntax check**: `bash -n install.sh` - Validate installer shell syntax without executing it
- **Verify**: No build, test, or lint commands (pure markdown + scripts; no runtime)

## Conventions

- **Workflow names**: current set is `document`, `investigate`, `change`, `trivial-change`
- **Plan files**: `.ai/plans/<YYYY-MM-DD>-<slug>.md` (dated, descriptive slug)
- **Doc files**: `.ai/docs/{overview,features,patterns,templates}/`
- **Agent roles**: Conductor, Planner, Builder, Validator (strict boundaries)
- **Approval**: Explicit user approval required before implementing non-trivial changes
- **Memory**: Only durable facts (commands, conventions, invariants, layout); max ~200 lines total
- **Canonical sources**: `src/ai/` + `src/tools/` are the template sources when present
- **Docs source of truth (this repo)**: `.ai/docs/**` is canonical project context; `src/ai/docs/**` is boilerplate template content
- **Repo editing policy (this repo)**: Edit only `.ai/docs/`, `.ai/plans/`, `.ai/MEMORY.md`; never edit `.ai/agents/`, `.ai/workflows/`, `.ai/templates/`, `.ai/HUMANS.md`; treat `src/` as canonical and keep it generic (distributed)

## Invariants (non-negotiable)

1. **NEVER implement outside Builder** — Conductor/Planner/Validator do not implement code
2. **NEVER implement without an explicitly approved plan** — Non-trivial workflows require plan in `.ai/plans/` + user approval
3. **NEVER bypass doc hygiene** — Every task must state `doc impact: updated | none | deferred`
4. **NEVER bypass memory hygiene** — Only durable, reusable facts; keep under ~200 lines
5. **ALWAYS do discovery-first planning** — Planner must read `.ai/docs/**` + existing plans before drafting
6. **ALWAYS verify commands before documenting** — Phase 2 of bootstrap validates commands; status: ✓/⚠/✗

## Repo layout

**Two-tier structure**:
1. **`src/ai/`** — Canonical authoring source (this template repo)
   - Contains definitions: agents, workflows, docs, plans
   - Distributed via `install.sh` to user repos

2. **`.ai/`** — Canonical in installed user repos
   - Copied from `src/ai/` during installation
   - User repos edit `.ai/` directly; never touch `src/ai/`
   - In this template repo, `.ai/` is a mirror of `src/ai/`

**Key directories**:
- `.ai/agents/` — Conductor, Planner, Builder, Validator definitions
- `.ai/agents/guides/` — delegation, context-management principles
- `.ai/workflows/` — document, investigate, change, trivial-change
- `.ai/plans/` — Planning templates (01-bootstrap.md, 02-refresh-context.md)
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
- install.sh preserves existing `.ai/docs/`, `.ai/MEMORY.md`, and `.ai/plans/` when present
- Plans are templates meant to be copied into target repos; bootstrap plan itself is a 4-phase workflow (Discovery, Verify, Invariants, Docs)
- Agent roles are strict: each has NEVER/ALWAYS rules to prevent overreach and enforce separation of concerns
- Memory discipline critical: `.ai/MEMORY.md` must stay under ~200 lines or older entries are pruned
