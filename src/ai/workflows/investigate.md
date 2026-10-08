# Workflow: investigate

This planless workflow reduces uncertainty through read-only product/source investigation. Its authoritative contract is the `investigate` row in `.ai/agents/guides/routing.md`.

## Intake (Conductor)

Ask only for missing blocking facts:
1. Question or decision to support and desired report shape (`options`, `root cause`, `feature map`, or combined).
2. Known entry points or `unknown`.
3. Constraints, environment, risk, and timebox.

## Route boundaries

- No pre-plan approval or implementation plan is required.
- Planner's product/source work is read-only; temporary source instrumentation is outside this route.
- Separate approval still applies before sensitive, external, paid, production, or otherwise gated commands.
- The output is an investigation report, even when persisted under `.ai/plans/**`; it never authorizes implementation.

## Procedure

1. Conductor confirms the question, timebox, output, constraints, and overlay decision.
2. Planner inspects the smallest evidence set that can answer the question, looking for existing patterns and reusable utilities first.
3. Planner produces an inline report or a report under `.ai/plans/**` containing:
   - intent, success criteria, scope, exclusions, and timebox;
   - files inspected, commands run, and observations;
   - findings, confidence, options when relevant, and recommendation;
   - remaining unknowns and a tight next-route suggestion.
4. Planner confirms the product/source diff is empty and reports any unavailable evidence.
5. Conductor closes the route as `reported` or `blocked`, or proposes promotion to `change` or `document`.

If implementation is requested next, stop after the report and enter the new route's normal intake and gates. Do not relabel or pre-approve the report as a change plan.

## Done criteria

- Evidence reduced the stated uncertainty within the timebox.
- The report distinguishes observations, inference, confidence, and unknowns.
- No product/source mutation occurred and the recommended next route is explicit.
