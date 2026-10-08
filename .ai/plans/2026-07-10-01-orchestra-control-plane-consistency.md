# Plan: Orchestra Control-Plane Consistency

- Date: 2026-07-10
- Workflow: `change` (`refactor`)
- Status: implemented and validated on 2026-07-10
- Source policy: edit canonical `src/**`; do not edit generated/local agent mirrors

## Goal

Make Orchestra's prompts, workflows, operations, and tool-agent configurations describe and enforce one executable model for routing, approval, ownership, artifact writes, delegation, and verification.

## Acceptance criteria

1. Every direct-answer, workflow, and operation route has one authoritative definition of intake, plan requirement, approval, owner, allowed writes, validation, and terminal state.
2. Shortcut wording only classifies intent; it cannot select a different gate sequence or match incidental substrings.
3. Planner, Builder, Validator, Conductor, and Forger responsibilities are internally consistent, including planless routes and allowed orchestration/docs writes.
4. `document`, `investigate`, `trivial-change`, and `guided` follow their declared gates; `change` still requires an explicitly approved plan.
5. Mutating operations cannot use invocation approval as a substitute for required change approval, and rollback claims correspond to artifacts actually created.
6. Playbook execution validates lifecycle status, declared children, allowed role, approvals, verification, cleanup, and terminal status.
7. Codex, Claude Code, Copilot, and OpenCode agent capabilities support their canonical role assignments without weakening Forger opt-in/no-delegation boundaries.
8. Focused semantic checks fail on the contradictions found by the review and pass on the corrected contracts.
9. Framework docs and memory describe only verified behavior.

## Non-goals

- No `install.sh` or installer-behavior changes.
- No renaming or removal of public roles, workflows, or operations unless implementation evidence proves compatibility is impossible.
- No edits to `.ai/agents/**`, `.ai/workflows/**`, `.ai/operations/**`, `.ai/templates/**`, or local `.codex/**`, `.claude/**`, `.github/**`, `.opencode/**` mirrors.
- No prompt generator or executable workflow engine in this change.

## Design decisions

1. Add a compact canonical route/gate matrix at `src/ai/agents/guides/routing.md`; Conductor, workflows, operations, and adapters reference it instead of duplicating competing gate rules.
2. Define read-only roles as prohibited from product/source mutation, while explicitly allowing Planner plan/report artifacts and Validator-owned `.ai/docs/**` and `.ai/MEMORY.md` updates.
3. Keep `change` approval distinct from operation/playbook invocation approval. Non-trivial product/app mutations require an approved `change` plan; explicitly eligible `trivial-change` work remains planless.
4. Make Forger genuinely end-to-end by adding plan creation and an explicit approval stop before implementation; retain explicit user opt-in and no delegation.
5. Keep adapter wrappers thin: capabilities translate the canonical role, while route lists and policy remain canonical.

## Gate policy to encode

- `direct answer`: no plan or approval; Conductor answers without delegation when specialist work is unnecessary.
- `change`: inline or file plan plus explicit approval before Builder/Forger implementation.
- `document`, `investigate`, `trivial-change`: no pre-plan approval; each uses its route-specific scope/report/diff evidence.
- `guided`: inherits the selected target route exactly.
- `bootstrap`, `refresh-context`: inline per-run preview plus explicit approval before commands or broad writes; promote product/app changes to `change`.
- `create-overlays`, `define-playbook`: approved plan unless the request qualifies for `trivial-change`.
- `run-playbook`: enforce invocation policy; additionally require an approved `change` plan for non-trivial product/app mutation.

## Critical files

- Routing/rules: `src/ai/AGENTS.md`, `src/ai/RULES.md`, `src/ai/agents/conductor.md`, `src/ai/agents/guides/{routing,delegation,context-management}.md`
- Roles: `src/ai/agents/{planner,builder,validator,forger}.md`
- Workflows: `src/ai/workflows/{change,document,investigate,trivial-change,guided}.md`
- Operations: `src/ai/operations/{bootstrap,refresh-context,create-overlays,define-playbook,run-playbook}.md`
- Playbooks: `src/ai/playbooks/README.md`, `src/ai/templates/playbook.template.md`
- Adapters: role and always-on configurations under `src/tools/{codex,claude-code,copilot,opencode}/`
- Verification/docs: `scripts/verify-control-plane.sh`, `scripts/verify.sh`, `README.md`, relevant `.ai/docs/**`, relevant `src/ai/docs/**`, `.ai/MEMORY.md`

## Implementation steps

1. **Establish the canonical route contract.**
   - Add `routing.md` with a table for direct answer, five workflows, and five operations: intent, intake, mutation class, allowed write paths, plan artifact, approval, execution owner, validation owner/requirements, terminal states, and completion evidence.
   - Define explicit command/prefix shortcut recognition and require all shortcuts to rejoin normal routing.
   - Update `src/ai/AGENTS.md`, Conductor, delegation guidance, and binding rules to reference the matrix and remove competing generic plan-gate language.

