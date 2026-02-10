# Plan: Refresh Context

Date: <YYYY-MM-DD when you run this>

Run this when:
- Major changes were done to the repo (tech stack upgrade, architecture refactor, etc.)
- The app used a previous version of `.ai/` structure
- Documentation is stale or misaligned with current codebase
- Migrating from different agent system (ai-try-1, ai-try-2, custom docs, etc.)

Execute via the `document` workflow.

## Goal
- Preserve valuable existing documentation
- Restructure to current `.ai/` conventions (domains, templates, etc.)
- Enrich with missing context (commands, invariants, gaps)
- Validate everything still works

## Non-goals
- Starting from scratch (use 01-bootstrap.md for that)
- Preserving documentation that's now wrong/obsolete
- 100% coverage on first pass (focus on critical updates)

## Scope + assumptions
- Existing docs have some value worth preserving
- Repo is in working state (builds, tests can run)
- Willing to delete/replace obsolete content

## Steps

### Phase 1: Inventory Existing Docs (Archivist - audit what exists)
1. **Scan current `.ai/` structure** (if exists):
   - What's in `.ai/docs/features/`? (flat vs domain-organized?)
   - What's in `.ai/docs/patterns/`?
   - What's in `.ai/MEMORY.md`?
   - What's in `.ai/plans/`?
   - Check `.ai/docs/overview.md` - is it filled or template?

2. **Scan for legacy docs** (outside `.ai/`):
   - Old CLAUDE.md, AGENTS.md, .cursorrules, etc.
   - READMEs with outdated architecture notes
   - Docs in previous agent system formats (ai-try-1, ai-try-2)
   - Wiki pages, Notion exports, etc.

3. **Categorize findings**:
   - **Keep + restructure**: valuable content, wrong format/location
   - **Keep + update**: good content, just needs refresh
   - **Archive**: outdated but might be useful for reference
   - **Delete**: obsolete, wrong, or duplicated

4. **Identify what's missing** compared to 01-bootstrap.md expectations:
   - Commands verified?
   - Invariants documented?
   - Business domains identified?
   - Critical features covered?
   - Core patterns documented?

### Phase 2: Verify Current State (Archivist - test everything)
Run the same command verification as 01-bootstrap.md Phase 2:
1. Bootstrap/install: Does it still work? Any new dependencies?
2. Build: Still builds? New warnings/errors?
3. Test: Test command changed? Suite still runs?
4. Lint: Linter upgraded? New rules?
5. Dev/Run: Start command changed?

Compare to existing `.ai/MEMORY.md` commands:
- Which commands are stale or wrong?
- Which commands are missing?
- Record new timings (has build gotten slower?)

### Phase 3: Detect Changes (Architect - compare old vs current)
1. **Tech stack changes**:
   - Framework upgrades (Rails 6→7, React 17→18, etc.)
   - New dependencies added
   - Deprecated packages removed
   - Language version changes

2. **Architecture changes**:
   - New domains added?
   - Domain boundaries changed?
   - Major refactors (monolith→microservices, etc.)
   - New patterns introduced (GraphQL, event sourcing, etc.)

3. **Invariants changes**:
   - New security requirements?
   - Changed data integrity rules?
   - New performance constraints?
   - Compliance changes (GDPR, SOC2, etc.)

4. **Feature landscape**:
   - Features added since last docs
   - Features removed/deprecated
   - Features significantly changed

### Phase 4: Restructure + Migrate (Archivist - apply current conventions)
1. **Restructure features** (if needed):
   - **If current structure is flat but domains now exist**: Reorganize into domain subdirectories
   - **If domains changed**: Move docs to new domain folders
   - **If going flat→domain or domain→flat**: Restructure accordingly
   - Update internal links

2. **Migrate legacy docs**:
   - Extract valuable content from old CLAUDE.md, AGENTS.md, .cursorrules
   - Rewrite into current `.ai/docs/**` format
   - Preserve examples, but update to current patterns
   - Move to archive if not migrated

3. **Update `.ai/docs/overview.md`**:
   - Refresh tech stack (remove old versions, add new tools)
   - Update repo landmarks if structure changed
   - Add/update business domains section
   - Keep concise (1-2 paragraphs + bullets)

4. **Rebuild `.ai/MEMORY.md`**:
   - Keep verified commands that still work (update if changed)
   - Remove obsolete commands
   - Add new commands discovered
   - Update conventions from current code patterns
   - Update invariants based on Phase 3 discoveries
   - Add new quirks/workarounds
   - Update repo layout if structure changed
   - Update business domains if changed

5. **Refresh feature docs** (`.ai/docs/features/**`):
   - Update existing feature docs with changes from Phase 3
   - Add 1-2 new feature docs for major additions
   - Mark deprecated features clearly or remove
   - Ensure all links to code still work

6. **Refresh pattern docs** (`.ai/docs/patterns/**`):
   - Update existing patterns if implementation changed
   - Add 1-2 new patterns if major patterns introduced
   - Remove patterns no longer used
   - Update code examples to current syntax/conventions

7. **Update indexes**:
   - `.ai/docs/features/README.md` with current structure
   - `.ai/docs/patterns/README.md` with current patterns

### Phase 5: Enrich Gaps (Archivist - fill what's missing)
Based on Phase 1 "missing" analysis:
1. Add missing verified commands to MEMORY
2. Document missing invariants discovered in Phase 3
3. Add critical missing feature docs (1-2 most important)
4. Add critical missing pattern docs (1-2 most important)
5. Fill any TODO/placeholder sections left from migration

## Verification
Run through this checklist before declaring refresh complete:
- [ ] All existing valuable docs migrated or explicitly archived
- [ ] `.ai/docs/overview.md` reflects current tech stack and structure
- [ ] `.ai/MEMORY.md` has verified commands (all tested, stale ones removed)
- [ ] `.ai/MEMORY.md` reflects current invariants and conventions
- [ ] Feature docs reflect current domain structure (if domains changed)
- [ ] All internal links in docs still work
- [ ] Pattern docs reflect current patterns in use
- [ ] At least 1-2 new critical docs added (features or patterns)
- [ ] Refresh plan documents what changed and why
- [ ] Old/obsolete docs archived (not lost, but out of main path)

## Doc impact
Updates entire `.ai/docs/**` structure:
- `.ai/docs/overview.md` (refreshed)
- `.ai/docs/features/**` (restructured + updated + enriched)
- `.ai/docs/patterns/**` (updated + enriched)
- `.ai/MEMORY.md` (verified + updated)

## Rollback
If refresh goes wrong:
1. Restore from `.ai-archive/<YYYY-MM-DD>/`
2. Revert changes to MEMORY.md, overview.md
3. Consider running 01-bootstrap.md fresh instead
