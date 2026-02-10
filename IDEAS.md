# Plan: Comprehensive Enhancement of .ai Agent Framework

**TL;DR:** Transform the `.ai/` framework from a solid foundation into an industry-leading open source template by adding evaluation systems, verification standards, parallelization patterns, optimized context management, and enhanced documentation. The improvements align with 2025-2026 best practices from GitHub, Anthropic, and OpenAI while maintaining the existing clean architecture. (~60-80 hours of work spread across 8 major improvement areas)

**Key decisions referenced:**
- Comprehensive scope covering all high/medium priority gaps
- Open source template focus (maximize reusability)
- Implementation-ready plan for future execution

**Steps**

### Phase 1: Evaluation & Testing Framework (Priority 1)

1. **Create `.ai/evals/` structure**
   - Add [.ai/evals/README.md](.ai/evals/README.md) explaining evaluation philosophy
   - Create [.ai/evals/templates/eval-template.md](.ai/evals/templates/eval-template.md) for defining test cases
   - Add example evals for each workflow type

2. **Define evaluation criteria**
   - Create [.ai/evals/workflows/implement-feature-eval.md](.ai/evals/workflows/implement-feature-eval.md) with test cases like:
     - Input: "Add user authentication feature"
     - Expected: Plan includes security review, i18n strings, tests, rollback
     - Scoring: Pass/fail on required sections
   - Mirror for [fix-bug-eval.md](.ai/evals/workflows/fix-bug-eval.md), [refactor-eval.md](.ai/evals/workflows/refactor-eval.md), [document-eval.md](.ai/evals/workflows/document-eval.md)

3. **Add evaluation workflow**
   - Create [.ai/workflows/evaluate.md](.ai/workflows/evaluate.md) describing how to run evals before/after changes
   - Document scoring methodology (pass/fail vs numeric)
   - Include examples of good vs bad outputs

4. **Update [.ai/README.md](.ai/README.md)**
   - Add "Before making changes to agents/workflows: run evals" guideline
   - Link to evaluation documentation

### Phase 2: Verification Standards (Priority 1)

5. **Enhance plan template with verification section**
   - Update [.ai/templates/plan.template.md](.ai/templates/plan.template.md) to include:
     ```markdown
     ## Verification Commands
     - [ ] Build: `<exact command>` (expected: exits 0, timing: ~30s)
     - [ ] Test: `<exact command>` (expected: all green, timing: ~2m)
     - [ ] Lint: `<exact command>` (expected: 0 warnings)
     - [ ] Manual smoke test: <what to check>
     - [ ] Expected evidence: <screenshots, logs, outputs>
     ```

6. **Update all agent definitions to require verification**
   - Modify [.ai/agents/architect.md](.ai/agents/architect.md) `<plan_style_guide>` to mandate verification section
   - Modify [.ai/agents/builder.md](.ai/agents/builder.md) workflow to require running + reporting verification commands
   - Modify [.ai/agents/inspector.md](.ai/agents/inspector.md) review gates to validate verification was performed

7. **Update existing plan examples**
   - Enhance [.ai/plans/0000-00-01-bootstrap.md](.ai/plans/0000-00-01-bootstrap.md) with explicit verification commands
   - Enhance [.ai/plans/0000-00-02-refresh-context.md](.ai/plans/0000-00-02-refresh-context.md) with verification checklist

8. **Update workflow templates**
   - Add verification requirements to [.ai/workflows/implement-feature.md](.ai/workflows/implement-feature.md), [fix-bug.md](.ai/workflows/fix-bug.md), [refactor.md](.ai/workflows/refactor.md)

### Phase 3: Parallelization Workflow (Priority 1)

9. **Create new workflow pattern**
   - Add [.ai/workflows/parallel-task.md](.ai/workflows/parallel-task.md) describing:
     - When to use (independent subtasks, voting/consensus, sectioning)
     - How to decompose tasks
     - How to merge results
     - Examples: Generate multiple test files, process multiple features

