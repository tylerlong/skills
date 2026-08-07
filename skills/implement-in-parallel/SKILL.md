---
name: implement-in-parallel
description: Implement the ready direct children of one GitHub parent issue by reusing the installed implement skill. Use when the user invokes $implement-in-parallel with one parent issue to run one child directly or coordinate a dependency-aware parallel batch, checkpoint and resume interrupted or externally blocked work, recover delivery failures, bound external-service waits, reach exact-commit green CI, and update the issues.
---

# Implement in Parallel

Reuse Matt's installed `implement` workflow. Own only parent discovery, parallel
orchestration, integration, delivery, CI, and tracker updates here.

## 1. Load the implementation workflow

Resolve `../implement/SKILL.md` relative to this skill and read it completely.
Treat it as the implementation contract, subject only to the worker limits below.
Stop if it is missing or unreadable; never copy or reconstruct its rules.

## 2. Read the repository and issues

- Require exactly one GitHub parent issue number or URL and one current Git
  repository. Infer the GitHub repository from its remote.
- Read the repository's agent instructions, issue-tracker configuration, triage
  label mapping, and relevant owner documents before changing anything.
- Read the parent's complete body, comments, state, and labels through the
  configured GitHub workflow.
- Discover only its direct native GitHub sub-issues. Read every child's complete
  body, comments, state, labels, and blockers.
- Treat native GitHub blockers as authoritative. Use body-level `Blocked by`
  declarations only when native blocker data is unavailable. Never add, remove,
  or reinterpret dependency edges.
- Never create, assign, or relabel children.

Freeze the direct-child numbers when a new run starts. When resuming a valid
checkpoint, retain its frozen child set until that run concludes. At every later
refresh, re-list the parent's direct children, report newly added children, and
defer them to the next new run rather than expanding the frozen set.

Before dispatch and again before integration, refresh each selected child's
requirements, state, readiness, parent relationship, and blockers. Pause a child
whose task-defining state changed materially. Treat that change as a human-review
boundary for the current run: do not resume its worker, implement the new scope,
or integrate stale work. Preserve its artifacts, report the change and next
action, and defer it until a later invocation accepts the refreshed issue. Treat
workflow comments written by this run as non-task changes. Never implement or
integrate from stale issue context.

Treat a closed child as complete. Treat an open child as eligible only when it
has the repository-configured `ready-for-agent` label; exclude other open
children. Treat an eligible child as runnable only when all its blockers are
satisfied.

Handle the initial state before doing Git work:

- With no children, stop and tell the user to run `to-tickets`.
- With all children closed, refresh the parent and every child. If they remain
  closed, add one concise completion summary and close the open parent. Otherwise
  classify again.
- With open children but no runnable child, report each blocker or exclusion and
  stop.

Count a blocker as satisfied only when it is already closed or, for another
direct child in this run, its commit has been integrated. Allow that integrated
child to remain open until final CI is green.

## 3. Recover or initialize run state

Before applying the new-run `main` guard, read the latest checkpoint comments on
the parent and affected children and inspect existing matching Git artifacts:

- `codex/parallel-<parent>-integration` for integration;
- `codex/parallel-<parent>-child-<child>` and a worktree containing the same
  parent and child numbers for ticket work; and
- clearly parent-labelled repair branches and worktrees recorded by a checkpoint.

Read every matching artifact's base, commits, diff, status, and relationship to
the current issues. Reuse it only when ownership and phase are clear. Preserve
and report ambiguous artifacts without switching, overwriting, resetting, or
deleting them; block only the affected work when unrelated progress is safe.

Treat a matching checkpoint plus its validated artifacts as the continuation of
one run, not a new batch. Verify that its external or human-only blocker is
resolved, refresh the frozen issues and `origin/main`, then continue from its
recorded phase and commits. If the blocker remains, schedule nothing and refresh
the checkpoint instead of retrying workers. If a session ended without posting a
checkpoint, reconstruct the same state from clearly owned artifacts and issue
history, post the missing checkpoint, and resume it. Never restart completed work.

Use only Git commits, branches, worktrees, and GitHub comments as resume state.
Do not add a checkpoint file, state database, daemon, or scheduler program.

## 4. Protect and synchronize `main`

For a new run, continue only from the current checkout when it:

