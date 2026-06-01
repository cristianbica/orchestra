# Operation: define-playbook

## Intake (Conductor)

Conductor asks:
1) Playbook name + goal: What reusable procedure should this playbook define?
2) Trigger + policy: When should agents consider it, and should invocation be `auto`, `suggest-first`, or `explicit-only`?
3) Risk + evidence: What systems/data can it touch, what side effects can it have, and what proof should execution report?

Optional follow-ups (only if relevant):
- Runtime inputs: required account/company, scenario, environment, time window, or credentials.
- Safety: production, production-derived data, secrets, paid services, external systems, destructive actions.

Inputs:
- A requested playbook plus expected triggers, risk profile, and evidence requirements.

Overlay selection:
- Conductor chooses overlays by following `.ai/agents/guides/delegation.md`, inspecting `.ai/overlays/`, and recording an explicit `Active overlays` decision for delegated work.
- Prefer `dx`, `testing`, `security`, `privacy`, or `integration` only when they materially change the playbook design or validation criteria.

Precedence:
- Operation steps, workflow gates when invoked from a workflow, role boundaries, approved plan scope, and playbook invocation policy all constrain execution.
- Stricter approval requirements win when constraints overlap.
- Overlays are supporting context only.

Steps:
1. Conductor routes to Planner for discovery.
2. Planner inspects `.ai/docs/**`, `.ai/MEMORY.md`, scripts, existing commands, and existing playbooks.
3. Planner produces a plan artifact for the playbook definition unless the edit is trivial wording in an existing playbook.
4. Approval gate: do not write or change the playbook until the plan artifact is explicitly approved.
5. Builder creates or updates `.ai/playbooks/<slug>.md` from `.ai/templates/playbook.template.md`.
6. Builder marks command claims as `verified` only when command-backed evidence exists; otherwise use `provisional`.
7. Validator checks:
   - invocation policy matches risk;
   - sensitive data, production, production-derived data, external systems, paid services, and local artifacts have explicit approvals;
   - commands are verified or clearly marked provisional;
   - docs and memory hygiene are complete.

Outputs:
- `.ai/playbooks/<slug>.md`
- Optional updates to `.ai/playbooks/README.md`
- Durable command/convention notes in `.ai/MEMORY.md` only when short and verified.

Done criteria:
- Playbook has required sections, invocation policy, inputs, approval gates, steps, evidence, failure handling, and verification status.
- Risk and side effects are explicit.
- The playbook can be discovered without loading unrelated context.

---

## Playbook design checklist

- [ ] Purpose is operational, not aspirational.
- [ ] `Use when` and `Do not use when` are concrete.
- [ ] Invocation policy is explicit.
- [ ] Allowed roles are explicit.
- [ ] Required inputs and runtime questions are scoped.
- [ ] Sensitive or costly actions require approval.
- [ ] Steps include setup, execution, teardown, and failure handling.
- [ ] Evidence to report is concrete.
- [ ] Verification status is honest.
