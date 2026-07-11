# Operation: Create Overlays

Create or update one repo-local analysis overlay. Follow the `create-overlays` row in `.ai/agents/guides/routing.md`; overlays support routes and never replace their gates or role boundaries.

## Intake and scope

Conductor records the overlay goal, slug, analysis scope, intended consumers, constraints, and whether an index entry is required. Allowed writes are limited to `.ai/overlays/<slug>.md` and the repository's required overlay index.

- Do not create a built-in overlay set, modify framework source, wire prompts/workflows, or change installer behavior here; route that rollout through `change`.
- Preserve existing custom overlays unless the approved scope names one for update.
- Use a stable lowercase kebab-case slug and keep guidance concise and domain-specific.

## Route and ownership

1. Conductor selects this operation and records active overlays for each delegation.
2. Planner performs read-only discovery of the requested consumers, related docs, and existing overlay patterns, then writes a scoped `change`-style plan artifact.
3. The user explicitly approves the plan before implementation.
4. Builder creates or updates the named overlay and required index only.
5. Validator reviews plan approval, scope, schema, references, checks, and impact statuses.

An exact wording-only correction to an existing overlay with no policy, scope, selection, or behavior change must instead use `trivial-change`; Validator then reviews requested scope plus diff without a plan. If triviality becomes uncertain, stop and return to the planned route. Forger may assume the phases only under the explicit opt-in and phase boundaries defined by the routing contract.

## Overlay contract

The overlay defines:

- `Purpose`;
- `When to apply`;
- `Output focus`;
- `Decision prompts`;
- `Quality checks`.

It must not redefine route gates, approvals, terminal states, allowed writes, or role ownership. Reference canonical guidance by path instead of copying it.

## Verification and completion

Builder reports the approved plan or trivial scope, exact overlay/index diff, reference checks, applicable formatting checks, and explicit skips. Validator returns `approve` or `needs changes`; that is review status, not a route terminal state.

Conductor records only a routing-matrix terminal state: `complete` after Validator approval, `blocked` while approval or remediation is required, or `failed` when the run is closed without a valid result. Report doc impact and memory impact; do not widen writes solely to resolve those impacts.

## Rollback

Revert only the named overlay and index changes from this run. Preserve unrelated or concurrent custom-overlay edits and report any conflict instead of overwriting it.
