# Plan: Rename Reviewer role to Validator

Date: 2026-02-16

## Goal
- Rename the active role `reviewer`/`Reviewer` to `validator`/`Validator` in canonical docs and tool wrappers.

## Non-goals
- Do not change workflow behavior or gates.
- Do not modify deprecated/historical material outside active `src/ai/**` and `src/tools/**` unless needed to prevent broken references.

## Scope + assumptions
- Scope includes:
  - `src/ai/**` active role/workflow/guidance files
  - `src/tools/**` wrappers and tool guidance currently using reviewer
- Assumption: role responsibilities remain identical; this is naming-only.

## Steps
1. Rename canonical role file `src/ai/agents/reviewer.md` → `src/ai/agents/validator.md` with title/content updated.
2. Update canonical references in `src/ai/**` from reviewer to validator (Conductor, Builder, workflows, guides, HUMANS).
3. Rename tool wrapper files from reviewer to validator where present:
   - `.claude/agents/reviewer.md` → `validator.md`
   - `.codex/agents/reviewer.md` → `validator.md`
   - `.opencode/agents/reviewer.md` → `validator.md`
   - `.github/agents/reviewer.agent.md` → `validator.agent.md`
4. Update wrapper contents and tool guidance references from reviewer → validator.
5. Run grep validation in `src/ai/**` and `src/tools/**` to ensure active references are updated and no stale `.ai/agents/reviewer.md` links remain.

## Verification
- File existence checks for `validator` wrappers and canonical role file.
- Grep checks for:
  - `\.ai/agents/reviewer\.md`
  - `\breviewer\b|\bReviewer\b`
  - ensuring intended remaining matches (if any) are only historical plan text.

## Doc impact
- Update: active role/workflow/guidance docs under `src/ai/**` and `src/tools/**`.

## Rollback (if applicable)
- Restore renamed files and reverted references from git history.
