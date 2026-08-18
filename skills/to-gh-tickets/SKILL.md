---
name: to-gh-tickets
description: Invoke the to-tickets skill, then create a CI-check child ticket blocked by all the others and make the intended Parent and blocker relationships of every child ticket native in GitHub, removing the duplicate relationship sections safely, then delegate review of the child tickets to a fresh sub-agent and edit based on accepted findings.
---

# To GitHub Tickets

1. Invoke the `to-tickets` skill. Identify created child tickets and their intended blockers. Create one additional child ticket for checking and fixing CI, with all other child tickets as its intended blockers.
2. For each child ticket, create the intended Parent and every intended blocker as native GitHub relationships. Attempt each missing relationship at most once, without replacing a different Parent or removing extra blockers. Report any relationship that cannot be created and continue.
3. Remove the complete `## Parent` section only when the intended native Parent relationship exists. Remove the complete `## Blocked by` section only when every intended native blocker relationship exists or no blockers are intended.
4. Delegate to a fresh sub-agent that has not seen this authoring conversation, giving it (1) the repository path on disk, (2) the Parent Ticket number, and (3) the child ticket numbers, and instruct it to review the child tickets against the to-tickets rules, reporting concrete findings and recommended edits. Edit the tickets based on the findings you accept, and repeat until the review reports no findings or every remaining finding is one you have rejected.