10. **Document parallelization in agent roles**
    - Update [.ai/agents/conductor.md](.ai/agents/conductor.md) to recognize when parallelization is appropriate
    - Update [.ai/agents/architect.md](.ai/agents/architect.md) to plan parallel execution when beneficial

11. **Add example parallel plan**
    - Create [.ai/plans/0000-00-03-example-parallel-refactor.md](.ai/plans/0000-00-03-example-parallel-refactor.md) showing real-world parallel task breakdown

### Phase 4: Context Management Optimization (Priority 1)

12. **Add context ordering guidelines**
  - Create [.ai/agents/guides/context-management.md](.ai/agents/guides/context-management.md) documenting:
      - "Put documents FIRST, queries LAST" (30% quality improvement)
      - Optimal file ordering for prompts
      - XML delimiter usage for long documents
      - When to use `<document><source>` tags

13. **Create prompt caching strategy**
  - Extend [context-management.md](.ai/agents/guides/context-management.md) with:
      - Place reusable content at BEGINNING
      - Structure for 90% cost reduction
      - Example cached vs non-cached prompts

14. **Update agent instructions for context optimization**
    - Modify [.ai/agents/architect.md](.ai/agents/architect.md), [builder.md](.ai/agents/builder.md) to reference context management pattern
    - Add to [AGENTS.md](AGENTS.md) global rules

### Phase 5: Tool Documentation Standards (Priority 2)

15. **Create tool documentation guide**
    - Add [.ai/docs/patterns/tool-documentation.md](.ai/docs/patterns/tool-documentation.md) with:
      - "Agent-Computer Interface (ACI)" concept
      - Required sections: Purpose, Parameters, Examples, Edge Cases, Error Handling
      - Template with before/after examples

16. **Document existing "tools" (agents/workflows)**
    - Enhance each agent file with:
      - More usage examples
      - Common failure modes
      - Edge case handling
      - Expected inputs/outputs
    - Files to update: All 5 agent files + 5 workflow files

### Phase 6: Enhanced MEMORY.md Structure (Priority 2)

17. **Restructure [.ai/MEMORY.md](.ai/MEMORY.md)**
    - Reorganize to GitHub-recommended categories:
      ```markdown
      ## Commands (verified ✓ or pending ⏳)
      - Build: `npm run build` ✓ (tested 2026-02-10, timing: ~25s)
      - Test: `npm test` ✓ (tested 2026-02-10, timing: ~1.5m, requires: DB running)

      ## Conventions
      - File naming: kebab-case for features, PascalCase for components
      - Import style: absolute from `@/` root alias

      ## Versions & Environment
      - Node: 20.x required
      - Postgres: 15+ required

      ## Invariants (non-negotiable)
      - Never bypass auth middleware
      - All DB queries must use parameterized statements

      ## Repo Layout
      - Main code: `src/`
      - Tests: `src/**/__tests__/`

      ## Discovered Quirks
      - 2026-02-10: Build fails if `.env` missing (not .env.example)
      ```

18. **Add memory update guidelines**
    - Update [.ai/agents/archivist.md](.ai/agents/archivist.md) with MEMORY.md structure
    - Update [.ai/agents/builder.md](.ai/agents/builder.md) to format additions correctly

19. **Create MEMORY.md maintenance workflow**
    - Add [.ai/workflows/refresh-memory.md](.ai/workflows/refresh-memory.md) for periodic pruning/validation

### Phase 7: Negative Examples & Anti-patterns (Priority 2)

20. **Document what NOT to do**
    - Add "Anti-patterns" sections to:
      - [.ai/agents/architect.md](.ai/agents/architect.md): Bad plan examples (vague, over-scoped)
      - [.ai/agents/builder.md](.ai/agents/builder.md): Scope creep examples
      - [.ai/agents/inspector.md](.ai/agents/inspector.md): Missed gate violations

21. **Create anti-pattern catalog**
    - Add [.ai/docs/patterns/anti-patterns.md](.ai/docs/patterns/anti-patterns.md) covering:
      - Monolithic context files
      - Vague verification steps
      - Implementation without plans
      - Scope creep during execution
      - Ignoring established patterns

