---
name: implement-in-parallel
description: Implement, resume, and deliver the ready direct children of one GitHub Parent Ticket in an isolated Batch Run. Use when the user invokes $implement-in-parallel to coordinate dependency-aware workers, recover interrupted or failed deliveries, serialize Batch PR merges, and prove exact main CI green.
---

# Implement in Parallel

## Load `implement` first

Before commentary or any other action, resolve `../implement/SKILL.md` relative to
this skill and make one attempt to read it completely. If it is missing or
unreadable, report that `implement` is missing at the exact resolved path, return
**Do Not Start**, and end. Inspect nothing else and never reconstruct its rules.

After a successful read, use it as the Child Ticket worker contract, subject to
the limits below. This skill owns Parent discovery, dependency-aware scheduling,
integration, combined validation, recovery, delivery, and tracker updates.

## Outcomes, checkpoint, and external bounds

Use exactly these outcomes:

- **Do Not Start**: required input or initially runnable work is absent; create no
  Batch Run, Git artifact, or checkpoint.
- **Resumable Stop**: a started run cannot progress; atomically checkpoint it,
  preserve unfinished artifacts, and report the blocker and exact next action.
- **Complete**: the Batch scope is delivered and closed, tracker and local `main`
  updates finish, and successful owned artifacts are cleaned.

Keep at most one sparse Markdown checkpoint at
`<git-common-dir>/implement-in-parallel-parent-<parent>.md`, outside all branches
and worktrees. Record only repository and Parent, Batch scope, Batch Base/Branch/
Worktree, integrated and delivered commits, exact review/verification/PR/CI/merge
evidence, Delivery Turn owner and phase, external retry allowances, owned
artifacts, and next action. Git, tickets, PRs, and CI remain authoritative for
their own state.

Write it atomically after initialization, each integration, combined validation,
exact PR CI, Delivery Turn acquisition/inheritance, merge, each ownership-phase
change, and before every Resumable Stop. Never record routine commands, worker
starts, or polls. On resume, reconcile every claim with Git and GitHub, discard
only contradicted claims, and never repeat valid dispatch, implementation,
integration, validation, push, PR, merge, or CI work. Remove it only at Complete.

For synchronous transient failures, retry only after 5, 15, and 30 seconds.
Before retrying a write, reconcile desired state; an existing result succeeds
without another write. Never retry explicit permission, credential,
infrastructure, human, or other rejection.

Observe accepted asynchronous work without resubmission. Poll queued work every
15 seconds and stop after 2 minutes without a lifecycle transition; poll executing
work every 30 seconds and stop 20 minutes after provider-reported start. A status
page never extends these limits. If required CI is absent, dispatch one existing
equivalent workflow at most once. Rerun completed CI at most once and only for a
proved transient failure. Checkpoint either allowance before use; an ambiguous
lost response consumes it.

An external or human-only blocker stops dispatch and monitoring. Preserve open
tickets and artifacts and return Resumable Stop, or report the exact next action
and return Do Not Start with no artifact when the Batch Run has not begun.

## Admit one fixed Batch scope

Require exactly one Parent Ticket and the current Git repository; infer GitHub
from its remote. Read repository agent, tracker, label, and relevant owner
instructions, then the Parent's complete ticket and all direct native children,
including each child's complete ticket, native parent, and blockers. Native
relationships are authoritative: never infer them from bodies or add, remove,
assign, relabel, or rewrite tickets.

At initialization, record all direct Child Ticket numbers as the fixed **Batch
scope**. Assume it remains unchanged. Every later refresh reads only those
in-scope tickets and accepts their latest data without revision comparison or a
material-change pause. Resume uses the checkpointed Batch scope; never discover,
add, or remove children during the run.

A closed child is satisfied. An open child is eligible only with the configured
`ready-for-agent` label, and runnable only when every native blocker is closed or
its in-scope blocker commit is integrated. For a new run, return Do Not Start
before Git artifacts when there are no children, no open ready children, or no
initially runnable child; suggest `to-gh-tickets` for no children and otherwise
report all exclusions and blockers. An existing checkpoint follows resume rules.

Do not require, enter, clean, switch, stash, reset, or otherwise modify the caller
checkout or its `main`, and never mutate an Installed Skill. Fetch `origin`
without switching branches, record fetched `origin/main` as Batch Base, and make
one task-owned Batch Branch and external Batch Worktree named for the Parent
(`codex/parallel-<parent>-batch` when available), then checkpoint. One child and
many use the same path.

On resume, reuse only checkpoint-proven artifacts. A later delivery cycle may
start at current `origin/main` for in-scope work blocked during an earlier PR.
Coordinate, integrate, validate, push, and open PRs only in the Batch Worktree;
treat all other task worktrees as foreign. Preserve ambiguous artifacts and stop
with their identity and first human action rather than guessing.

## Schedule isolated workers and integrate serially

Use available worker capacity while the primary agent coordinates and integrates.
Schedule only by native blockers and capacity; never predict file overlap.
Before worker work, each coordinator phase transition, and every external poll,
inspect the Delivery Turn. Another run's `delivery` phase blocks only turn
ownership. Observing `repair` suspends all ordinary dispatch, integration,
validation, push, PR, and monitoring: halt workers at recoverable boundaries,
checkpoint, and return Resumable Stop.

Immediately before dispatch, refresh the selected in-scope child, Parent, and
blockers. For each runnable child:

1. Create its owned branch and external worktree from the current Batch Branch
   head, which must contain every integrated blocker.
2. Give the worker only Parent/Child context, repository instructions, exact
   starting commit and owned paths, the loaded `implement` contract, and these
   limits. Never provide sibling identities or communication duties.
3. Run independent children concurrently. Workers never communicate, monitor,
   or synchronize with one another; the coordinator alone handles dependencies.

Every ticket or repair worker must stay in its owned worktree, use `implement`,
use TDD at an agreed seam for behavior and characterization-first regression
evidence for pure refactoring, run focused checks rather than full verification,
leave a clean worktree, and report its commit and evidence. Ticket work returns
exactly one final commit; repair commits stay separate. Workers never use
auto-closing keywords, push, merge, mutate GitHub, run combined review, or run
full repository verification.

Correct coordinator scheduling or branch mistakes and resume the same worker.
Return implementation failures with its diff and evidence. Permit at most one
fresh worker for lost context or one genuinely different technical approach;
never restart blank. Preserve external or human blockers. For an undeclared
prerequisite, pause the child; if it is another in-scope child, integrate it,
update the paused branch, and resume the same worker. Otherwise report it without
changing the issue graph and continue independent work.

As each worker finishes, verify focused checks, its commit shape, and cleanliness;
refresh the selected in-scope ticket and blockers; then cherry-pick one commit and
checkpoint its exact integrated SHA. Integrate only one child at a time and fill
capacity with newly runnable work immediately.

Repair conflicts only after Git or combined behavior observes one: abort the
integration, preserve artifacts, update that child's branch onto the Batch
Branch, and give the same worker the actual conflict plus all accepted behavior.
Require focused checks and one replacement ticket commit, then integrate it.
The coordinator never writes conflict or repair code on the Batch Branch.

When workers end, classify each unintegrated in-scope child as excluded, paused,
blocked by an incomplete in-scope child, or blocked out of scope. Do not open a PR
while runnable work remains. Continue only with an undelivered integrated change;
otherwise checkpoint actionable status and return Resumable Stop.

## Gate and publish the exact candidate

Find canonical full verification in repository agent/development instructions,
then documented scripts/targets, then CI commands. If none is trustworthy,
checkpoint the exact decision needed and stop.

For the exact Batch head, run installed `code-review` against Batch Base and
accept or reject every finding. Give accepted findings to a dedicated repair
worker from the Batch Branch, integrate its separate commit, and repeat review.
After a clean review, run canonical full verification. Give implementation
failures and exact logs to a dedicated repair worker, then repeat both gates.
Every candidate change invalidates review and verification. Checkpoint both exact
gates; reuse them on resume only while their commit and evidence remain unchanged.

Refresh in-scope tickets and blockers after validation. If work became runnable,
schedule it and repeat invalidated gates. Otherwise push normally, open one
non-draft PR to `main` naming the Parent and included children without auto-close
keywords, confirm its head is the exact reviewed/verified commit, and observe all
relevant exact-head CI within the common bounds. Implementation CI failures go to
a dedicated repair worker and restart review, full verification, push, and CI.
Any changed head invalidates all prior gates. External failure checkpoints and
stops. After exact green PR CI, checkpoint it and retain every artifact.

## Serialize delivery

The Delivery Turn is the repository-wide
`<git-common-dir>/implement-in-parallel-delivery-turn.lock`. Its complete owner
record contains Parent, Codex task, Batch Branch, PR, exact head, and `delivery`
or `repair` phase. Serialize every read/mutation through a stable `<lock>.guard`
held with a process-scoped OS advisory lock. Create the guard once and never
unlink, rename, or replace it: every locker must use that persistent inode. On
macOS, use `lockf -k` (or an open-FD/fcntl equivalent that preserves the inode).
Under the short-held guard, prepare the complete record beside the lock and
acquire with one exclusive atomic create; never expose partial ownership or hold
the guard during GitHub, CI, validation, or implementation. Acquire only after
exact review, verification, and PR CI, then checkpoint and release the guard.

On resume, reconcile lock, checkpoint, PR, and `origin/main`. Inherit only a
same-Parent lock whose recorded task is conclusively inactive and whose branch,
PR, head, phase, and merge state agree. Under the guard, re-read the unchanged
owner, atomically replace only task identity, checkpoint, and release. Age, a
missing process guess, or Parent alone is not proof; a completed checkpointed
stop or conclusive orchestration-provider evidence is. Only the same proved owner
may reconcile a lagging checkpoint after an interrupted lock/checkpoint write.

Any active, ambiguous, unmatched, different-Parent, or mutex-unavailable turn is
busy: checkpoint its owner and immediately return Resumable Stop without polling,
stealing, deleting, or replacing it. Abandon only a user-named run after proving
its head and PR were not merged, then atomically release the unchanged owner and
record no ownership while preserving tickets and artifacts. An uncertain or
completed merge retains the turn.

While owning `delivery`:

1. Refresh in-scope tickets and blockers. If runnable work exists, verify and
   release ownership, implement it, update the existing PR, and repeat all gates.
2. Fetch `origin/main`. If it advanced beyond the reviewed base, invalidate all
   gates and merge it into the Batch Branch. On conflict, abort, release and
   checkpoint no ownership, and give the exact conflict to a dedicated worker.
   After a clean merge, release and checkpoint the changed head before pushing.
   Resolve/push outside the turn and repeat review, full verification, and PR CI.
3. Reconfirm the exact green PR head, merge through GitHub with a merge commit
   without deleting its branch, checkpoint the merge SHA, fetch `origin/main`,
   and prove exact equality plus Batch-head ancestry.
4. Retain ownership while observing CI for that exact remote-main commit. A
   non-green result never finalizes tickets or claims success. Apply bounded CI
   recovery; for an implementation failure atomically change phase to `repair`,
   checkpoint it, and follow broken-main repair. Otherwise stop while retaining
   responsibility when no allowed action remains.
5. On exact green main CI, verify and atomically release the unchanged owner,
   then checkpoint green evidence.

If GitHub proves a failed merge did not occur, release, checkpoint, and stop. If
the response is uncertain, retain ownership until PR and `origin/main` reconcile.

### Repair broken `main`

During `repair`, all coordinators suspend ordinary ticket, Batch, tracker,
local-main, cleanup, and monitoring work. The owning run assumes the recorded
exact broken `origin/main` remains fixed until its repair merges. From that exact
commit create an owned repair branch/worktree and give one worker only failure
evidence and restoration scope. Never roll back automatically or include
unrelated feature work.

For each exact repair candidate run combined review then canonical full
verification, push normally, open a non-draft repair-only PR, and observe exact
PR CI using the common bounds. Return findings or implementation failures to the
same worker and invalidate changed evidence. Across the incident allow that
worker plus at most one fresh-worker or different-approach attempt; checkpoint
cumulative use. Exhaustion or an external/human blocker returns Resumable Stop
while retaining `repair` ownership and artifacts.

Merge the green repair PR with a merge commit, checkpoint its SHA, fetch
`origin/main`, and prove exact equality and repair-head ancestry. Retain `repair`
ownership through CI for that exact repaired main. A further implementation
failure starts another bounded repair-only cycle without resuming ordinary work.
Only exact green main CI permits release, tracker finalization, local-main sync,
and cleanup.

## Finalize and clean

Only after releasing the turn following exact green remote-main CI:

1. Comment on and close each delivered in-scope child with Batch/repair PRs,
   merge commits, final verification, and exact-main CI evidence.
2. Comment on excluded, paused, or blocked in-scope children with their exact
   blocker and next action; leave them open and preserve labels and relationships.
3. Add one concise Parent summary; close the Parent only when every ticket in
   Batch scope is closed.
4. Fetch `origin/main` and fast-forward the local `main` mirror only if it has no
   local-only commits, is its ancestor, and its checkout is clean and safe.
   Never overwrite, reset, commit, merge, or push through ahead, divergent,
   dirty, foreign, or ambiguous local state; checkpoint the exact action needed.
5. Remove only successfully delivered owned branches/worktrees, including the
   remote Batch Branch only after merge proof and exact-main CI green. Preserve
   every blocked, unfinished, ambiguous, and unrelated artifact.

If delivered work is complete but in-scope children remain blocked, clean only
that delivered cycle, retain checkpoint and Batch scope, and return Resumable
Stop for another PR. Return Complete and remove the checkpoint only after all
Batch-scope tickets are delivered and closed, tracker and local-main work finish,
and successful owned artifacts are cleaned.
