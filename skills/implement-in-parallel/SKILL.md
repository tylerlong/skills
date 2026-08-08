---
name: implement-in-parallel
description: Implement, resume, and deliver the ready direct children of one GitHub Parent Ticket in an isolated Batch Run. Use when the user invokes $implement-in-parallel to coordinate dependency-aware workers, continue safely from sparse checkpoints, deliver Batch PRs through the Delivery Turn, and prove exact main CI green.
---

# Implement in Parallel

Reuse the installed `implement` workflow for Child Ticket work. Own only Parent
Ticket discovery, dependency-aware orchestration, integration, combined
validation, resumability, PR and CI delivery, and tracker updates here.

## 1. Load the implementation workflow

Resolve `../implement/SKILL.md` relative to this skill and read it completely.
Treat it as the worker implementation contract, subject only to the limits below.
Stop if it is missing or unreadable; never copy or reconstruct its rules.

## 2. Use explicit outcomes and sparse checkpoints

Use exactly these outcomes:

- **Do Not Start**: required input or initially runnable work is absent. Create no
  Batch Run, Git artifact, or checkpoint.
- **Resumable Stop**: a started Batch Run cannot continue. Atomically update its
  checkpoint, preserve every unfinished artifact, report the blocker and exact
  next action, and stop.
- **Complete**: every frozen Child Ticket is delivered and closed, final tracker
  updates are done, local `main` is synchronized, and successful owned artifacts
  are cleaned.

Store at most one active checkpoint at
`<git-common-dir>/implement-in-parallel-parent-<parent>.md`. It is sparse Markdown
outside every worktree and branch. Record only the repository and Parent Ticket,
frozen child numbers, current Batch Base/Branch/Worktree, integrated and delivered
child commits, exact candidate review and verification evidence, PR heads and CI,
merge and exact `main` CI evidence, Delivery Turn ownership, external write/retry
usage, owned artifacts, and the next action. Git commits are authoritative for
code; GitHub Tickets are authoritative for requirements and public ticket state;
PRs and CI are authoritative for their own delivery state; the checkpoint is only
authoritative for orchestration progress.

Write the checkpoint atomically after new-run initialization, each integrated
Child Ticket commit, exact combined validation, exact PR CI, a PR merge, and
immediately before every Resumable Stop. Do not record routine commands, worker
starts, or polls. Remove the checkpoint only at Complete.

When the checkpoint exists, resume instead of starting another Batch Run. Before
acting, reconcile every claim with current Git and GitHub state, including exact
commits, branches, worktrees, PRs, ticket relationships, and CI runs. Retain and
refresh the recorded frozen set; report and defer newly added children. Discard a
claim only when authoritative state contradicts it. Never repeat valid completed
implementation, dispatch, integration, push, review, verification, PR creation,
merge, or CI work.

## 3. Bound external operations

For a synchronous transient failure, make only three retries after the initial
attempt, waiting 5, 15, and 30 seconds. Before retrying a write, reconcile whether
the desired external state already exists. When it does, treat the prior attempt
as successful without consuming or issuing the next retry. Do not retry explicit
rejection, permission, credential, infrastructure, or human-decision failures.

Once an asynchronous operation is accepted, observe it without resubmitting it.
Poll a not-yet-executing operation every 15 seconds and make a Resumable Stop after
2 minutes without a lifecycle transition. Poll an executing operation every 30
seconds and make a Resumable Stop 20 minutes after its provider-reported start.
A status page is optional one-time diagnostic evidence, never a reason to extend
these limits.

When a required CI run remains absent, dispatch one existing equivalent workflow
only if the repository already supports that dispatch. Rerun a completed CI run
at most once, and only when its evidence proves a transient failure. Persist both
allowances before using them. A reservation remains consumed even when its write
response is lost and reconciliation cannot find the operation; checkpoint and
stop rather than letting a resume use either allowance twice.

An external, permission, infrastructure, credential, or human-only blocker stops
new worker dispatch and monitoring. Preserve open tickets and all unfinished
artifacts, record the exact next action, and make a Resumable Stop.
If it occurs before any Batch Run starts, instead report the exact next action and
return Do Not Start without creating an artifact or checkpoint.

## 4. Inspect the repository and Parent Ticket

- Require exactly one GitHub Parent Ticket number or URL and one current Git
  repository. Infer the GitHub repository from its remote.
- Read the repository's agent instructions, issue-tracker configuration, triage
  label mapping, and relevant owner documents before changing anything.
- Read the Parent Ticket's complete body, comments, state, and labels through the
  configured GitHub workflow.
- Discover only its direct native GitHub Child Tickets. Read every child's
  complete body, comments, state, labels, native parent, and native blockers.
- Treat native relationships as authoritative. Never infer them from ticket
  bodies, or add, remove, assign, or relabel tickets.

For a new run, freeze the direct Child Ticket numbers. On resume, use the numbers
already in the checkpoint. At every refresh, report newly added children and
defer them to another run; never expand the frozen set.

Treat a closed child as satisfied. Treat an open child as eligible only when it
has the repository-configured `ready-for-agent` label. An eligible child is
runnable only when each native blocker is closed or its frozen direct Child
Ticket commit is already integrated in this Batch Run.

For a new run, return Do Not Start before creating Git artifacts when the Parent
Ticket has no direct children, no open ready children, or no initially runnable
child. For no children, tell the user to run `to-gh-tickets`; otherwise report
every exclusion or blocker. An existing checkpoint instead follows resume rules.

## 5. Create or resume an isolated Batch Run

Do not require, enter, clean, switch, stash, reset, or otherwise modify the caller
checkout or its local `main`. Never edit or overwrite the global Installed Skill.

1. For a new run, fetch `origin` without switching branches and record the fetched
   `origin/main` commit as the Batch Base. From it, create one task-owned Batch
   Branch and Batch Worktree outside the caller checkout. Name both with the
   Parent Ticket number; use `codex/parallel-<parent>-batch` when available, then
   write the initialized checkpoint.
2. For a resumed run, reconcile and reuse only artifacts proven owned by its
   checkpoint. If an earlier PR delivered some frozen children, preserve that
   evidence and create the next delivery cycle from current `origin/main`; a
   resumed Batch Run may deliver blocked work in additional PRs.
3. Perform all coordination, integration, review, verification, push, and PR work
   inside the Batch Worktree. Treat every other task worktree as foreign: never
   enter or modify it.
4. If an artifact is not proven by the checkpoint or is ambiguous, preserve it,
   record its identity and the first required human action, and make a Resumable
   Stop. Never guess that it is safe to reuse or delete.

One ready child and many ready children always use this same Batch Run path.

## 6. Schedule Child Ticket workers

Use available worker-agent capacity while keeping the primary agent as coordinator
and integrator. Schedule only by native blockers and capacity. Do not inspect
likely file overlap or predict conflicts before dispatch.

Immediately before dispatch, refresh the Parent Ticket's direct children and the
selected child's requirements, comments, state, readiness, native parent, and
blockers. Defer new child numbers. Pause a selected child when its task-defining
state changed materially; preserve its artifacts and require a later invocation
to accept the changed scope.

For each runnable child:

1. Create a task-owned Child Branch and Child Worktree from the current Batch
   Branch commit containing all integrated blockers.
2. Give its worker the Parent and Child Ticket context, repository instructions,
   exact starting commit and owned paths, the complete loaded `implement` rules,
   and the worker limits below.
3. Start confidently independent runnable children concurrently up to available
   capacity. Never make workers monitor or synchronize with one another.

Require every ticket, reconciliation, review-repair, verification-repair, or
CI-repair worker to:

- work only on its assigned ticket or repair and never enter another task's
  worktree;
- use the installed `implement` workflow and its agreed TDD seam where
  appropriate;
- run focused checks, not the full repository verification;
- return exactly one final Child Ticket commit for ticket work, while keeping any
  repair commit separate;
- avoid auto-closing keywords, pushes, merges, GitHub mutation, final combined
  review, and full repository verification; and
- leave its owned worktree clean and report its commit and focused evidence.

Correct coordinator scheduling or branch-state mistakes and resume the same
worker. Return implementation failures with the existing diff and evidence to
that worker. Allow at most one fresh-worker attempt for lost context or one
genuinely different technical approach; never restart from a blank prompt.
Preserve and report permission, infrastructure, credential, and human-decision
blockers instead of retrying them with another worker.

When a worker finds an undeclared prerequisite, preserve and pause that child.
If the prerequisite is another frozen direct child, integrate it first, update
the paused branch onto the resulting Batch Branch commit, and resume the same
worker. Otherwise report the prerequisite without changing the issue graph and
continue independent work.

## 7. Integrate continuously

As each worker finishes:

1. Confirm its focused checks, single final ticket commit, and clean worktree.
2. Refresh the selected child and the Parent Ticket's current direct children.
   Defer new children and pause material task changes rather than integrating
   stale work.
3. Cherry-pick that child's one final commit onto the Batch Branch and mark it
   locally integrated. Immediately checkpoint the exact integrated commit.
4. Immediately fill capacity with every newly runnable frozen child.

Integrate completed children one at a time. Handle conflicts only when Git or the
combined behavior proves they exist:

1. Abort the integration attempt and preserve the Child Branch and Worktree.
2. Update that child's branch onto the current Batch Branch commit.
3. Return the actual conflict and both accepted behaviors to its worker. Require
   focused checks and one replacement ticket commit.
4. Integrate the replacement and continue scheduling.

When no worker remains, classify every unintegrated frozen child as excluded,
paused, blocked by an incomplete frozen child, or blocked out of scope. Continue
only if at least one undelivered Child Ticket commit is integrated. Do not create
a PR while any frozen child is runnable and unfinished. If no undelivered change
can progress, publish actionable status, checkpoint, and make a Resumable Stop.

## 8. Review and verify the exact candidate

Discover the canonical full verification procedure from repository agent or
development instructions, then documented scripts or targets, then CI commands.
When none is trustworthy, preserve all run-owned artifacts, checkpoint the exact
next action, and make a Resumable Stop.

For the exact Batch Branch commit:

1. Run the installed `code-review` workflow against the Batch Base and accept or
   reject each finding explicitly.
2. Give accepted review findings to a dedicated repair worker on a temporary
   repair branch and worktree from the Batch Branch. Integrate its separate repair
   commit, then repeat combined review.
3. Run the canonical full repository verification once review is clean.
4. Give implementation-caused failures and exact logs to a dedicated repair
   worker. Integrate its separate repair commit, then repeat combined review and
   full verification.

The coordinator never implements a repair directly on the Batch Branch. Any
candidate change invalidates all earlier combined review and full-verification
evidence; rerun both against the new exact commit.

After both gates pass, checkpoint their evidence against the exact candidate.
On resume, reuse it only while that commit and the authoritative evidence remain
unchanged.

After exact combined validation, refresh the frozen tickets and blockers. If
another child is now runnable, return to scheduling, integrate it into the same
Batch Branch, and repeat all invalidated gates. Proceed only when deliverable
changes exist and no frozen child can currently make more progress.

## 9. Create and verify the Batch PR

1. Push the Batch Branch normally without force.
2. Open one non-draft PR targeting `main`. Identify the Parent Ticket and the
   included Child Tickets without using auto-closing keywords.
3. Confirm the PR head is the exact reviewed and fully verified Batch Branch
   commit.
4. Monitor all relevant PR CI checks for that exact commit within the external
   observation limits until terminal.
5. For an implementation-caused CI failure, give the logs to a dedicated repair
   worker, integrate its separate repair commit, and repeat combined review, full
   verification, normal push, and exact-commit PR CI.

If the candidate changes for any reason, its earlier review, verification, and CI
evidence is stale. For an external or human-only failure, checkpoint its evidence
and next action and make a Resumable Stop rather than claiming success.

After exact PR CI is green, checkpoint the PR, exact head, and run evidence;
preserve every run-owned artifact and continue to the Delivery Turn. Never push
or merge through local `main`.

## 10. Deliver through the Delivery Turn

The Delivery Turn is the repository-wide atomic lock directory
`<git-common-dir>/implement-in-parallel-delivery-turn.lock`. Its `owner` record
contains the Parent Ticket number, Codex task identity, Batch Branch, and PR.
Every Batch Run must use that exact path. Attempt to acquire it only after the
exact PR head has green combined review, full verification, and PR CI evidence.

On resume, when this Parent's checkpoint says it owns the turn and the `owner`
record exactly matches the checkpoint, reconcile the PR and `origin/main` and
continue the recorded post-merge obligation without acquiring a second lock.
Never use a checkpoint to alter a mismatched or different-Parent lock.

Acquire the turn with one atomic create operation, such as creating a previously
absent lock directory. Immediately write the owner record inside it. Except for
the exact same-Parent resume case above, treat an existing or ownerless lock as
unavailable: checkpoint, preserve all state, report its identity, and make an
immediate Resumable Stop without polling, deleting, replacing, or guessing
ownership.

While holding the turn:

1. Refresh every frozen Child Ticket's requirements, state, readiness, native
   parent, and blockers. Do not merge while a frozen child is runnable and
   unfinished. Instead, verify lock ownership, release it immediately, implement
   and integrate that child, update the existing Batch PR, and rerun combined
   review, full verification, and exact PR CI before trying again.
2. Fetch `origin/main`. If it advanced beyond the PR's reviewed base, merge the
   fetched commit into the Batch Branch. Give any real conflict to a dedicated
   worker in its own branch and worktree. Push the changed Batch Branch, release
   the turn immediately, and rerun every candidate gate outside the turn before
   trying again.
3. Reconfirm that the PR head is the exact green candidate and merge the PR
   through GitHub with a merge commit, without deleting its branch yet. After
   GitHub reports the merge, capture the resulting merge commit and immediately
   checkpoint it. Then fetch `origin/main` and verify that it is that exact commit
   and contains the Batch Branch head.
4. Keep the turn while monitoring CI for that exact remote `main` commit. A
   non-green result never closes tickets, reports completion, or releases
   responsibility as though delivery succeeded. Checkpoint the result, preserve
   the turn and all artifacts, and make a Resumable Stop if current repair rules
   cannot make progress.
5. On exact green `main` CI, verify ownership and release the turn immediately,
   then checkpoint the green evidence.

If a merge request fails and GitHub proves no merge occurred, release the owned
turn, checkpoint, and make a Resumable Stop. If the merge result is uncertain,
keep the turn until the remote PR and `main` state are reconciled, then checkpoint
the proven state before continuing or stopping.

## 11. Update tickets, synchronize, and clean up

Perform these steps only after releasing the Delivery Turn following exact green
remote `main` CI:

1. Comment on every delivered Child Ticket with the PR, merge commit, final
   verification, and exact `main` CI evidence, then close it.
2. Comment on each excluded, paused, or blocked child with its exact blocker and
   next action. Leave it open and preserve its labels and native relationships.
3. Refresh every current direct Child Ticket, including children added after the
   frozen snapshot. Add one concise Parent Ticket summary and close the Parent
   only when every current direct child is closed.
4. Fetch `origin/main` and attempt to fast-forward the local `main` mirror only
   when it has no local-only commits, is an ancestor of the fetched remote, and is
   not checked out in a dirty, foreign, or otherwise unsafe worktree. Never
   overwrite, reset, commit, merge, or push through an ahead, divergent,
   checked-out, dirty, or ambiguous local `main`; preserve it and report the exact
   action needed in a checkpointed Resumable Stop.
5. Remove only successfully delivered branches and worktrees owned by this Batch
   Run, including its remote Batch Branch after the merged PR no longer needs it.
   Preserve every blocked, unfinished, ambiguous, and unrelated artifact.

If delivered work is complete but frozen children remain blocked, remove only the
delivered cycle's proven artifacts, retain the checkpoint and frozen set, and make
a Resumable Stop. Resume later into another PR without repeating delivered work.

Report Complete and remove the checkpoint only after every frozen Child Ticket is
delivered and closed, tracker updates and local `main` synchronization finish, and
all successfully delivered owned artifacts are cleaned.
