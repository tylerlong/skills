---
name: to-gh-tickets
description: Break work into tickets, create native GitHub parent and blocker relationships, and review the child tickets.
---

# To GitHub Tickets

1. Read the installed upstream `to-tickets` skill and follow it. Identify created child tickets and their intended blockers. Create one additional child ticket for checking and fixing CI, with all other child tickets as its intended blockers and the same intended Parent as the other child tickets.
2. For each child ticket, including the CI ticket created in step 1, create the intended Parent and every intended blocker as native GitHub relationships. Attempt each missing relationship at most once, without replacing a different Parent or removing extra blockers. Report any relationship that cannot be created and continue.
3. Remove the complete `## Parent` section only when the intended native Parent relationship exists. Remove the complete `## Blocked by` section only when every intended native blocker relationship exists.
4. Call the Skill tool with "review-result".
