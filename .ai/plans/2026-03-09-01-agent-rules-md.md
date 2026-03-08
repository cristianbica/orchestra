# Plan: Add repo-local agent rules via `.ai/RULES.md`

Date: 2026-03-09
Workflow: change (feature)
Status: approved (user approved inline plan)

## Goal

Allow repositories to define user-authored agent rules in `.ai/RULES.md` that agents must follow, without weakening workflow hard gates or approved-plan requirements.

## Scope

- Add template rules file in source: `src/ai/RULES.md` (installed as `.ai/RULES.md`)
- Preserve user customizations on reinstall (do not overwrite existing `.ai/RULES.md`)
- Wire canonical agent instructions (only) to load and apply `.ai/RULES.md` when present
- Keep instructions short and readable

## Requirements

1. **Rules file + format**
   - Create `src/ai/RULES.md` with:
     - `Global` section
     - Role sections (Conductor, Planner, Builder, Validator, Forger)
     - Binding syntax: only bullets starting with `- MUST`, `- MUST NOT` are binding
   - Ship starter “common-sense” rules aligned with existing hard gates.

2. **Precedence model**
   - Higher precedence: workflow hard gates, approved plan, role NEVER boundaries
   - Then: `.ai/RULES.md` user rules
   - Then: overlays / soft guidance
   - Within `.ai/RULES.md`: role section overrides Global on conflict

3. **Installer behavior**
   - Update `install.sh` copy loop to special-case `RULES.md`:
     - if destination `.ai/RULES.md` exists: preserve (skip overwrite)
     - else: copy from blueprint

4. **Agent integration**
   - Update canonical role files:
     - `src/ai/agents/conductor.md`
     - `src/ai/agents/planner.md`
     - `src/ai/agents/builder.md`
     - `src/ai/agents/validator.md`
     - `src/ai/agents/forger.md`
   - Add exactly one short rule line per file (no long paragraph lines):
     - `- MUST load .ai/RULES.md when present and treat it as mandatory. Apply Global and <Role> sections.`
   - Do not duplicate precedence/conflict policy in each role file; keep those details centralized in `src/ai/RULES.md`.

5. **Workflow/tool wrappers**
   - No changes required.

6. **Docs + memory hygiene (repo context)**
   - Update `.ai/docs/**` only if needed for this repo’s own guidance.
   - Update `.ai/MEMORY.md` only if a durable fact is newly introduced.

## Verification

- `bash -n install.sh` passes
- Confirm `src/ai/RULES.md` exists and contains binding syntax + precedence + sections
- Confirm installer preserves existing `.ai/RULES.md`
- Confirm `src/ai/agents/*` contain short `.ai/RULES.md` instruction lines (not verbose blocks)

## Out of scope

- No runtime parser/engine beyond prompt/template instructions
- No changes to workflow gate policy