- is on `main`;
- has no tracked or untracked changes; and
- can fast-forward to `origin/main` without local-only or divergent commits.

Fetch and fast-forward as needed. Never stash, reset, commit, move, or delete
unrelated work. Record the synchronized commit as the pre-batch base. Skip a full
baseline verification unless repository instructions require it. Reserve this
checkout for the run; require concurrent human work to use another worktree or
clone.

For a resumed run, keep the validated integration or delivery state preserved
and require every reused checkout to be clean except for clearly owned unfinished
changes. Do not force it through the new-run `main` precondition.

## 5. Use the single-child path when only one child is runnable

When exactly one child is runnable initially, preserve the ordinary `implement`
mechanics: implement it in the current checkout, use its agreed TDD seam, run its
required verification and final code review, and commit it on local `main`.

Do not create a worker, worktree, or integration branch. Require a clean checkout
and a real new commit when `implement` returns; never manufacture an empty commit.
Then continue at **Deliver through CI**.

## 6. Prepare a parallel batch

When more than one child is runnable initially:

1. Create a temporary `codex/parallel-<parent>-integration` branch from the
   pre-batch base in the current checkout, unless resuming that validated branch.
   Reserve this checkout for coordination and integration.
2. Inspect the eligible tickets and the code they are likely to touch. Serialize
   tickets expected to change the same contract, symbol, migration, generated
   artifact, behavior, or interfering tool state. Do not infer conflict from a
   shared large file alone.
3. Use only available worker-agent capacity and keep the primary agent as
   coordinator and integrator. Start confidently independent runnable children
   concurrently. Create `codex/parallel-<parent>-child-<child>` and a worktree
   whose name contains the same parent and child numbers only when its worker
   slot is available.
4. Immediately before dispatch, refresh every known blocker. Never start a worker
   unless each blocker is closed or its direct-child commit is already integrated.
5. Start the child branch from the current integration commit containing all of
   its integrated blockers.

Give each worker:

- both issues' numbers, URLs, titles, states, bodies, comments, labels, and
  dependency state;
- repository instructions and relevant owner documents;
- the exact starting commit and its branch/worktree;
- the complete loaded `implement` rules; and
- any predicted conflict ordering relevant to its ticket.

Let the worker change any repository area needed for the correct ticket result.
Do not make workers monitor or synchronize with one another.

## 7. Bound every worker

Apply this boundary to ticket, reconciliation, remote-rebase, review,
verification, and CI-repair workers. Require every worker to:

- implement only its assigned ticket or repair, using TDD at an agreed seam where
  appropriate;
- run regular focused checks, not the full repository verification;
- commit all assigned work locally and return its commits and verification evidence;
- avoid auto-closing keywords in commit messages; and
- leave its worktree clean.

Forbid workers from pushing, merging, mutating GitHub, running the final code
review, or running the full repository verification. Override only those
corresponding final-delivery steps from `implement`.

When a ticket worker finds an undeclared prerequisite, pause only that child and
preserve its work. If the prerequisite is another in-scope direct child, integrate
that child first, update the paused branch onto the new integration commit, and
resume it. Otherwise report the prerequisite without adding work or changing the
issue graph, mark only that child blocked for this run, and continue unrelated
work.

## 8. Classify worker stoppages

Classify a stopped worker before retrying:

- Correct scheduling, dependency-order, or branch-state mistakes as coordinator,
  then resume the same worker.
- Return implementation failures or uncertainty to the same worker with its diff,
  logs, and focused-check evidence.
- Spend at most one fresh-worker attempt per stopped task, either to replace a
  lost or exhausted session or to try one useful independent technical approach.
  Supply every prior diff, log, attempted approach, and exact blocker; never
  restart from a blank prompt or cycle through workers.
- Treat permissions, unavailable infrastructure, missing credentials, and required
  human decisions as external blockers. Preserve and report the work instead of
  assigning another worker.

Do not assume a fresh worker knows more; use it only for context recovery or one
genuinely different attempt.

### Bound external-service waits

Distinguish a failed synchronous request or command from an accepted asynchronous
operation. For a synchronous connection failure, timeout, rate limit, or server
error that persists, retry three times after the initial attempt, waiting
5 seconds, 15 seconds, and 30 seconds. Stop early on success or a definitive
failure. Do not use this schedule for authorization, permission, validation,
semantic-conflict, or non-fast-forward failures; use the existing repair or
blocker path.

