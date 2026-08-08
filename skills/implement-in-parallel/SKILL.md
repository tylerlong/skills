---
name: implement-in-parallel
description: Implement, resume, and deliver the ready direct children of one GitHub Parent Ticket in an isolated Batch Run. Use when the user invokes $implement-in-parallel to coordinate dependency-aware workers, recover interrupted or failed deliveries, serialize Batch PR merges, and prove exact main CI green.
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
merge and exact `main` CI evidence, Delivery Turn ownership and phase, external
write/retry usage, owned artifacts, and the next action. Git commits are authoritative for
code; GitHub Tickets are authoritative for requirements and public ticket state;
PRs and CI are authoritative for their own delivery state; the checkpoint is only
authoritative for orchestration progress.

Write the checkpoint atomically after new-run initialization, each integrated
Child Ticket commit, exact combined validation, exact PR CI, Delivery Turn
acquisition or inheritance, a PR merge, every ownership-phase change, and
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

Before starting or resuming ordinary Child Ticket work, at every coordinator phase
transition, and during every external-monitoring poll, inspect the Delivery Turn.
Another run's normal delivery phase does not prevent concurrent work outside the
turn. Repair suspension is cooperative: when a coordinator observes `repair`, it
stops its own dispatch, integration, review, verification, push, PR, and monitoring
activity, halts its workers at recoverable boundaries, checkpoints their artifacts,
and makes a Resumable Stop.

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

The Delivery Turn is the repository-wide atomic lock file
`<git-common-dir>/implement-in-parallel-delivery-turn.lock`. Its complete owner
record contains the Parent Ticket number, Codex task identity, Batch Branch, PR,
and `delivery` or `repair` phase. Every Batch Run uses that exact path and serializes
all reads and mutations through a stable `<lock>.guard` file held with a
process-scoped OS advisory lock. The guard file carries no ownership, may persist,
and releases its mutex automatically when a task ends. While holding the guard,
prepare the owner record beside the lock and acquire with one exclusive atomic
create that makes the complete record visible only when the lock was absent; never
expose an ownerless or partial lock. Attempt acquisition only after the exact PR
head has green combined review, full verification, and PR CI evidence, then
checkpoint it and release the guard immediately. Keep every guard critical section
short; never hold its advisory mutex while doing GitHub work, CI observation,
review, verification, or implementation.

On resume, reconcile the lock, checkpoint, PR, and `origin/main` before acting.
Inherit a same-Parent lock only when its recorded task is proven inactive and its
branch, PR, exact head, phase, and merge state agree with authoritative evidence.
Acquire the guard's exclusive advisory mutex, re-read and match the unchanged
owner, atomically replace it with the current task identity, checkpoint the
inheritance, then release the mutex. Activity age, a missing process guess, or
Parent number alone is not proof. A completed checkpointed Resumable Stop or conclusive
orchestration-provider evidence that the recorded task ended is proof. If the
mutex, inactivity, or unchanged owner cannot be proven, treat the turn as busy.

The lock record is authoritative only for current ownership and phase. Change it
atomically before checkpointing the corresponding phase. After an interrupted
two-write transition, only the same proven owner may reconcile a lagging checkpoint
from the lock plus Git, PR, and CI evidence; every other mismatch is ambiguous and
must stop.

Treat every active, ambiguous, unmatched, or different-Parent lock as unavailable:
checkpoint, preserve all state, report its owner, and make an immediate Resumable
Stop without polling, deleting, replacing, or guessing ownership. Explicitly
abandon any recorded turn only when the user names that run and asks, after
reconciling its owning checkpoint and PR and proving that neither its recorded head
nor PR was merged into `origin/main`. Atomically record no ownership in that
checkpoint immediately after releasing the exact unchanged lock; preserve tickets
and artifacts unless their cleanup was separately authorized. If the merge
occurred or remains uncertain, retain the turn for delivery or repair.

While holding the turn:

1. Refresh every frozen Child Ticket's requirements, state, readiness, native
   parent, and blockers. Do not merge while a frozen child is runnable and
   unfinished. Instead, verify lock ownership, release it immediately, implement
   and integrate that child, update the existing Batch PR, and rerun combined
   review, full verification, and exact PR CI before trying again.
2. Fetch `origin/main`. If it advanced beyond the PR's reviewed base, immediately
   invalidate the checkpoint's combined review, full verification, and PR CI.
   Merge the fetched commit into the Batch Branch. For a conflict, abort the merge,
   release the turn, checkpoint the new base and no ownership, and give the exact
   conflict to a dedicated worker in its own branch and worktree. After a clean
   merge, release the turn and checkpoint the changed exact head and no ownership
   before pushing. Resolve or push outside the turn, then rerun every candidate
   gate against the changed exact commit before trying again.
3. Reconfirm that the PR head is the exact green candidate and merge the PR
   through GitHub with a merge commit, without deleting its branch yet. After
   GitHub reports the merge, capture the resulting merge commit and immediately
   checkpoint it. Then fetch `origin/main` and verify that it is that exact commit
   and contains the Batch Branch head.
4. Keep the turn while monitoring CI for that exact remote `main` commit. A
   non-green result never closes tickets, reports completion, or releases
   responsibility as though delivery succeeded. For an implementation failure,
   atomically change the owner record to `repair`, checkpoint that phase, suspend
   ordinary work repository-wide as described above, and follow the repair workflow
   below. For any other failure, apply the bounded CI rules, then keep the turn and
   make a Resumable Stop if no allowed action can progress.
5. On exact green `main` CI, verify ownership and release the turn immediately,
   then checkpoint the green evidence.

If a merge request fails and GitHub proves no merge occurred, release the owned
turn, checkpoint, and make a Resumable Stop. If the merge result is uncertain,
keep the turn until the remote PR and `main` state are reconciled, then checkpoint
the proven state before continuing or stopping.

### Restore broken `main`

While the owner record is in `repair`, do no ordinary ticket, batch, tracker,
local-`main`, or cleanup work. From the exact broken `origin/main` commit, create a
dedicated task-owned repair branch and worktree. Give one repair worker only the
failure evidence and restoration scope. Do not roll back automatically; require a
focused repair commit and keep every unrelated feature out of the repair PR.

Run combined review and canonical full verification on each exact repair candidate,
then push normally, open a non-draft repair-only PR, and observe exact PR CI. Apply
the same worker-attempt, synchronous retry, write-reconciliation, async observation,
CI dispatch, and transient-rerun bounds used elsewhere. Return accepted findings
or implementation failures to the same repair worker and invalidate evidence for
the changed candidate. Across the entire broken-`main` incident, allow only that
worker plus the one fresh-worker or different-approach attempt defined above;
checkpoint the cumulative usage and never reset it for a later repair PR. If both
attempts are exhausted, record the exact human decision needed. That or another
external or human-only blocker requires a Resumable Stop while retaining the turn
and all repair artifacts.

Before merging a green repair PR, fetch `origin/main`. If it changed, reconcile
whether it is already green; otherwise update the repair branch from the new exact
broken commit and repeat every invalidated gate while keeping the turn. Merge the
repair PR with a merge commit and capture its exact merge SHA. Immediately
checkpoint it, fetch `origin/main`, and verify exact equality with that SHA and
ancestry of the repair head before monitoring CI for the exact repaired commit. A
further implementation failure starts another bounded repair-only cycle; ordinary
work remains suspended. Only exact green CI for current remote `main` permits the
owner to release the turn and continue with tracker updates, local `main`
synchronization, and owned cleanup.

## 11. Update tickets, synchronize, and clean up

Perform these steps only after releasing the Delivery Turn following exact green
remote `main` CI:

1. Comment on every delivered Child Ticket with the Batch and any repair PRs,
   merge commits, final verification, and exact `main` CI evidence, then close it.
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
