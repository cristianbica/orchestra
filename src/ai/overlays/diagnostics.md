# Overlay: diagnostics

Purpose:
- Explain failures using runtime evidence rather than speculation.
- Turn logs, errors, telemetry, and tooling output into a defensible failure narrative.

When to apply:
- Incident analysis, bug triage, failing tests, broken builds, runtime errors, and operational troubleshooting.
- Work where logs, error messages, telemetry, traces, metrics, or debugger/tooling signals materially shape the answer.

Output focus:
- The observed failure signals and what they imply.
- A plausible root-cause explanation grounded in runtime evidence.
- The next checks or fixes that best match the failure pattern.

Decision prompts:
- What do the logs, errors, or runtime signals say directly?
- Which signal is primary, and which are secondary effects?
- What evidence best distinguishes root cause from symptom?

Quality checks:
- Failure analysis cites concrete signals, not guesses.
- Symptoms, root cause, and unknowns are separated clearly.
- Recommended next steps follow from the observed evidence.
