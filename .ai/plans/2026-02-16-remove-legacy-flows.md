# Plan: Remove legacy workflow files

Date: 2026-02-16

## Goal
- Remove deprecated legacy workflow files from canonical source under `src/ai/workflows/`.

## Non-goals
- Do not change active workflow behavior in `change.md`, `document.md`, `investigate.md`, or `trivial-change.md`.
- Do not migrate tool-template wrapper references under `src/tools/**`, `.github/**`, `.codex/**`, or `.ai/**` in this pass.

## Scope + assumptions
- Scope is limited to:
  - Delete `src/ai/workflows/implement-feature.md`
  - Delete `src/ai/workflows/fix-bug.md`
  - Delete `src/ai/workflows/refactor.md`
  - Update root `AGENTS.md` to stop referencing removed workflow files and point to `change.md`.
- Assumption: `src/ai/AGENTS.md` already points to `change.md` and remains canonical.

## Steps
1. Delete the three deprecated workflow files from `src/ai/workflows/`.
2. Update `AGENTS.md` workflow list to reference `change.md` instead of removed files.
3. Run targeted grep in `src/ai/**` and root guidance files to confirm no direct references to deleted workflow file paths remain (excluding historical plan docs).

## Verification
- Confirm deleted files are absent in `src/ai/workflows/` directory listing.
- Grep checks for:
  - `src/ai/workflows/(implement-feature|fix-bug|refactor)\.md`
  - `\.ai/workflows/(implement-feature|fix-bug|refactor)\.md`

## Doc impact
- Update: `AGENTS.md`

## Rollback (if applicable)
- Restore deleted workflow files and root `AGENTS.md` from git history.
