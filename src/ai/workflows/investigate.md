# Workflow: investigate

## Intake (Conductor)
Conductor asks:
1) Investigation question: What are we trying to learn/decide? (1–2 sentences) + what output do you want? (options | root cause | feature map | all)
2) References: Any known entry points (file paths, feature names, endpoints) or similar existing flow to mirror? (path/link or "unknown")
3) Constraints + timebox: Default is read-only. Allow temporary instrumentation / throwaway spikes? (yes/no) + timebox (e.g. 30/60/120 min)

Optional follow-ups (only if relevant):
- Environment: branch, flags, tenant/user role, platform.
- Risk: is this security/data-sensitive?

Inputs:
- A question to answer (what uncertainty to reduce) + timebox + constraints.

Overlay selection:
- Conductor chooses overlays by following `.ai/agents/guides/delegation.md`, inspecting `.ai/overlays/`, and recording an explicit `Active overlays` decision for delegated work.

Precedence:
- Workflow rules and approved plans for follow-on changes override overlay guidance.

Steps:
1. Conductor routes to Planner.
2. Planner performs a timeboxed, read-only investigation and looks for existing code, patterns, and reusable utilities first.
3. Planner produces an **investigation report** (file or inline):
   - Default: `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md`
   - Inline is preferred when short (<= 30 non-empty lines), especially in the 20-30 line range.
4. Promotion rule:
   - If implementation is the next step, stop after the report and recommend the `change` workflow.
   - Any code changes beyond explicitly-approved temporary instrumentation/spikes are deferred to the next workflow.
5. Conductor confirms the recommended handoff and routes to the next workflow (`change` | `document`).

Outputs:
- Investigation report: inline for short reports; `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md` for longer reports.
- Clear recommendation + handoff to next workflow.

Done criteria:
- Investigation reduced uncertainty with evidence.
- Report includes a concrete recommendation and a tight next-step scope.
- Any instrumentation/spike permission and actions are explicitly documented.

---

## Investigation Report template

1) **Intent**
- Question to answer:
- Success criteria:

2) **Scope + constraints**
- In-scope:
- Out-of-scope:
- Read-only default acknowledged: yes
- Instrumentation/spikes allowed (explicit permission): yes/no
- Timebox:

3) **Evidence collected**
- Files inspected:
- Commands run:
- Observations:
- Reusable code/patterns considered first:

4) **Findings**
- How it works today (feature map summary, when relevant):
- Root cause / repro (when relevant):
- Confidence level (low/medium/high):

5) **Options**
- Option A:
- Option B:
- Option C (optional):
- Recommendation + rationale:

Keep lean-context when the investigation is narrow and self-contained: include only the files, commands, and observations needed to support the recommendation.

6) **Handoff**
- Next workflow: `change` | `document`
- Proposed scope:
- Verification plan:

7) **Open questions**
- Remaining unknowns:
- Why they remain unknown:
