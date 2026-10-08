# Playbooks

This folder holds repo-local reusable procedures. In this Orchestra framework repo, playbooks may describe maintainer operations that should not be distributed as app-specific defaults unless they are also added under `src/ai/playbooks/`.

## Local playbooks

- [orchestra-validation.md](orchestra-validation.md) - Run the Orchestra installer and adapter smoke validation.
- [quality-test.md](quality-test.md) - Evaluate Orchestra by reimplementing a real merged OSS PR in a temporary clone, then comparing against the actual PR.
