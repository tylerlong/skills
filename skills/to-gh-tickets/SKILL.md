---
name: to-gh-tickets
description: Invoke to-tickets, then postprocess only its newly published GitHub Child Tickets so their intended Parent and blocker relationships are native and duplicate relationship sections are removed safely.
---

# To GitHub Tickets

1. Invoke `to-tickets` and wait until its complete workflow has published the approved Child Tickets.
2. Postprocess only the Child Tickets produced by that run. Use the Parent Ticket and blocker mapping established by `to-tickets`; do not repeat any `to-tickets` responsibility.
3. For each produced Child Ticket, confirm that its intended Parent Ticket and every intended blocker exist as native GitHub relationships. Create each missing intended relationship once. Do not replace a different existing Parent Ticket or remove extra blockers.
4. After confirming the intended native Parent relationship, remove the complete `## Parent` section from that Child Ticket body if present. Do not remove Parent references elsewhere in the body.
5. After confirming every intended native blocker relationship, remove the complete `## Blocked by` section from that Child Ticket body if present. Remove an empty `## Blocked by` section when no blockers are intended. If any intended blocker relationship is absent, leave the entire section unchanged. Do not remove blocker references elsewhere in the body.
6. If an intended native relationship cannot be created directly or its creation fails, do not retry it. Retain its corresponding body section, report the failure, and continue processing every other relationship and Child Ticket, including independently processable relationships and sections on the same Child Ticket.
