# Plan: Auto-load overlays in delegation flow

## Problem
Overlays in `.ai/overlays/` are documented but not automatically loaded when delegating work. Agents are instructed to "include relevant overlays" but there's no mechanism to actually do this, making it easy to forget.

## Root cause
- Overlay loading is mentioned in agent role files but buried there
- No explicit step in the delegation flow to load overlays
- No feedback loop to confirm overlays were applied

## Solution
Make overlay loading an explicit, visible step in the delegation flow by updating the delegation guide.

## Changes

### 1. Update `src/ai/agents/guides/delegation.md`
Add explicit overlay loading step to the delegation pattern:

```markdown
### Overlay loading (before delegating)

Before delegating to a subagent, load relevant overlays based on workflow type:

- Feature: value.md, system.md, ux.md
- Refactor: system.md, security.md
- Bug: system.md (add data.md for DB, security.md for sensitive)
- Investigate: system.md, data.md
- Document: value.md, ux.md, system.md

Load with: read_file the overlay files from `.ai/overlays/` and include them in the delegation prompt.
```

### 2. Add overlay reminder to workflow files
Add a visible "Overlays:" section at the top of each workflow file (change.md, investigate.md, document.md) so it's not hidden in agent roles.

## Verification
- Read updated delegation guide
- Confirm overlay loading is now explicit in the delegation flow
