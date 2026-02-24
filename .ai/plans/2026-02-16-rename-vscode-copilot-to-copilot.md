# Plan: Rename tool wrapper folder `vscode-copilot` to `copilot`

Date: 2026-02-16

## Goal
- Rename the tool wrapper folder from `src/tools/vscode-copilot` to `src/tools/copilot` and update references.

## Non-goals
- Do not change wrapper behavior/content beyond naming/path references.
- Do not change other tool wrapper names.

## Scope + assumptions
- Scope includes:
  - Directory rename: `src/tools/vscode-copilot/` → `src/tools/copilot/`
  - Reference updates in active docs/scripts (`README.md`, `src/ai/docs/features/tool-wrappers.md`, and installer logic if needed)
- Assumption: Existing users may still run installer with `vscode-copilot`; keep backward compatibility alias in `install.sh`.

## Steps
1. Rename directory in `src/tools/` to `copilot`.
2. Update references from `vscode-copilot` to `copilot` in repo docs.
3. Update `install.sh` to accept both `copilot` (preferred) and `vscode-copilot` (legacy alias).
4. Verify no remaining active references to `src/tools/vscode-copilot/` except historical plan/memory docs.

## Verification
- List `src/tools/` to confirm `copilot/` exists and `vscode-copilot/` is gone.
- Grep for `vscode-copilot` in active files and confirm only intentional legacy mentions remain.
- Run `sh -n install.sh` for syntax validation.

## Doc impact
- Update: `README.md`
- Update: `src/ai/docs/features/tool-wrappers.md`

## Rollback (if applicable)
- Rename directory back and revert updated references.
