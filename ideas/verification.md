# Phase 2: Verification Standards (Priority 1)

## 5. Enhance plan template with verification section

- Update `.ai/templates/plan.template.md` to include:

```markdown
## Verification Commands
- [ ] Build: `<exact command>` (expected: exits 0, timing: ~30s)
- [ ] Test: `<exact command>` (expected: all green, timing: ~2m)
- [ ] Lint: `<exact command>` (expected: 0 warnings)
- [ ] Manual smoke test: <what to check>
- [ ] Expected evidence: <screenshots, logs, outputs>
```

## 6. Update all agent definitions to require verification

- Modify `.ai/agents/architect.md` `<plan_style_guide>` to mandate verification section
- Modify `.ai/agents/builder.md` workflow to require running + reporting verification commands
- Modify `.ai/agents/inspector.md` review gates to validate verification was performed

## 7. Update existing plan examples

- Enhance `.ai/plans/01-bootstrap.md` with explicit verification commands
- Enhance `.ai/plans/02-refresh-context.md` with verification checklist

## 8. Update workflow templates

- Add verification requirements to `.ai/workflows/implement-feature.md`, `fix-bug.md`, `refactor.md`
