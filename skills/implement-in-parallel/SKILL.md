---
name: implement-in-parallel
description: Coordinate concurrent Worker Agents to implement the ready, unblocked direct Child Tickets of one GitHub Parent Ticket and push locally green commits directly to remote main without force. Use when the user wants one Parent Ticket implemented through its GitHub Child Tickets.
---

# Implement in Parallel

## Terms & boundaries

- **Parent Ticket**: A GitHub issue which has sub-issues.
- **Child Ticket**: An immediate child of the Parent Ticket in GitHub's native parent-child relationship.
- **Primary Agent**: The main agent coordinating one Parent Ticket; it only coordinates and does not implement the work.
- **Worker Agent**: A subagent implementing one Child Ticket; it can spawn its own sub-agents and Worker Agents run concurrently.
- **Worker Branch**: A branch whose name is its Child Ticket number.
- **Runnable**: A ticket that is open, has the `ready-for-agent` label, and has no open blocker via GitHub's native blocked-by relationship.
- **Green**: A Worker Branch is Green when all tests pass. A remote commit is Green when its CI passes.
- **Remote Main**: The `main` branch of the remote repository; Workers push to it without force.

## Primary Agent workflow

1. Check CI for the latest commit on Remote Main. If it is not Green, report and stop.
2. If the Parent Ticket is not Runnable, report and stop. Otherwise, remove its `ready-for-agent` label and continue.
3. Find every Child Ticket that is Runnable. Remove its `ready-for-agent` label and create a Worker Agent for each. Brief each Worker Agent with: "You are a Worker Agent per the `implement-in-parallel` skill; implement Child Ticket #<n>," where **#<n> is that ticket's number**. Run these Worker Agents; whenever one stops, repeat this step for Child Tickets that are Runnable.
4. When no Worker Agents remain:
   - If any Child Ticket remains open, report and stop.
   - Otherwise, comment on and close the Parent Ticket, then stop.

## Worker Agent workflow

1. Resume the existing Worker Branch and worktree when present. Otherwise, create them from the latest commit on Remote Main.
2. Read the Child Ticket and its comments. Follow the `implement` skill, make the Worker Branch Green, and commit.
3. Push the Worker Branch to Remote Main. After each non-fast-forward rejection, rebase it onto the latest commit on Remote Main, make it Green, and retry.
4. When the work is complete, comment on the Child Ticket with a human-readable result and the exact pushed commit. Close the ticket, remove its Worker Branch and worktree, and stop.
5. If the work cannot be completed, comment on the Child Ticket with a human-readable explanation of what prevented completion. Preserve useful unfinished work, and stop.
