# Investigation report: CI-style prompt tests (agents + workflows)

## 1) Intent
- Question to answer: What is the best, pragmatic approach to add automated (CI-style) tests for the *prompt artifacts* in this repo (agents + workflows, plus tool wrapper prompts) so regressions are caught early?
- Success criteria:
  - Tests run deterministically in CI (no LLM calls; no network required).
  - Tests validate prompt structure and invariants (required blocks/sections, intake question contracts, gates text, mirror consistency).
  - Wrapper prompt files are validated in a way that matches their installed location.
  - Minimal dependencies and clear failure messages.

## 2) Scope + constraints
- In-scope:
  - CI strategy + concrete prompt test types for this repository.
  - What to test (prompt contracts/invariants) and how to structure/implement tests.
  - Recommended CI commands.
- Out-of-scope:
  - Actually implementing CI/tests (deferred to next workflow).
  - “Does the LLM obey the prompt?” evals (no LLM calls; this is static testing only).
- Read-only default acknowledged: yes
- Instrumentation/spikes allowed (explicit permission): no
- Timebox: 30 min

## 3) Evidence collected
- Files inspected:
  - src/ai/agents/*.md
  - src/ai/workflows/*.md
  - .ai/agents/*.md
  - .ai/workflows/*.md
  - .github/copilot-instructions.md
  - src/tools/vscode-copilot/.github/agents/*
- Repo scan observations:
  - No `.github/workflows/` present (no CI yet).
  - No existing `tests/` directory.
  - No language manifests (no `package.json`, `pyproject.toml`, `go.mod`, etc.).
  - Wrapper prompt files under `src/tools/**` are intended to be copied into a different directory structure on install (path-sensitive links).

## 4) Findings
- The most valuable automated tests here are *prompt contract tests* (static/deterministic): validate that agent/workflow prompt artifacts keep their required structure and invariants.
- “Prompt tests” can be broken down into:
  1) Prompt linting (schema/structure checks)
  2) Prompt contract checks (cross-file invariants needed for the framework to operate)
  3) Optional prompt snapshots (detect any change at all; higher noise)
- High-signal deterministic checks (no LLM calls):
  - **Agents:** require `<rules>` and `<workflow>` blocks; require the role’s hard-gate language (plan approval gate, doc/memory hygiene, etc.).
  - **Workflows:** require `## Intake (Conductor)` and the standard sections; enforce “3 primary intake questions” contract; enforce investigate’s “Investigation Report template” presence.
  - **Mirror invariants:** enforce exact equality for the mirrored prompt core:
    - `src/ai/agents/**` == `.ai/agents/**`
    - `src/ai/workflows/**` == `.ai/workflows/**`
    - `src/ai/templates/**` == `.ai/templates/**`
    - `src/ai/HUMANS.md` == `.ai/HUMANS.md`
  - **Wrapper prompts:** validate links/refs as-if installed (virtualize install paths), or validate via an install simulation into a temp directory.
  - **Hygiene:** fail on placeholders like `<fill in>`, `TBD`, `FIXME`, `TODO` within the scoped prompt artifacts (avoid false positives like the literal string `todo` in VS Code agent YAML).
- Confidence level: high (based on current repo layout and the nature of the artifacts).

## 5) Options

### Option A — Shell-only checks (diff + grep)
- Approach:
  - `diff`-based checks for mirrored prompt directories.
  - `grep`-style checks for required sections/blocks.
- Pros: tiny dependency footprint; fast.
- Cons: brittle; hard to do path-aware wrapper link validation; false positives likely.

### Option B — Small purpose-built prompt linter (Python stdlib) (recommended)
- Approach:
  - Add a small Python (stdlib-only) prompt linter/test runner that:
    - parses agents/workflows and enforces required blocks/sections,
    - validates local links/targets,
    - enforces intake question contract for workflows,
    - supports install-aware wrapper validation (virtual install paths or temp install simulation),
    - enforces placeholder/TODO hygiene in scoped prompt artifacts.
- Pros: deterministic and precise; minimal dependencies; best failure messages.
- Cons: adds a small custom harness to maintain.

### Option C — Node/Pre-commit markdown tooling
- Approach:
  - Use existing markdown tools (markdownlint/link checkers) and wire them via `pre-commit` or npm scripts.
- Pros: mature Markdown ecosystem.
- Cons: more dependencies/config; still needs custom install-aware wrapper rules.

**Recommendation + rationale**
- Choose **Option B**.
  - It directly tests the “prompt contract” this framework depends on, without requiring an LLM.
  - It avoids brittle regex-only checks and handles wrapper install-path nuance cleanly.

## 6) Handoff
- Next workflow: `implement-feature`
- Proposed scope:
  - Add CI workflow that runs deterministic prompt checks.
  - Add a small prompt test harness (Python stdlib) for agents/workflows/wrappers.
  - Add mirror checks for the prompt core (agents/workflows/templates/HUMANS).
  - Decide whether to include snapshot tests (fail on any prompt change) in addition to contract tests.
- Verification plan (for the implementation workflow):
  - Run `diff` mirror checks for prompt core.
  - Run the prompt linter/test runner.
  - (Optional) simulate wrapper installation into a temp directory and validate installed prompts.

## 7) Open questions
- CI target: is GitHub Actions the intended default for this template, or should CI be tool-agnostic (e.g., also support GitLab CI)?
- Should CI enforce strict equality between `src/ai/**` and `.ai/**` for only the prompt core (agents/workflows/templates/HUMANS.md), or expand it further?
- Do you want **snapshot tests** (fail on any prompt content change), or only **contract tests** (fail when structure/invariants break)?
- Should wrapper validation be done via “virtual install path” logic, or by simulating install into a temp repo and validating the installed files?
