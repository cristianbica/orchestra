# Plan: Clean legacy agents/workflows in src/tools

Date: 2026-02-16

## Goal
- Remove legacy role wrappers in `src/tools/**` and align tool-specific guidance to the active model (`planner`, `reviewer`, unified `change` workflow).

## Non-goals
- Do not modify canonical source under `src/ai/**` beyond this plan file.
- Do not modify root template packs outside `src/tools/**` (e.g., `.github/**`, `.codex/**`, `.ai/**`).

## Scope + assumptions
- Scope includes all four tool packs:
  - `src/tools/claude-code/**`
  - `src/tools/codex/**`
  - `src/tools/opencode/**`
  - `src/tools/vscode-copilot/**`
- Aggressive policy (approved by user):
  - Delete legacy role wrapper files for `architect`, `researcher`, `inspector`, `archivist` where they exist.
  - Update conductor/wrapper guidance to use `change` workflow instead of `implement-feature|fix-bug|refactor`.
  - Update role names/references in remaining docs to `planner` and `reviewer` where appropriate.

## Steps
1. Inventory legacy wrapper files in each `src/tools/*` agent folder and delete legacy role wrappers.
2. Update tool-level guidance files (e.g., `AGENTS.md`, `CLAUDE.md`, conductor wrapper docs) to replace legacy role/workflow references with active equivalents.
3. Keep active wrappers (`conductor`, `builder`) and ensure references to canonical files point to existing roles (`planner`, `reviewer`).
4. Run targeted grep in `src/tools/**` to verify no stale references remain to:
   - `.ai/agents/architect.md`, `.ai/agents/researcher.md`, `.ai/agents/inspector.md`, `.ai/agents/archivist.md`
   - `implement-feature`, `fix-bug`, `refactor` as active workflow options.
5. Summarize any intentionally retained historical references (if any) and why.

## Verification
- `grep` checks in `src/tools/**` for stale canonical file paths and legacy workflow tokens.
- Directory listings confirm legacy wrapper files are removed.

## Doc impact
- Update: tool-specific guidance in `src/tools/**` only.

## Rollback (if applicable)
- Restore deleted/modified `src/tools/**` files from git history.
