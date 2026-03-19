# Overlay: investigation

Purpose:
- Reduce uncertainty with the fastest useful evidence, not just local code reading.
- Encourage focused fact-finding before committing to a diagnosis, plan, or implementation path.

When to apply:
- Debugging, root-cause analysis, planning under uncertainty, and ambiguous task intake.
- Work that may require code, docs, web references, MCP/tools, logs, repro steps, or experiments to resolve unknowns.

Output focus:
- The key unknowns and the evidence gathered to resolve them.
- What was checked, what was ruled out, and what remains uncertain.
- The shortest defensible conclusion or next step.

Decision prompts:
- What is still unknown, and which source is most likely to resolve it quickly?
- Should this be answered with code inspection, docs, runtime evidence, tooling, or a small experiment?
- What evidence would be strong enough to stop guessing?

Quality checks:
- Investigation uses the most relevant sources instead of defaulting to one.
- Conclusions are tied to evidence, not intuition.
- Remaining uncertainty is explicit when it cannot be eliminated.
