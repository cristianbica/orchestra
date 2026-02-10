# Phase 3: Parallelization Workflow (Priority 1)

## 9. Create new workflow pattern

- Add `.ai/workflows/parallel-task.md` describing:
  - When to use (independent subtasks, voting/consensus, sectioning)
  - How to decompose tasks
  - How to merge results
  - Examples: Generate multiple test files, process multiple features

## 10. Document parallelization in agent roles

- Update `.ai/agents/conductor.md` to recognize when parallelization is appropriate
- Update `.ai/agents/architect.md` to plan parallel execution when beneficial

## 11. Add example parallel plan

- Create `.ai/plans/0000-00-03-example-parallel-refactor.md` showing real-world parallel task breakdown