2. **Normalize role contracts.**
   - Planner: permit only plan/report artifact writes; keep product/source investigation read-only.
   - Validator: add an unconditional product-code implementation prohibition; permit owned docs/memory writes; make plan review conditional and accept scope plus diff for planless routes.
   - Builder: run every applicable plan/repo-required verification category and report explicit skips.
   - Forger: add discovery, plan creation, approval stop, implementation, verification, and closeout phases without delegation.

3. **Align lifecycle workflows with the matrix.**
   - Keep `change` plan approval mandatory.
   - Make `document` target-scoped and planless unless promoted to broader change work.
   - Treat `investigate` output as a report, not a pre-approved implementation plan.
   - Define `trivial-change` validation from requested scope plus diff; remove commit/PR-only completion assumptions.
   - Make `guided` inherit the selected target route without adding or removing gates.

4. **Repair operation state transitions.**
   - Bootstrap/refresh: require a preview and explicit approval before commands or broad writes; create and verify a timestamped `.ai-archive/` snapshot plus manifest before mutation; track created files/processes; rollback only run-owned changes; remove historical-plan scanning.
   - Create-overlays: redefine it for repo-local `.ai/overlays/<slug>.md` creation/update with deterministic Planner/Builder/Validator ownership; move framework rollout work to `change`.
   - Define-playbook: route wording-only edits through `trivial-change`; otherwise require the normal approved plan.
   - Run-playbook: recursively preflight status, `May call`, roles, inputs, approvals, risk, cleanup, and terminal state; require an enclosing approved `change` plan for product mutations.

5. **Align tool-agent capabilities.**
   - Codex: allow Planner plan/report artifact persistence without granting product implementation ownership.
   - Claude Code: enable Conductor's native delegation tool, remove unshipped skill references, and accept inline or file plan artifacts.
   - OpenCode: allow Validator's required docs/memory edits, deny Forger task delegation, require explicit Forger selection, and accept inline plans.
   - Copilot: disable model invocation for Forger, remove its delegation tool, and accept inline plans.
   - Remove incomplete duplicated route enumerations from adapters; point them to canonical routing.

6. **Add semantic verification.**
   - Add `scripts/verify-control-plane.sh` with table-driven assertions for route completeness/equivalence, valid owners, artifact-producing predecessors, planless Validator inputs, all-applicable Builder checks, playbook preflight fields, and forbidden stale phrases.
   - Add fail-closed POSIX shell/`awk` extractors for the constrained TOML/frontmatter fields Orchestra owns; reject missing, duplicate, malformed, or unknown required capability fields and validate invariants per role without optional runtimes.
   - Use Python `tomllib`, native CLIs, or other structured parsers only as supplemental syntax/effective-config checks when available; report their absence without skipping the required semantic checks.
   - Invoke the focused verifier from `scripts/verify.sh` without changing installer behavior.
   - Run: `sh -n scripts/verify-control-plane.sh`, `scripts/verify-control-plane.sh`, and `scripts/verify.sh`.
   - Validate effective agents with locally available `codex` and `opencode`; run Claude/Copilot native discovery when available, otherwise record those runtime gaps explicitly.

7. **Update documentation and durable context.**
   - Update `.ai/docs/features/{workflows,operations,tool-wrappers}.md` and `.ai/docs/patterns/{agent-roles,planning-gate}.md` to match the matrix.
   - Update generic installed context under `src/ai/docs/**` and remove fabricated application-domain facts from the starter overview.
   - Update `README.md` examples and terminology; append one verified durable route/capability convention to `.ai/MEMORY.md` after checks pass.

8. **Validate scope and close out.**
   - Confirm no installer or prohibited mirror paths changed; review the diff against every acceptance criterion.
   - Validator reruns all checks, verifies adapter parity and docs/memory hygiene, and reports any unavailable native-runtime validation as residual risk.

## Risks and rollback

- Tool schemas may use different names or granularity for delegation/write permissions; validate native effective configuration before claiming parity.
- A new always-needed routing guide can increase context cost; keep it compact and remove duplicated adapter/role prose to offset it.
- Broad prompt changes can create new precedence conflicts; implement in the numbered order and run focused verification after each phase.
- Rollback is file-scoped: revert only the canonical prompt/config/verification/docs changes from this plan; do not alter installer or local mirror state.

## Optional follow-ups

- Add native Claude Code and Copilot adapter checks to CI when those runtimes are available.
- Consider generating thin adapter fragments from the canonical capability contract after this hand-authored model is stable.

## Impact

- Doc impact: `updated`
- Memory impact: one concise verified convention after implementation
- Playbooks invoked by this plan: none
