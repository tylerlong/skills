## Terms

- **Primary Agent**: The main agent coordinating one Parent Ticket.
- **Worker Agent**: A subagent implementing one Child Ticket.
- **Worker Branch**: A branch named with its Child Ticket number.
- **ready-for-agent**: A ticket label.
- **Green**: A Worker Branch is green when all tests pass. A remote commit is green when its CI passes.

## Primary Agent workflow

1. Check the Parent Ticket for `ready-for-agent`. If absent, report the issue and stop. Otherwise, remove it and continue.

2. Check CI for the current `origin/main`. If CI has failed, report the issue and stop.

3. Find every open direct Child Ticket with `ready-for-agent` and no open native blockers. Remove the label and create a Worker Agent for each. The Worker Agents run concurrently.

4. Whenever a Worker Agent stops, repeat the previous step for runnable Child Tickets.

5. When no Worker Agents remain:

   - If any Child Ticket remains open, report the blockers and stop.
   - Otherwise, wait for CI on this run’s final pushed commit.

6. If CI passes, comment on and close the Parent Ticket, then stop.

7. If CI fails, create a direct Child Ticket whose requirement is to make CI green, then create a Worker Agent for it.

8. When that Worker Agent stops:

   - If its Child Ticket remains open, report the blocker and stop.
   - If its Child Ticket is closed, comment on and close the Parent Ticket, then stop.

The Primary Agent only coordinates. It has no development branch or worktree and does not implement changes.

## Worker Agent workflow

1. Resume the existing Worker Branch and worktree when present. Otherwise, create them from the latest `origin/main`.

2. Read the Child Ticket and its comments. Follow `implement`, make the Worker Branch green, and commit.

3. Push the Worker Branch to `origin/main` without force. If rejected because the push is not a fast-forward, merge the latest `origin/main` into the Worker Branch, make it green, commit, and retry.

4. When the work is complete, comment on the Child Ticket with a human-readable result and the exact pushed commit. Close the ticket, remove its Worker Branch and worktree, and stop.

5. If the work cannot be completed, comment on the Child Ticket with a human-readable explanation of the blocker and what must happen to unblock it. Leave the ticket open, preserve useful unfinished work, and stop.
