# Phase 6: Enhanced MEMORY.md Structure (Priority 2)

## 17. Restructure `.ai/MEMORY.md`

- Reorganize to GitHub-recommended categories:

```markdown
## Commands (verified ✓ or pending ⏳)
- Build: `npm run build` ✓ (tested 2026-02-10, timing: ~25s)
- Test: `npm test` ✓ (tested 2026-02-10, timing: ~1.5m, requires: DB running)

## Conventions
- File naming: kebab-case for features, PascalCase for components
- Import style: absolute from `@/` root alias

## Versions & Environment
- Node: 20.x required
- Postgres: 15+ required

## Invariants (non-negotiable)
- Never bypass auth middleware
- All DB queries must use parameterized statements

## Repo Layout
- Main code: `src/`
- Tests: `src/**/__tests__/`

## Discovered Quirks
- 2026-02-10: Build fails if `.env` missing (not .env.example)
```

## 18. Add memory update guidelines

- Update `.ai/agents/archivist.md` with MEMORY.md structure
- Update `.ai/agents/builder.md` to format additions correctly

## 19. Create MEMORY.md maintenance workflow

- Add `.ai/workflows/refresh-memory.md` for periodic pruning/validation