### Phase 8: Enhanced Documentation & Onboarding (Open Source Focus)

22. **Create comprehensive onboarding guide**
    - Enhance [.ai/HUMANS.md](.ai/HUMANS.md) with:
      - Quick start (5 minutes)
      - First task walkthrough (30 minutes)
      - Troubleshooting common issues
      - FAQ section

23. **Add visual workflow diagrams**
    - Create [.ai/docs/diagrams/](.ai/docs/diagrams/) with:
      - Workflow flowcharts (Mermaid diagrams)
      - Agent interaction diagrams
      - Decision trees for workflow selection

24. **Create adoption checklist**
    - Add [.ai/docs/adoption-checklist.md](.ai/docs/adoption-checklist.md) for new users:
      ```markdown
      - [ ] Copy .ai/ folder to repo root
      - [ ] Copy AGENTS.md to repo root
      - [ ] Run bootstrap plan (Phase 1)
      - [ ] Verify commands in MEMORY.md
      - [ ] Customize overview.md
      ```

25. **Improve [README.md](README.md) for open source**
    - Add badges (stars, license, version)
    - Add "Features" section highlighting unique aspects
    - Add "Comparison" section (vs no system, vs monolithic approaches)
    - Add "Contributing" guidelines
    - Add "Philosophy" section explaining design decisions

26. **Create examples directory**
    - Add [.ai/examples/](.ai/examples/) with:
      - Real-world plan examples
      - Sample MEMORY.md for different project types (Rails, React, Python)
      - Sample feature/pattern docs
      - Before/after workflow demonstrations

27. **Update all template files for tool-specific wrappers**
    - Review + enhance [.ai/templates/github/copilot-instructions.md](.ai/templates/github/copilot-instructions.md)
    - Review + enhance [.ai/templates/claude/CLAUDE.md](.ai/templates/claude/CLAUDE.md)
    - Ensure they reference new evaluation, verification, parallelization features
    - Update all agent wrappers in templates to reference canonical versions

28. **Add versioning and changelog**
    - Create [CHANGELOG.md](CHANGELOG.md) documenting improvements
    - Add version to [.ai/README.md](.ai/README.md) (semantic versioning)
    - Document breaking changes vs enhancements

29. **Document pattern indexes**
    - Update [.ai/docs/patterns/README.md](.ai/docs/patterns/README.md) to include new patterns:
      - context-management.md
      - tool-documentation.md
      - anti-patterns.md
    - Update [.ai/docs/features/README.md](.ai/docs/features/README.md) with better organization examples

30. **Create contributing guide**
    - Add [CONTRIBUTING.md](CONTRIBUTING.md) explaining:
      - How to propose new workflows
      - How to improve agent definitions
      - Eval requirements for changes
      - Documentation standards

**Verification**

After implementing all phases:

1. **Self-evaluation**
   - Run evals for each workflow type (from Phase 1)
   - Verify all improvements pass quality checks

2. **Pilot with real project**
   - Copy enhanced `.ai/` to test repository
   - Run bootstrap workflow
   - Execute implement-feature workflow
   - Document what works / what needs refinement

3. **Community validation**
   - Get feedback from 2-3 external users
   - Measure: onboarding time, clarity, usability
   - Iterate based on feedback

4. **Comparison metrics**
   - Before: Time to first successful workflow
   - After: Time to first successful workflow (target: 50% reduction)
   - Before: Plan quality (subjective 1-10)
   - After: Plan quality (target: +2 points via verification standards)

**Decisions**

- **Chose comprehensive scope over quick wins**: Open source templates benefit from thoroughness
- **Chose evaluation-first approach**: Aligns with Anthropic/OpenAI best practices ("never optimize without evals")
- **Chose explicit verification over implicit**: Reduces ambiguity for new users
- **Chose documented anti-patterns**: Helps users avoid common pitfalls
- **Chose visual diagrams**: Accelerates onboarding for visual learners

---

This plan transforms your solid foundation into an industry-leading open source template that embodies 2025-2026 best practices while remaining accessible and well-documented for adoption by teams of all sizes.
