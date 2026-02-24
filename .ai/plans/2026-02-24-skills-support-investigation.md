# Plan: Option B Overlays (Concise)

Date: 2026-02-24
Decision: Proceed with Option B

## 1) Purpose of overlays

Overlays are core prompt lenses (not add-ons) that shape reasoning by context while preserving existing workflow gates and role boundaries.

Goals:
- Improve decision quality for user-facing product work
- Keep prompts consistent across Conductor/Planner/Builder/Validator
- Allow project-specific customization without forking core agent roles

## 2) Built-in overlays (exactly 5)

Create in `src/ai/overlays/`:
- `value.md` — business/product value and scope outcomes
- `system.md` — technical correctness, architecture, maintainability
- `ux.md` — usability, accessibility, interaction quality
- `data.md` — schema/model integrity, migrations, performance
- `security.md` — security/privacy/compliance and risk mitigation

## 3) Agent intake model (built-in + custom)

### Intake rules
- Built-in overlays are always available.
- Custom overlays may be added per repo under `.ai/overlays/`.
- Selection is context-driven, not persona-driven.

### Precedence
1. Workflow gates and role constraints (highest)
2. User-approved plan scope
3. Overlay guidance (built-in + custom)

### Default overlay combinations
- Feature planning: `value + system + ux`
- Bug investigation: `system` (+ `data` for DB issues, + `security` for sensitive impact)
- Refactor: `system + security`
- Documentation: `value + ux` (+ `system` when technical accuracy is central)

### Custom overlay contract
Each custom overlay file must define:
- purpose
- when-to-use
- output focus

## 4) Install script

Update `install.sh` so overlays are included in install/copy flows by default:
- copy `src/ai/overlays/` into target `.ai/overlays/`
- do not overwrite existing custom overlays without explicit flag/behavior
- preserve existing installer behavior for all other assets

## 5) What else is needed (missing essentials)

### A) Built-in plan for users
Add `src/ai/plans/03-create-overlays.md` to guide teams creating custom overlays.

### B) Prompt wiring
Update core agent/workflow prompts so overlays are treated as core context, not optional extras.

### C) Docs
Update:
- `AGENTS.md` and `src/ai/AGENTS.md` (core overlays model)
- `src/ai/HUMANS.md` (quick usage guidance)
- `src/ai/docs/patterns/architecture.md` (workflows > roles > overlays)

### D) Verification
- Overlay files exist (exactly 5 built-ins)
- `03-create-overlays.md` exists and matches plan style
- Installer includes overlays and does not regress existing behavior
- Prompt/docs references resolve and are consistent
- Plan gate and role boundaries remain unchanged

## 6) Scope (implementation checklist)

1. Add built-in overlays directory and 5 files
2. Add `src/ai/plans/03-create-overlays.md`
3. Wire overlays into agent/workflow prompt docs
4. Update installer to include overlays
5. Update AGENTS/HUMANS/architecture docs
6. Run verification checklist

## 7) Non-goals

- Runtime overlay execution framework
- Expanding beyond 5 built-in overlays in this pass
- Changing existing approval/gate model
