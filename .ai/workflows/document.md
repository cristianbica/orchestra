# Workflow: document (initial / refresh)

## Intake (Conductor)
Conductor asks:
1) Target doc(s): Which file(s) should be created/updated? (path(s) or "not sure")
2) Audience + intent: Who is this for and what should they be able to do after reading?
3) Source of truth: What inputs should the doc reflect (code, ticket, decision record), and what's explicitly out-of-scope?

Optional follow-ups (only if relevant):
- Format constraints: any required structure (sections/checklists/examples)?

Purpose:
- Build or refresh `.ai/docs/` from the current app codebase.
- For first-time setup, execute `.ai/plans/0000-00-01-bootstrap.md` (copy it to your repo first).
- For major refresh or migration, execute `.ai/plans/0000-00-02-refresh-context.md`.

Steps:
1. Archivist scans the codebase.
2. Update app overview: `.ai/docs/overview.md` (what the app does, tech stack, repo landmarks).
3. Update feature index: `.ai/docs/features/README.md`.
4. Create/update feature pages (for example: `.ai/docs/features/<slug>.md`).
5. Update pattern index: `.ai/docs/patterns/README.md`.
6. Update core pattern docs (i18n/testing/architecture) as discovered.
6a. Feedback handling (user feedback == Inspector findings): if the user provides feedback at any time during or after this workflow run, treat it like reviewer findings and implement it as an adjustment pass within the same workflow run. Create a new plan only for true scope changes.
7. Add durable discoveries to `.ai/MEMORY.md`.

Outputs:
- `.ai/docs/overview.md`
- `.ai/docs/features/README.md` and multiple feature pages.
- `.ai/docs/patterns/README.md` and pattern docs.

Done criteria:
- Docs reflect what exists in code (no speculation).
- Memory updated with key commands/conventions.
