# Context management (agent guide)

This guide documents how to package and order context so an agent can reliably answer with minimal back-and-forth.

## Core rule

Put **documents first** and the **current request last**.

Reason: models tend to weight later instructions more heavily; putting the ask last reduces accidental “instruction splitting” and makes it clear what to do with the preceding context.

## Recommended ordering (top → bottom)

1. **Global rules / role constraints**
   - `AGENTS.md`, agent role file (e.g. `.ai/agents/builder.md`)
2. **Durable repo docs** (stable, reusable)
   - `.ai/docs/overview.md`
   - `.ai/docs/patterns/**` (only the relevant ones)
   - `.ai/docs/features/**` (only the relevant ones)
3. **Task-specific specs**
   - Ticket text, design notes, PR description, acceptance criteria
4. **Code context**
   - Small, targeted excerpts; prefer a few key files over many partials
5. **Constraints / preferences**
   - Non-goals, deadlines, “do not change X”, risk constraints
6. **The ask (query) — last**
   - A single, explicit request describing the desired output

## What to include (and what not)

Include:
- The **minimum** set of docs/code needed to make correct decisions.
- The **exact** constraints that must be followed.
- If you expect edits: the **file locations** that are in-scope.

Avoid:
- Dumping whole repos, large unrelated logs, or many near-duplicate files.
- Mixing multiple tasks/asks in one prompt; split into separate requests.

## Long documents: use explicit boundaries

When including long docs, use a consistent wrapper so it’s obvious where each document starts/ends.

Recommended format (one document per block):

<document>
<source>path/to/file.md</source>
<content>
…paste the relevant excerpt…
</content>
</document>

Guidelines:
- Prefer **excerpts** over full files; mention if content is truncated.
- If you have line numbers available, include them in the `<source>` line.
- Do not interleave unrelated documents inside the same `<content>`.

## Prompt caching strategy (cost + consistency)

If your runtime/provider supports prompt caching, structure prompts as:

- **Cacheable prefix (stable):** repo rules + durable docs/patterns that don’t change per task.
- **Variable suffix (changes often):** current diffs, file excerpts, and the current ask.

Rules of thumb:
- Keep the cacheable prefix **byte-for-byte stable** (avoid timestamps, counters, “today’s date”, etc.).
- Put the cacheable prefix **first**.
- Don’t “pepper” stable instructions throughout the variable suffix; keep them centralized.

Example layout:

<CACHEABLE_CONTEXT>
- AGENTS.md rules
- .ai/docs/overview.md (selected sections)
- relevant .ai/docs/patterns/* (selected)
</CACHEABLE_CONTEXT>

<TASK_CONTEXT>
- relevant code excerpts
- constraints
- THE ASK (last)
</TASK_CONTEXT>

## Default for this framework

When gathering context during discovery, follow this pattern:
- Load **rules and patterns first**.
- Load **task facts and code next**.
- Restate the **ask last**, in one sentence.
