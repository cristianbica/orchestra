# Plan: Day 1 Bootstrap

## Goal
- Establish validated, high-signal context for all future agent work
- Document tech stack, commands, invariants, and critical patterns
- Verify all commands actually work before documenting them

## Non-goals
- Documenting every feature (start with 2-3 most critical)
- Documenting every pattern (start with 2-3 most used)
- 100% coverage on day 1 (breadth over depth; expand later)

## Scope + assumptions
- Assumes the repo builds and tests run (or can be fixed quickly)
- Assumes README/CONTRIBUTING/CI configs exist with some guidance
- Discovery first, documentation second (validate before writing)

## Steps

### Phase 1: Discovery (Archivist - read-only scan)
1. Scan repo structure:
   - Main code locations (src/, app/, lib/, etc.)
   - Test locations and framework (test/, spec/, __tests__/)
   - Config files (package.json, Gemfile, requirements.txt, pyproject.toml, etc.)
   - CI/CD files (.github/workflows/, .gitlab-ci.yml, Jenkinsfile, etc.)
   - Documentation (README.md, CONTRIBUTING.md, docs/)
   - Build scripts (Makefile, scripts/, package.json scripts)
2. Identify tech stack from dependencies/imports
3. **Identify business domains** (if applicable):
   - Look for folder grouping (e.g., billing/, inventory/, users/, admin/)
   - Check for domain models or bounded contexts
   - Review feature organization in code
   - If 3+ clear domains exist: plan to organize docs by domain
   - If <3 domains or unclear: use flat feature structure
4. Catalog obvious patterns (routing, data access, testing style)
5. Note: DO NOT write docs yet - just gather findings

### Phase 2: Command Verification (Archivist - test every command)
For each discovered command, actually run it:
1. **Bootstrap/install**: Run dependency install; note any missing system deps or errors
2. **Build**: Run build; verify it completes (errors are OK if expected)
3. **Test**: Run test suite; verify command works (failing tests OK, just verify command runs)
4. **Lint**: Run linting; verify it executes
5. **Dev/Run**: Start dev server or run app (if applicable); verify it starts

For each command:
- Record exact command string
- Record result (✓ success / ⚠ warning / ✗ failed)
- Record timing (if >10s, note it)
- Record any workarounds needed

### Phase 3: Invariant Discovery (Archivist + Architect)
Search for non-negotiable rules:
1. **Security patterns**: Auth checks, sanitization, validation gates
2. **Data integrity**: Transactions, consistency checks, immutability rules
3. **Architectural boundaries**: Layering rules, what can call what
4. **Performance constraints**: N+1 prevention, caching requirements
5. **Multi-tenancy/scoping**: Tenant isolation patterns (if applicable)

Discovery sources:
- Comments with "IMPORTANT", "NEVER", "ALWAYS", "WARNING", "CRITICAL"
- Validation rules and guards in code
- CI checks and pre-commit hooks
- Recent PR comments about violations
- Test patterns that enforce rules

### Phase 4: Documentation (Archivist - write validated context)
1. **Fill `.ai/docs/overview.md`**:
   - What the app does (2-3 sentences)
   - Tech stack (verified from package files + imports)
   - Repo landmarks (main code, tests, config locations)
   - Business domains (if identified in Phase 1)

2. **Populate `.ai/MEMORY.md`**:
   - Commands (verified): exact commands with ✓/⚠/✗ status and timing
   - Conventions: discovered from code patterns
   - Invariants: non-negotiable rules from Phase 3
   - Repo layout: main paths
   - Business domains: list of domains (if applicable)
   - Discovered quirks: workarounds, timing issues, known problems

3. **Create 2-3 feature docs** (`.ai/docs/features/<slug>.md` or `.ai/docs/features/<domain>/<slug>.md`):
   - **If domains identified**: Create domain subdirectories under `features/`
     - Example: `.ai/docs/features/billing/invoices.md`, `.ai/docs/features/membership/subscriptions.md`
     - Pick 1 key feature per major domain (2-3 total)
   - **If no clear domains**: Use flat structure
     - Example: `.ai/docs/features/user-auth.md`, `.ai/docs/features/dashboard.md`
   - Keep each to one screen
   - Link to actual code locations

4. **Create 2-3 pattern docs** (`.ai/docs/patterns/<slug>.md`):
   - Document the most-used patterns (testing, data access, routing, etc.)
   - Reference actual examples from the codebase
   - Keep concise

5. **Update indexes**:
   - Business domains identified (if applicable) with brief descriptions
   - Verified commands (with status + timing)
   - Discovered invariants (critical rules)
   - Features documented (with brief rationale and domain grouping if used)
   - Patterns documented (with usage frequency)
   - Known gaps + recommended next
   - Red flags (anything broken, concerning, or unclear)

## Verification
Run through this checklist before declaring bootstrap complete:
- [ ] overview.md lists business domains (if applicable)
- [ ] MEMORY.md has verified commands with ✓/⚠/✗ status and timing
- [ ] MEMORY.md has at least 3 invariants/constraints documented
- [ ] MEMORY.md has repo layout section filled
- [ ] MEMORY.md lists business domains (if applicable)
- [ ] At least 2-3 feature pages created and indexed (organized by domain if domains exist)
- [ ] At least 2-3 pattern pages created and indexed
- [ ] Bootstrap plan documents known gaps and next priorities
- [ ] All commands in MEMORY.md were actually run (not guessed)

## Doc impact (flat or domain-organized)
- `.ai/docs/overview.md`
- `.ai/docs/features/README.md` + 2-3 feature pages
- `.ai/docs/patterns/README.md` + 2-3 pattern pages
- `.ai/MEMORY.md` populated with verified commands/conventions/invariants

If domains are identified:
- Feature pages may be organized under `.ai/docs/features/<domain>/<slug>.md`

## Rollback
If bootstrap is incomplete or wrong:
1. Delete all generated docs under `.ai/docs/`
2. Clear `.ai/MEMORY.md` (except the structure template)
3. Re-run this plan with fixes
