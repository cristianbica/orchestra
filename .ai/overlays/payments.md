# Overlay: payments

Purpose:
- Keep billing and money-related work correct, traceable, and failure-aware.
- Reduce risk in transactional flows, reconciliation, and financial state changes.

When to apply:
- Billing, invoicing, subscriptions, settlements, refunds, or payment-provider integrations.
- Changes that affect monetary calculations or payment lifecycle state.

Output focus:
- Correct transaction flow and financial state transitions.
- Explicit handling of partial failure and reconciliation needs.
- Traceable behavior for support and audit follow-up.

Decision prompts:
- What financial state changes occur, and in what order?
- How are retries, duplicates, and partial failures handled?
- Can the resulting money movement be traced and reconciled?

Quality checks:
- Monetary calculations and state transitions are explicit.
- Duplicate or partial processing risk is addressed.
- Reconciliation and support visibility are considered.
