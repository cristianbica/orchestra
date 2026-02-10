# Workflow: document (initial / refresh)

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
7. Add durable discoveries to `.ai/MEMORY.md`.

Outputs:
- `.ai/docs/overview.md`
- `.ai/docs/features/README.md` and multiple feature pages.
- `.ai/docs/patterns/README.md` and pattern docs.

Done criteria:
- Docs reflect what exists in code (no speculation).
- Memory updated with key commands/conventions.
