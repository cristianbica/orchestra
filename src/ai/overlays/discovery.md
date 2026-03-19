# Overlay: discovery

Purpose:
- Find the right code, docs, systems, and local repo context before deciding or changing anything.
- Reduce wasted effort caused by starting implementation from the wrong entry points or assumptions.

When to apply:
- Early repo exploration, file/entry-point discovery, and dependency tracing.
- Work where the first step is locating the relevant code, docs, ownership, or surrounding system context.

Output focus:
- The most relevant files, docs, commands, and nearby systems.
- Clear mapping from the request to likely entry points and dependencies.
- Gaps or ambiguities that still need investigation.

Decision prompts:
- Where does this behavior likely live in the repo?
- Which files, docs, or systems are closest to the requested change or question?
- What local context would most reduce the chance of searching in the wrong place?

Quality checks:
- Relevant entry points and adjacent context are identified explicitly.
- Discovery stays targeted instead of turning into broad repo scanning.
- Findings are concrete enough to guide the next step.
