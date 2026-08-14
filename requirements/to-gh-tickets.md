# to-gh-tickets requirements

1. Invoke the `to-tickets` skill. Identify created child tickets and their intended blockers. Create one additional child ticket for checking and fixing CI, with all other child tickets as its intended blockers.
2. For each child ticket, create the intended Parent and every intended blocker as native GitHub relationships. Attempt each missing relationship at most once, without replacing a different Parent or removing extra blockers. Report any relationship that cannot be created and continue.
3. Remove the complete `## Parent` section only when the intended native Parent relationship exists. Remove the complete `## Blocked by` section only when every intended native blocker relationship exists or no blockers are intended.
