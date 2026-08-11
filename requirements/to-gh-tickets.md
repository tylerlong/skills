# to-gh-tickets requirements

1. Invoke `to-tickets` and wait until it finishes its complete workflow, including publication of the approved Child Tickets, before performing any GitHub-specific postprocessing.
2. Postprocess only the Child Tickets produced by that `to-tickets` run. Use the Parent Ticket and blocker mapping established by `to-tickets`; do not repeat any `to-tickets` responsibility.
3. For each produced Child Ticket, confirm that its intended Parent Ticket and every intended blocker exist as native GitHub relationships. Create each missing intended relationship once, without replacing a different existing Parent Ticket or removing extra blockers.
4. After confirming the intended native Parent relationship, remove the complete `## Parent` section from that Child Ticket body if present. Do not remove Parent references elsewhere in the body.
5. After confirming every intended native blocker relationship, remove the complete `## Blocked by` section from that Child Ticket body if present. Remove an empty `## Blocked by` section when no blockers are intended. If any intended blocker relationship is absent, leave the entire section unchanged. Do not remove blocker references elsewhere in the body.
6. If an intended native relationship cannot be created directly or its creation fails, do not retry it. Retain its corresponding body section, report the failure, and continue processing every other relationship and Child Ticket, including independently processable relationships and sections on the same Child Ticket.
