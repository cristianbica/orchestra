# Plan: Add legacy cleanup to installer/updater

Date: 2026-02-16

## Goal
- Ensure `install.sh` (used for install and update) removes known legacy agent/workflow files after syncing templates.

## Non-goals
- Do not change installer source-fetch behavior.
- Do not alter active role/workflow names.

## Scope + assumptions
- Scope is `install.sh` only.
- Cleanup should be safe/idempotent and ignore missing files.
- Remove legacy canonical files under `.ai/`:
  - `.ai/agents/architect.md`, `.ai/agents/archivist.md`, `.ai/agents/inspector.md`, `.ai/agents/researcher.md`, `.ai/agents/reviewer.md`
  - `.ai/workflows/implement-feature.md`, `.ai/workflows/fix-bug.md`, `.ai/workflows/refactor.md`
- Remove legacy tool-wrapper files in repo root if present:
  - `.claude/agents/{architect,archivist,inspector,researcher,reviewer}.md`
  - `.codex/agents/{architect,archivist,inspector,researcher,reviewer}.md`
  - `.opencode/agents/{architect,archivist,inspector,researcher,reviewer}.md`
  - `.github/agents/{architect,archivist,inspector,researcher,reviewer}.agent.md`

## Steps
1. Add a small helper in `install.sh` to delete files only when they exist.
2. Run legacy cleanup after copy operations (and tool template copy when selected).
3. Keep cleanup unconditional and idempotent so installer/updater behavior is consistent.
4. Verify script syntax and grep resulting file for full legacy path list.

## Verification
- Run `sh -n install.sh` for syntax validation.
- Grep `install.sh` to confirm all legacy targets are listed.

## Doc impact
- none

## Rollback (if applicable)
- Revert `install.sh` to previous version.
