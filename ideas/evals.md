# Phase 1: Evaluation & Testing Framework (Priority 1)

## 1. Create `.ai/evals/` structure

- Add `.ai/evals/README.md` explaining evaluation philosophy
- Create `.ai/evals/templates/eval-template.md` for defining test cases
- Add example evals for each workflow type

## 2. Define evaluation criteria

- Create `.ai/evals/workflows/implement-feature-eval.md` with test cases like:
  - Input: "Add user authentication feature"
  - Expected: Plan includes security review, i18n strings, tests, rollback
  - Scoring: Pass/fail on required sections
- Mirror for `fix-bug-eval.md`, `refactor-eval.md`, `document-eval.md`

## 3. Add evaluation workflow

- Create `.ai/workflows/evaluate.md` describing how to run evals before/after changes
- Document scoring methodology (pass/fail vs numeric)
- Include examples of good vs bad outputs

## 4. Update `.ai/README.md`

- Add "Before making changes to agents/workflows: run evals" guideline
- Link to evaluation documentation