Before retrying a write, reconcile its desired external state. Treat the write as
successful when that state already exists. Retry only when it is definitely absent
and repeating the write is safe. When the result cannot be observed safely, make a
resumable stop. Never apply the synchronous retry allowance to a whole accepted
asynchronous operation.

Once asynchronous work is accepted, observe it without resubmitting it:

- Treat accepted, absent, queued, pending, waiting, and other not-yet-executing
  states as **not executing**. Poll every 15 seconds and make a resumable stop
  after 2 minutes without a lifecycle transition. Reset that unchanged timer only
  on a real lifecycle transition.
- Treat explicit running or in-progress state as **executing**. Poll every
  30 seconds and make a resumable stop 20 minutes after the provider's reported
  execution start. Continue treating an unchanged running step as executing; do
  not cancel or restart it at the boundary.
- Treat terminal success or failure as completed work and follow the applicable
  success, repair, or blocker path.

Do not require a provider status-page check. At most, consult one once when it is
convenient diagnostic context. Never poll it or change retry, polling, or stopping
behavior from its result.

When an external or human-only blocker stops progress, make a resumable stop:
stop new dispatch and all monitors, write one checkpoint through the existing
mechanism, end the current Codex run, preserve every unfinished Git artifact and
open Issue, and leave the external operation untouched. Do not revert, clean
artifacts, close issues, or manufacture a replacement worker. On a later
invocation, reconcile that exact operation before continuing; never blindly
reimplement, repush, resubmit, restart, or cancel it. Record:

- the frozen child numbers and current phase;
- integrated, pushed, and still-unmerged commits;
- relevant branch names and whether each worktree is clean;
- review, verification, push, and exact-commit CI evidence;
- the external operation identifier when one exists, observed lifecycle state
  and timestamps, and completed retries, dispatches, or reruns;
- attempted repairs and why further agent work cannot resolve the blocker;
- the exact blocker and the first action required after resolution.

When GitHub is available, post the checkpoint to the parent and each affected
child, without publishing local filesystem paths. Report those paths only to the
user. When GitHub itself is unavailable, preserve the Git artifacts and provide
the same checkpoint plus local paths directly to the user. Leave every unfinished
issue open and preserve its labels and dependencies.

For any defect found only by combined review, full verification, or CI, run one
repair protocol: create a temporary repair branch and worktree from the latest
integration commit, give a worker the exact finding or failure logs, require the
smallest correct fix and focused checks, then integrate its separate, clearly
labelled repair commit. Apply **Bound every worker**, then make the coordinator
rerun the applicable gates without implementing the repair.

Run one remote-refresh protocol immediately before combined review and full
verification and after a remote-advance push rejection:

1. Preserve the candidate on the integration branch and fetch `origin/main`.
2. When local `main` already contains an unpushed candidate, return to integration
   and restore local `main` to the fetched destination only after confirming the
   candidate is preserved.
3. When the destination advanced, rebase integration onto it. On conflict, abort
   the coordinator's rebase and give a dedicated worker a temporary branch and
   worktree from integration. Require it to rebase onto the fetched destination,
   resolve every conflict, run focused checks, and return the repaired branch;
   move integration to that result only after success.
4. Treat the fetched destination as the new review base and report whether the
   candidate changed.

## 9. Integrate continuously and repair conflicts

Do not wait for a fixed wave. As each worker finishes:

1. Confirm its focused checks, commits, and clean worktree.
2. Refresh that selected child and the parent's current direct-child list. Pause
   material changes and defer new child numbers. Otherwise record the integration
   branch's current commit, then integrate only that child.
   Cherry-pick one commit; squash multiple commits into one ticket-labelled commit.
3. Keep exactly one primary integrated ticket commit per child.
4. Mark that child locally integrated, then immediately fill available slots with
   any runnable child that is neither active, integrated, paused, nor blocked and
   does not conflict with an active worker. Include initially deferred,
   conflict-serialized, and newly unblocked children.

Integrate completed children one at a time. Detect unexpected Git conflicts and
competing semantic implementations only here; never make active workers monitor
one another. On either conflict:

1. Abort the Git operation or return the integration branch to its recorded
   pre-attempt commit. Preserve the worker branch and worktree.
