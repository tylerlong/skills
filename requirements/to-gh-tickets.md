# to-gh-tickets requirements

1. Invoke the `to-tickets` skill and wait for it to finish. Postprocess only the Child Tickets it produces, using the intended Parent and blockers it identifies.
2. For each Child Ticket, ensure those relationships exist natively in GitHub. Attempt each missing relationship at most once, without replacing a different Parent or removing extra blockers. Report any relationship that cannot be created and continue.
3. Remove the complete `## Parent` section only when the intended native Parent relationship exists. Remove the complete `## Blocked by` section only when every intended native blocker relationship exists or no blockers are intended.
4. Create one additional Child Ticket for checking and fixing CI. Ensure every other Child Ticket is a native blocker of it.
