---
name: implement-in-parallel
description: Implement a GitHub Parent Ticket by coordinating parallel Worker Agents for its runnable Child Tickets, then review all resulting commits.
---

# Implement in Parallel

## Terms & boundaries

- **Parent Ticket**: A GitHub issue which has sub-issues.
- **Child Ticket**: An immediate child of the Parent Ticket in GitHub's native parent-child relationship.
- **Primary Agent**: The main agent that coordinates one Parent Ticket and does not implement the work.
- **Worker Agent**: A subagent implementing one Child Ticket; it can spawn its own sub-agents and Worker Agents run concurrently.
- **Worker Branch**: A branch whose name is its Child Ticket number.
- **Runnable**: A ticket is Runnable when it is open, has the `ready-for-agent` label, and has no open blocker via GitHub's native blocked-by relationship.
- **Green**: A Worker Branch is Green when all tests pass. A remote commit is Green when its CI passes.
- **Remote Main**: The `main` branch of the remote repository; Worker Agents push to it without force.
- **Since this skill run**: All commits on Remote Main after the commit that was latest when the skill started.

## Primary Agent workflow

1. If CI of Remote Main is not Green, report and stop.
2. If the Parent Ticket is not Runnable, report and stop. Otherwise, remove its `ready-for-agent` label and continue.
3. For each Runnable Child Ticket, remove its `ready-for-agent` label, run a Worker Agent, and brief it with: "You are a Worker Agent per the `implement-in-parallel` skill; implement Child Ticket #<n>", where "#<n>" is the ticket number. Whenever a Worker Agent stops, repeat this step.
4. When no Worker Agents remain:
   - If any Child Ticket remains open, report and stop.
   - Otherwise, call the Skill tool with "review-result". Then comment on and close the Parent Ticket, and stop.

## Worker Agent workflow

1. Resume the existing Worker Branch and worktree when present. Otherwise, create them from the latest commit on Remote Main.
2. Read the Parent and Child Tickets and their comments. Read the installed upstream `implement` skill at `~/.agents/skills/implement/SKILL.md` and follow it, make the Worker Branch Green, and commit.
3. Push the Worker Branch to Remote Main. After each non-fast-forward rejection, rebase it onto the latest commit on Remote Main, make it Green, and retry.
4. When the work is complete, comment on the Child Ticket with a result and the exact pushed commit. Close the ticket, remove its Worker Branch and worktree, and stop.
5. If the work cannot be completed, comment on the Child Ticket with what prevented it, preserve useful unfinished work, and stop.
