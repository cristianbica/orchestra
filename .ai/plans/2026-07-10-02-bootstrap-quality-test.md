# Plan: Bootstrap Orchestra Quality Tests

## Goal

Make quality-test runs evaluate Orchestra on bootstrapped target repositories.

## Changes

1. Update only `.ai/playbooks/quality-test.md`; this is an Orchestra development
   playbook and must not be distributed through `src/ai`.
2. Require a separate unattended bootstrap run in `orchestra/` and the optional
   `orchestra-<ref>/` after Orchestra installation and before implementation.
3. Use the same bootstrap prompt, model, allowed evidence, and limits for both
   Orchestra variants; do not bootstrap `vanilla/` or `actual/`.
4. Constrain bootstrap to the detached base checkout and prohibit inspecting the
   PR, later commits, remote refs, patches, or implementation-equivalent evidence.
5. Require the inline approval plan to show exact bootstrap commands, working
   directories, timeouts, writes, and network behavior.
6. Preserve bootstrap logs and summarize the generated context, but treat
   bootstrap as unmeasured test preparation: exclude its tokens, duration, and
   cost from all comparison tables and totals.
7. Stop before implementation if bootstrap fails or crosses the trust boundary.
8. Update playbook verification notes; doc impact outside the playbook: none.

## Validation

- Run focused playbook structure/content checks with `rg` and `diff`.
- Run `bash scripts/verify.sh` if its scope is compatible with the dirty tree.
