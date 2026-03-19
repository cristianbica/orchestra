# Overlay: performance

Purpose:
- Keep implementation choices efficient enough for the intended scale and usage.
- Reduce avoidable cost in queries, rendering, payloads, and runtime work.

When to apply:
- Query-heavy, render-heavy, high-throughput, or latency-sensitive changes.
- Work where efficiency should shape design or implementation choices.

Output focus:
- The main performance-sensitive paths and trade-offs.
- Practical efficiency improvements before premature optimization.
- Verification that likely bottlenecks were considered.

Decision prompts:
- Where is the likely cost: query, render, network, compute, or cache?
- Is there a simpler approach with better cost characteristics?
- What usage pattern or scale assumption matters here?

Quality checks:
- Likely bottlenecks are identified explicitly.
- Performance-sensitive decisions are proportional to expected load.
- Changes avoid obvious waste in hot paths.
