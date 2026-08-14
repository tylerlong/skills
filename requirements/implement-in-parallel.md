# implement-in-parallel requirements

## Terms

- **Primary Agent**: The main agent coordinating one Parent Ticket.
- **Worker Agent**: A subagent implementing one Child Ticket.
- **Worker Branch**: A branch whose name is its Child Ticket number.
- **Direct Child Ticket**: An immediate child of the Parent Ticket in GitHub's native parent-child relationship.
- **Native Blocker**: A ticket linked as a blocker of a Child Ticket through GitHub's native blocked-by relationship.
- **Runnable**: A ticket that is open, has the `ready-for-agent` label, and has no open Native Blockers.
- **Green**: A Worker Branch is Green when all tests pass. A remote commit is Green when its CI passes.
- **Remote Main**: The `main` branch of the remote repository.

## Primary Agent workflow

1. The Primary Agent only coordinates; it does not implement changes or use a development branch or worktree.
2. If the Parent Ticket is not Runnable, report and stop. Otherwise, remove its `ready-for-agent` label and continue.
3. Check CI for the latest commit on Remote Main. If CI has failed, report and stop.
4. Find every Direct Child Ticket that is Runnable. Remove its `ready-for-agent` label and create a Worker Agent for each, each able to spawn its own sub-agents. Brief each Worker Agent with: "You are a Worker Agent per the `implement-in-parallel` skill; implement Child Ticket #<n>," where **#<n> is that ticket's number**. Run these Worker Agents concurrently; whenever one stops, repeat this step for Child Tickets that are Runnable.
5. When no Worker Agents remain:
   - If any Direct Child Ticket remains open, report and stop.
   - Otherwise, wait for CI on this run’s final pushed commit.
6. If CI passes, comment on and close the Parent Ticket, then stop.
7. If CI fails, create a Direct Child Ticket that is complete only when CI passes for its pushed fix, then create a Worker Agent for it.
8. When that Worker Agent stops:
   - If its Child Ticket remains open, report and stop.
   - If its Child Ticket is closed, comment on and close the Parent Ticket, then stop.

## Worker Agent workflow

1. Resume the existing Worker Branch and worktree when present. Otherwise, create them from the latest commit on Remote Main.
2. Read the Child Ticket and its comments. Follow the `implement` skill, make the Worker Branch Green, and commit.
3. Push the Worker Branch to Remote Main without force. After each non-fast-forward rejection, rebase it onto the latest commit on Remote Main, make it Green, and retry.
4. When the work is complete, comment on the Child Ticket with a human-readable result and the exact pushed commit. Close the ticket, remove its Worker Branch and worktree, and stop.
5. If the work cannot be completed, comment on the Child Ticket with a human-readable explanation of what prevented completion. Leave the ticket open, preserve useful unfinished work, and stop.
