# implement-in-parallel requirements

## Terms

- **Primary Agent**: The main agent coordinating one Parent Ticket.
- **Worker Agent**: A subagent implementing one Child Ticket.
- **Worker Branch**: A branch whose name is its Child Ticket number.
- **Direct Child Ticket**: An immediate child of the Parent Ticket in GitHub's native parent-child relationship.
- **Native blocker**: A ticket linked as a blocker of a Child Ticket through GitHub's native blocked-by relationship.
- **ready-for-agent**: A ticket label.
- **Green**: A Worker Branch is green when all tests pass. A remote commit is green when its CI passes.

## Primary Agent workflow

1. The Primary Agent only coordinates; it does not implement changes or use a development branch or worktree.
2. Check the Parent Ticket for `ready-for-agent`. If absent, report the issue to the user and stop. Otherwise, remove it and continue.
3. Check CI for the current commit on the remote repository's `main` branch. If CI has failed, report the issue to the user and stop.
4. Find every open direct Child Ticket with `ready-for-agent` and no open native blockers. Remove the label and create a Worker Agent for each. These Worker Agents run concurrently; whenever one stops, repeat this step for runnable Child Tickets.
5. When no Worker Agents remain:
   - If any direct Child Ticket remains open, report the remaining open Child Tickets to the user and stop.
   - Otherwise, wait for CI on this run’s final pushed commit.
6. If CI passes, comment on and close the Parent Ticket, then stop.
7. If CI fails, create a direct Child Ticket that is complete only when CI passes for its pushed fix, then create a Worker Agent for it.
8. When that Worker Agent stops:
   - If its Child Ticket remains open, report the blocker to the user and stop.
   - If its Child Ticket is closed, comment on and close the Parent Ticket, then stop.

## Worker Agent workflow

1. Resume the existing Worker Branch and worktree when present. Otherwise, create them from the latest commit on the remote repository's `main` branch.
2. Read the Child Ticket and its comments. Follow the `implement` skill, make the Worker Branch green, and commit.
3. Push the Worker Branch to the remote repository's `main` branch without force. After each non-fast-forward rejection, merge the latest commit from the remote repository's `main` branch into the Worker Branch, make it green, commit, and retry.
4. When the work is complete, comment on the Child Ticket with a human-readable result and the exact pushed commit. Close the ticket, remove its Worker Branch and worktree, and stop.
5. If the work cannot be completed, comment on the Child Ticket with a human-readable explanation of the blocker and what must happen to unblock it. Leave the ticket open, preserve useful unfinished work, and stop.