2. Update the later ticket's branch onto the current integration commit.
3. Assign the reconciliation to its worker under **Classify worker stoppages**.
   Require it to preserve both accepted behaviors, rerun focused checks, and
   replace its ticket work with one clean commit.
4. Integrate the replacement and continue scheduling.

When no worker remains and no additional child can run, classify each
unintegrated child as excluded, cyclically blocked, blocked by an incomplete
prerequisite, or blocked by an out-of-scope prerequisite. Continue with any
integrated successful subset; stop without delivery only when the subset is
empty.

## 10. Refresh, review, and verify the combined result

After scheduling concludes with at least one integrated child:

1. Discover the canonical full verification procedure from repository agent or
   development instructions, then documented scripts or targets, then CI
   commands. Stop before merging if none is trustworthy.
2. Run the remote-refresh protocol immediately before review.
3. Run a combined `code-review` against the current review base. Apply the repair
   protocol to every accepted finding, then rerun the combined review.
4. Run the remote-refresh protocol again immediately before full verification.
   Return to combined review when the candidate changed.
5. Run the canonical full repository verification on the stable combined state.
   Apply the repair protocol to failures, then return to combined review and full
   verification.

Keep the coordinator in orchestration and integration work; never implement a
review or verification repair directly. Do not run a full suite per child. Preserve
all work and report the classified blocker when repair cannot continue safely.

## 11. Deliver through CI

For the single-child path, fetch `origin/main` again. If it advanced, rebase the
new child commit onto it; abort and preserve the commit on conflict. Repeat final
review and full verification after a successful rebase.

For a parallel batch, switch the current checkout to `main` and fast-forward it to
the verified integration branch. Keep the integration branch through green CI.
Then:

1. Push `main` normally without force and without a pull request.
2. Capture the pushed commit SHA.
3. Monitor CI checks belonging to that exact commit until they finish.

When a parallel push is rejected because remote `main` advanced:

1. Run the remote-refresh protocol.
2. Return to combined review and full verification, then fast-forward local `main`
   and push normally again. Never force-push.

For CI on both the parallel and single-child paths:

- Follow a replacement run for the same commit after cancellation. Treat a commit
  with no relevant CI run as not executing, never green, and apply the bounded
  external-service waits above.
- When required CI remains absent for the full 2-minute unchanged window,
  dispatch an existing equivalent workflow for the same commit once only when the
  repository already supports it. Observe that accepted dispatch under the same
  bounds. Otherwise make a resumable stop. Never change a workflow, repush, amend,
  or create an empty commit merely to trigger CI.
- Rerun a completed CI run exactly once only when evidence proves a transient
  runner, network, or hosted-service failure. Make a resumable stop when the same
  external failure recurs or the run cannot be retried.
- Diagnose build, test, lint, or interaction failures from their logs. Assign each
  implementation-caused failure through the repair protocol, then repeat remote
  refresh, combined review, full verification, normal push, and exact-commit
  monitoring for the replacement commit.

Continue repairable CI failures until the exact current commit is green. Never
revert the batch automatically, force-push, create a pull request, or claim
completion from local verification. Preserve and report any classified blocker.

When resuming a checkpoint at CI, first confirm the recorded commit is still on
`main` and the blocker is resolved. Continue monitoring or rerun the failed or
cancelled workflow for that exact commit when appropriate; do not reimplement or
repush unchanged ticket work merely to create another run.

For the single-child path, preserve its existing definitive rejected-push and
non-green-CI behavior while applying the retry, observation, and resumable-stop
rules above to transient or external conditions.

## 12. Update GitHub and clean up after green CI

Only after the exact pushed commit is green:

1. Comment on each successfully delivered child with the main commit link, final
   verification, and CI run link, then close it.
2. Comment on each excluded or blocked child with its exact blocker and next
   action. Leave it open.
3. Re-list and refresh every current direct child, including children added after
   the frozen snapshot, and add one concise status summary to the parent. Close
   the parent only when every current direct child is now closed.
4. Preserve native dependency edges, readiness labels, and blocked or unmerged
   branches and worktrees.
5. Remove only successful ticket worktrees and temporary branches. Remove the
   delivered integration branch after returning to `main`.

Do not assign or relabel issues. Never report a child complete before its delivered
commit is on `main` with green CI.
