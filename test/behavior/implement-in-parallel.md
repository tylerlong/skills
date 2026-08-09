# `implement-in-parallel` behavior catalog

This catalog characterizes the observable Skill contract. It does not inspect
instruction wording or hidden reasoning, and it is not part of `make test`.

## Execution protocol

Resolve the Baseline commit when execution starts. In separate disposable clones,
copy that commit's `skills/implement-in-parallel` directory verbatim to
`.agents/skills/implement-in-parallel`, and stage the same upstream `implement`,
`tdd`, and `code-review` skills beside it. Do not read, replace, or invoke the
user-level Installed skill. Run Baseline and Candidate with the same model,
reasoning effort, service tier, personality, permissions, upstream skill bytes,
scenario prompts, and evaluator-owned environment.

For GitHub scenarios, use uniquely named resources in
`tylerlong/implement-in-parallel-sandbox`. Capture the exact source commit, staged
skill checksums, settings, prompt, final response, relevant agent events, Git log
and worktree state, checkpoint contents, ticket relationships and state, PR head
and merge state, and CI URLs and SHAs. Keep this evidence outside the repository.
The evaluator, not the skill under test, removes disposable local resources and
best-effort remote leftovers after evidence capture.

Run each required scenario once per version. A clear violation fails. Only
ambiguous agent variation permits one paired Baseline/Candidate diagnostic rerun;
inconsistent results after that are **Unstable** and block qualification. Report a
concise result matrix in the delivery ticket or PR; never commit transcripts or a
rolling results file.

A scenario failure starts diagnosis. Repair a faulty specification, fixture, or
evaluator without weakening the contract, or make the minimum Source-skill repair
at its owning boundary. Select the repaired commit as the new exact Baseline,
invalidate all prior Baseline evidence, and restart every required scenario. Stop
only for a human-only contract decision or an external permission, credential, or
infrastructure blocker. These repair reruns do not consume the one paired rerun
reserved for ambiguous AI variation.

## Contract traceability

| Rule | Observable contract | Scenarios |
| --- | --- | --- |
| R01 | Source packaging, metadata, discovery, and explicit-only activation remain valid. | IP-01 |
| R02 | `implement` is resolved and read before repository, checkpoint, Git, GitHub, artifact, or worker inspection; absence is not reconstructed. | IP-02 |
| R03 | Outcomes remain exactly Do Not Start, Resumable Stop, and Complete. | IP-02, IP-04, IP-05 |
| R04 | Admission uses direct native children, readiness, and native blockers without mutating the issue graph or task definitions. | IP-03, IP-04 |
| R05 | Batch scope is fixed at initialization and Parent completion is evaluated against that scope. | IP-04 |
| R06 | Current in-scope ticket data is accepted without revision comparison or material-change pausing. | IP-04 |
| R07 | Owned branches, worktrees, and the sparse external checkpoint make a Batch Run isolated and resumable. | IP-04, IP-05 |
| R08 | Workers neither communicate, monitor, synchronize, nor receive sibling identities; only the coordinator schedules dependencies through starting commits. | IP-03, IP-04 |
| R09 | Independent ready work runs concurrently; the coordinator integrates completed ticket commits one at a time. | IP-04 |
| R10 | Workers run focused checks, use characterization for pure refactoring and TDD for genuine behavior, return one clean ticket commit, and perform no public or delivery writes. | IP-04 |
| R11 | Conflict repair starts only after Git observes a conflict and returns the actual conflict plus accepted behavior to the same worker. | IP-04 |
| R12 | Combined review precedes full repository verification, and any repair invalidates both gates. | IP-04 |
| R13 | PR CI is tied to the exact reviewed and verified head; changed candidates repeat every gate. | IP-04 |
| R14 | External writes are reconciled before retry and synchronous/asynchronous operations remain within their stated bounds. | IP-04, IP-06C, IP-07B |
| R15 | Pre-finalization status goes only to the checkpoint and user; tickets stay unchanged until exact remote-main CI is green. | IP-04, IP-05 |
| R16 | The Delivery Turn serializes merge/main-CI ownership, including acquisition, inheritance, ambiguity, release, and resume; normal advanced-base changes invalidate candidate evidence. | IP-04, IP-06, IP-06A, IP-06B |
| R17 | Broken-main repair is repair-only, starts from the exact known-broken `origin/main`, suspends ordinary work, and retains the turn through exact repaired-main CI. | IP-07, IP-07A |
| R18 | Finalization updates tickets only after exact green remote-main CI, safely synchronizes local `main`, then cleans only proven successful owned artifacts. | IP-04 |
| R19 | Resume reconciles checkpoint claims with GitHub and Git state and does not repeat valid completed work. | IP-05 |
| R20 | Missing trustworthy verification or a non-retryable blocker stops with preserved evidence and an exact next action. | IP-03, IP-05, IP-07B |

The approved Candidate intentionally removes three Baseline mechanisms. These are
decision traceability, not Baseline pass criteria:

| Change | Baseline mechanism removed from Candidate | Protected observations |
| --- | --- | --- |
| D1 | Re-discovering and deferring children added after initialization. | IP-04 creates no children after initialization and checks only the initialized Batch scope and its finalization. |
| D2 | Comparing refreshed ticket data with prior revisions and pausing on a material change. | IP-04 mutates no task definitions, then checks that refreshed in-scope data is accepted and work continues. |
| D3 | Rechecking whether another actor advanced or healed `origin/main` during broken-main repair. | IP-07 supplies a fixed broken main and checks repair from that exact commit; no external actor changes main during the incident. |

## Required scenarios

### IP-01 — packaging, metadata, and activation

**Setup.** Stage the exact source directory by the execution protocol. Keep an
ordinary repository task available that does not name the skill.

**Invocation.** Run the repository validator and Skills CLI discovery check. In
fresh agent turns, first ask the ordinary task without naming the skill, then ask
the same task with `$implement-in-parallel` and exactly one Parent Ticket.

**Required observations.** The source name matches its directory; frontmatter and
`agents/openai.yaml` pass repository validation; discovery lists the source once;
display metadata is nonempty and the default prompt names
`$implement-in-parallel`; explicit activation loads this exact staged source and
starts admission for the named current repository and Parent Ticket.

**Forbidden observations.** Implicit activation for the ordinary task; reading or
mutating an Installed skill; targeting a repository other than the invocation's
current repository; any Candidate text during Baseline qualification.

**Evidence.** Validator/discovery output, source and staged checksums, settings,
and both final responses and event streams.

**Cleanup and cost.** Delete the disposable clones. Two short agent turns plus
deterministic validation; required.

### IP-02 — missing `implement` returns Do Not Start first

**Setup.** In a disposable repository-scoped staging clone, install only the exact
`implement-in-parallel` Baseline. Ensure `../implement/SKILL.md` is absent or
unreadable. Put recognizable Git files and a fake checkpoint in locations that
would be visible if inspected, but provide no valid GitHub credentials to the
turn. Do not use `AGENTS.md` as an inspection trap: the Codex runtime may inject
project instructions before skill execution. Judge only agent-initiated events.

**Invocation.** Explicitly invoke `$implement-in-parallel` with a syntactically
valid Parent Ticket number.

**Required observations.** The response names the unresolved dependency path,
returns **Do Not Start**, and ends the task. The event stream shows only skill and
dependency resolution before the final response.

**Forbidden observations.** Repository instructions, checkpoint, Git, remote,
GitHub, tickets, artifacts, workers, or Installed-skill inspection; repository or
external writes; a checkpoint or branch; copied, summarized, guessed, or
reconstructed `implement` rules.

**Evidence.** Full event-kind and path/command list, final response, unchanged
filesystem manifest and Git refs, and absence of network/GitHub operations.

**Cleanup and cost.** Delete the disposable repository. One short agent turn;
required.

### IP-03 — native-blocker admission

**Setup.** In the sandbox, create one open Parent Ticket with these direct native
children in order: closed child A; open child B without `ready-for-agent`; ready
child C blocked by open ready child D; ready child D with no blocker; and ready
child E blocked by an open issue outside Batch scope. Use native sub-issue and
dependency APIs and read them back. Give each open child a unique, harmless file
task. Do not encode relationships in issue bodies.

**Invocation.** Explicitly invoke the staged skill with the Parent Ticket and stop
at a recoverable checkpoint after D is integrated and C's worker is created from
that integrated starting commit, before C edits or any delivery work.

**Required observations.** A is satisfied, B is excluded, D alone is initially
runnable, C waits for D, and E remains blocked out of scope. After D's commit is
integrated, C's worker branch starts from a commit containing D. Admission uses
the native relationships and repository-configured readiness label.

**Forbidden observations.** Dispatching B, C before D integration, or E; parsing
body text as relationships; adding, removing, assigning, relabeling, or rewriting
tickets; sibling identities or state in a worker prompt; any ticket comment.

**Evidence.** Native relationships/readiness before and after, worker start and
starting SHA, ancestry proving D is present for C, branches/worktrees,
checkpoint, event stream, and unchanged ticket bodies/labels/comments.

**Cleanup and cost.** Stop at a recoverable boundary, capture evidence, remove
local resources, and best-effort close/delete evaluator-owned sandbox resources.
One bounded multi-worker turn; required.

### IP-04 — core Batch Run through finalization

**Setup.** Use a unique prefix in the sandbox. From green `origin/main`, create a
Parent with three direct ready native children:

- A and B are independent genuine behavior changes. Each must first add a focused
  failing check and then implement it, and both must edit the same unique fixture
  line so their independently valid commits cause a real cherry-pick conflict.
- C is a pure contract-documentation/refactoring task natively blocked by A. Its
  starting commit must contain integrated A, and it must use characterization,
  not red-green TDD.

The repository instructions define focused checks, a canonical full verification
command, and exact-head CI. Do not add children or mutate any issue body, comment,
label, relationship, state, or task definition after invocation. Ensure no other
run owns the sandbox Delivery Turn.

**Invocation.** Explicitly invoke the exact staged Baseline with the Parent Ticket
and require delivery to completion. If the agent turn ends after a valid
checkpointed Resumable Stop, resume that exact task once with no changed inputs.

**Required observations.** In order, allowing independent worker interleaving:

1. Admission fixes the three-ticket Batch scope, records fetched `origin/main` as
   Batch Base, creates owned Batch artifacts outside the caller checkout, and
   atomically initializes the sparse checkpoint.
2. A and B workers overlap in time and have isolated branches/worktrees and
   prompts containing no sibling identities or communication duties. Each runs
   focused red-green checks, makes exactly one ticket commit, leaves a clean
   worktree, and performs no push, merge, GitHub write, combined review, or full
   verification.
3. The coordinator integrates one commit at a time. The second integration
   produces an actual conflict; the coordinator aborts it and returns the conflict
   and both accepted behaviors to the same worker. The replacement remains one
   final ticket commit and passes focused checks.
4. C starts only after A is integrated and its starting commit contains A. It
   uses characterization-first evidence and returns one clean ticket commit.
5. The exact combined candidate receives the installed two-axis code review and
   canonical full verification. Any accepted-finding or verification repair is a
   separate worker commit followed by both gates again.
6. The coordinator pushes normally, opens one non-draft Batch PR without
   auto-closing keywords, and observes relevant CI green for the exact reviewed
   and verified PR head. Ticket comments, closures, labels, bodies, and
   relationships are still unchanged.
7. Only then does it acquire the Delivery Turn, merge through GitHub, prove exact
   `origin/main` equality/ancestry, and observe exact remote-main CI green while
   retaining responsibility.
8. After releasing the turn, it comments on and closes A, B, and C, summarizes and
   closes the Parent because the initialized Batch scope is closed, safely
   synchronizes local `main`, removes only successful owned local/remote
   artifacts, removes the checkpoint, and returns **Complete**.

At each required checkpoint boundary, the checkpoint contains authoritative SHAs
and evidence but no routine command transcript. Refreshes accept current in-scope
ticket data and neither compare revisions nor discover/add children. External
operations remain within retry, reconciliation, polling, dispatch, rerun, and
elapsed-time bounds.

**Forbidden observations.** Caller-checkout or Installed-skill mutation; predicted
file-overlap scheduling; worker-to-worker contact or knowledge; concurrent
integration; coordinator-authored conflict/repair code; public ticket mutation
before finalization; force push; local-main delivery; stale review, verification,
or CI reused for a changed candidate; early Batch Branch deletion; ticket graph or
task-definition mutation; Candidate skill text.

**Evidence.** Exact commits and checksums; settings; timestamped worker lifecycle
and focused-check events; prompts; `git log --graph`, refs, ancestry, worktree
list, and cleanliness; conflict and replacement commit; checkpoint snapshots;
review and full-verification results tied to SHAs; PR body/head/base/merge; exact
PR and main CI URLs/SHAs; Delivery Turn records; ticket bodies, labels,
relationships, comments, and states before pre-finalization and after completion;
final response; local and remote cleanup manifest.

**Cleanup and cost.** The skill performs successful-run cleanup. The evaluator
removes only its remaining uniquely named local resources and best-effort closes
or deletes its own remote leftovers after evidence capture. One potentially long
multi-worker delivery plus at most one ordinary resume; required.

### IP-05 — resume without repeated work

**Setup.** Reuse the IP-04 run only if it naturally returns a valid checkpointed
Resumable Stop. Otherwise, start a smaller two-child run and terminate the agent
after exact combined validation has been checkpointed but before push. Preserve
all owned artifacts and authoritative external state unchanged.

**Invocation.** Explicitly invoke the staged skill again for the same Parent from
the original caller checkout.

**Required observations.** It detects the one checkpoint, reconciles every claim
with Git and GitHub, reuses valid implementation, integration, review, and
verification evidence for the unchanged exact commit, continues at the recorded
next action, and eventually returns Complete or a new actionable Resumable Stop.

**Forbidden observations.** A second Batch Run/checkpoint, redispatch of completed
work, repeated valid gates, artifact guessing, deletion of unfinished evidence,
public pre-finalization status, or changed Batch scope.

**Evidence.** Before/after checkpoint, refs/worktrees, GitHub state, event stream
showing reconciliation, unchanged commit identities, and final outcome.

**Cleanup and cost.** Prefer evidence from IP-04. A separate run is required only
when IP-04 provides no resume seam; one resume turn.

### IP-06 — concurrent delivery and advanced base

**Setup.** In one sandbox clone and Git common directory, create two uniquely
prefixed Parent Tickets, each with one independent ready native Child Ticket.
Record the same green `origin/main` for both invocations. Use an
evaluator-controlled main-CI delay long enough for the first run to hold the
repository's Delivery Turn while the second reaches acquisition. Do not mutate
either ticket after invocation, and ensure no earlier run owns the turn.

**Invocation.** Start both exact staged Baseline skill invocations concurrently
with the same model and settings and require each to continue through exact-head
PR CI. Let the first owner merge while the second continues ordinary work outside
the turn. After the second returns a checkpointed Resumable Stop, let the first
prove exact-main CI and release the turn, then resume the second invocation
unchanged through completion.

**Required observations.** Before delivery, workers, integration, review, full
verification, push, PR creation, and exact-head PR CI overlap where scheduling
allows; one run's normal delivery phase does not suspend the other run's ordinary
work. Each run has its own checkpoint and owned artifacts. Acquisition is
serialized through the persistent guard's process-scoped advisory lock and one
exclusive atomic create of a complete owner record containing Parent Ticket
number, task, branch, PR, and `delivery` phase. Exactly one run owns the turn. The
other re-reads
the active owner for a different Parent Ticket, records its exact next action,
and immediately returns **Resumable Stop** without polling, stealing, deleting,
or replacing it.

The first run checkpoints merge evidence, retains ownership through CI for the
exact remote-main merge commit, atomically releases the unchanged owner after
green, and finalizes. On resume, the second reconciles its checkpoint, PR, lock,
and `origin/main` without repeating completed ticket work. It acquires only after
the turn is free. Because `origin/main` advanced beyond its reviewed base, it
invalidates prior combined review, full-verification, and PR-CI evidence, merges
the fetched base into its Batch Branch, releases the turn before push, and
checkpoints the changed exact head with no ownership. That head passes fresh
combined review, full verification, push, and exact-head PR CI before reacquiring
the turn. It then merges, retains responsibility through green CI for its exact
remote-main merge commit, releases, finalizes, and returns **Complete**.

**Forbidden observations.** Serializing ordinary work behind a normal owner;
more than one complete owner; ownerless or partial lock contents; holding the
guard during GitHub, CI, review, verification, or implementation work; polling or
stealing a busy turn; merging the second PR with stale evidence; pushing while
holding the turn after its base changes; force push; ticket mutation before each
run's exact-main CI is green; or deleting another run's artifacts.

**Evidence.** Both task identities and event timelines; lock and guard inode,
contents, and atomic-transition snapshots; checkpoints before contention, stop,
merge, release, base update, and resume; refs, worktrees, PR heads, merge commits,
and ancestry; old and replacement review, verification, and CI SHAs; exact PR and
main CI URLs; ticket state before finalization and after completion; and owned
cleanup manifests.

**Cleanup and cost.** The skill cleans successful owned artifacts; the evaluator
best-effort removes only its unique leftovers and restores any evaluator-owned CI
delay. Two concurrent deliveries and one resume; required.

## Conditional risk variants

These are fully specified risk variants, not required Baseline qualification
scenarios. Their rules remain authoritative when they are not run. Mark each
**Not run** with residual risk unless its rule changes materially or core evidence
raises doubt, in which case it becomes required and must pass.

### IP-06A — proven inheritance and release recovery

**Setup.** Pause an evaluator-owned run after it checkpointed a complete Delivery
Turn owner and ended its Codex task. Preserve an unchanged lock for the same
Parent Ticket, checkpoint, branch, PR, exact green head, phase, and authoritative
GitHub state. Give the evaluator conclusive orchestration-provider evidence that
the recorded task ended. Separately prepare the same state without that liveness
proof, and a state where the owner changes while the current task waits for the
guard.

**Invocation.** Resume the Parent Ticket from a new exact staged Baseline skill
task for each state. In the proved case, continue delivery and release normally.
In the other cases, stop at the ownership decision.

**Required observations.** Only the proved state for the same Parent Ticket is
inherited: while holding the guard, the task re-reads and matches the unchanged
complete owner, atomically replaces only the task identity, checkpoints
inheritance, and releases the guard before external work. It does not repeat a
proven merge or gate. Missing liveness proof or a changed owner is treated as
busy/ambiguous and produces an immediate checkpointed **Resumable Stop**. If an
interrupted release left the checkpoint lagging the lock, only the same proven
owner reconciles it from the lock plus Git, PR, and CI evidence before releasing
the exact unchanged owner.

**Forbidden observations.** Inferring inactivity from age, a missing process, or
Parent Ticket number; inheriting a different phase, branch, PR, head, or merge
state; overwriting a changed owner; deleting an ambiguous lock; holding the guard
during reconciliation outside its short critical section; or abandoning
ownership without the user naming that run and authoritative proof that neither
head nor PR was merged.

**Evidence.** Provider task-lifecycle proof, before/after owner bytes, guard-lock
events, checkpoint snapshots, branch/PR/head/phase and merge-state readback,
final response, and absence of repeated or unauthorized work.

**Cleanup and cost.** Complete or explicitly abandon only evaluator-owned runs,
then remove their unique leftovers. Several provider-liveness and interrupted
transition cases; conditional because exact task-lifecycle control is required.

### IP-06B — ambiguous ownership and uncertain merge

**Setup.** Build evaluator-owned snapshots for an active owner for a different
Parent Ticket, an advisory guard that cannot be acquired, a lock/checkpoint
mismatch, and a lost merge response whose PR and `origin/main` readback initially
cannot prove whether the merge occurred. Keep all ticket and Git artifacts
recoverable.

**Invocation.** Resume the affected Parent Ticket once per snapshot, allowing the
evaluator to reveal authoritative merge state only after the first uncertain
readback.

**Required observations.** Active, mutex-unavailable, changed, unmatched, and
otherwise ambiguous ownership each cause an immediate checkpointed
**Resumable Stop** with the observed owner and exact next action; the task does
not poll the turn. An uncertain merge retains the owned turn while the task
reconciles PR and `origin/main`; it checkpoints the proven merge before either
continuing exact-main CI or, when GitHub proves no merge, releasing and stopping.

**Forbidden observations.** Guessing from process age, deleting or replacing the
lock, a second merge request while the first is uncertain, releasing before
merge-state reconciliation, ticket finalization, or cleanup of unfinished state.

**Evidence.** Exact owner/guard snapshots, checkpoints and final responses,
GitHub request/readback timeline, PR merge state, `origin/main` SHA and ancestry,
and preserved-artifact manifest.

**Cleanup and cost.** Reconcile and remove only evaluator-owned snapshots after
evidence capture. Provider timing and uncertain-response injection; conditional.

### IP-06C — Delivery Turn write and observation failures

**Setup.** Inject, one at a time, a lost lock-write response, synchronous GitHub
transient failures, delayed queued and executing CI, one absent required CI run,
one transient completed CI failure, and explicit permission, credential,
infrastructure, and human rejections. Provide authoritative readback controls and
a repository with an existing equivalent dispatch workflow.

**Invocation.** Continue one evaluator-owned run from the affected operation.

**Required observations.** Writes reconcile desired state before retry; sync
retries stop after waits of 5, 15, and 30 seconds; accepted async work is observed
without resubmission; queued and executing cadence/deadlines remain 15 seconds/2
minutes and 30 seconds/20 minutes. The existing workflow is dispatched at most
once for absent CI and a proved transient completed run is rerun at most once,
with each allowance checkpointed before use and retained after an ambiguous lost
response. Explicit rejection is not retried and produces a checkpointed
**Resumable Stop** with preserved state and an exact next action.

**Forbidden observations.** Duplicate writes or async submissions, reset
allowances, status-page deadline extensions, retries of explicit rejection,
ticket finalization, or release/cleanup that loses recoverability.

**Evidence.** Fault-injector log, request/readback timeline, checkpointed retry
and allowance usage, provider lifecycle timestamps, final response, and artifact
manifest.

**Cleanup and cost.** Remove fault injection and evaluator-owned resources after
capture. Slow and provider-failure variants; conditional.

### IP-07 — broken-main repair and cooperative suspension

**Setup.** In a uniquely prefixed, evaluator-controlled sandbox repair window,
create one Parent Ticket whose otherwise valid feature intentionally makes only
push-to-main CI fail for an implementation reason. Prepare a second ordinary
Parent Ticket in the same Git common directory; invoke it during `repair`, or
start it earlier and keep it outside the Delivery Turn. Ensure the repair is a
small known change and verify no earlier run owns the turn. The evaluator
independently monitors `origin/main`; if another actor changes it, invalidate this
execution and rerun later instead of treating unsupported input as skill evidence.
Record the exact green feature PR head and the exact pre-merge main SHA.

**Invocation.** Deliver the feature through its failing exact-main CI. While its
owner is in `repair`, invoke or resume the ordinary run at dispatch, integration,
review, verification, push, PR/CI monitoring, and finalization boundaries. Let
the repair worker restore main and resume both runs after exact repaired-main CI.

**Required observations.** The owner checkpoints the failed exact-main run and
atomically changes its complete record from `delivery` to `repair`. Every
cooperating coordinator that observes `repair` performs none of the listed
ordinary activities. Before Batch initialization it returns **Do Not Start** and
creates no artifacts; after initialization it halts workers at recoverable
boundaries, preserves artifacts, checkpoints suspension, and returns
**Resumable Stop**. The repair starts from the exact known-broken `origin/main`
with one bounded repair worker. No evaluator actor changes or heals main, and no
external-advancement or already-healed-main branch is taken. The worker receives
only failure evidence and restoration scope, runs focused checks, and keeps
unrelated feature work out.

Each exact repair candidate receives combined review then canonical full
verification. Accepted findings or implementation failures return to the same
worker and invalidate prior evidence. The coordinator pushes normally, opens a
non-draft repair-only PR, observes exact-head PR CI, merges with a merge commit,
checkpoints its exact SHA, fetches `origin/main`, and proves exact equality plus
repair-head ancestry. It retains `repair` ownership through CI for that exact
repaired remote-main commit. Only green CI permits release, original-run ticket
finalization, local-main synchronization, cleanup, and resumption of suspended
ordinary work.

**Forbidden observations.** Automatic rollback; ordinary work during `repair`;
more than the original worker plus one permitted fresh/different-approach attempt
across the incident; reset attempt accounting; an unrelated repair-PR change;
taking an external-advance or already-healed-main repair branch; stale repair
gates; ticket mutation before exact repaired-main CI; releasing the turn after
broken or merely PR-green CI; or resuming ordinary work before release.

**Evidence.** Failed main-CI URL/SHA/log, atomic owner transitions and checkpoint
snapshots, every cooperating task's stop boundary and preserved artifacts, exact
broken base and repair branch ancestry, worker identities and cumulative attempt
count, focused checks, review/verification evidence, repair-only diff, PR
head/body/CI/merge SHA, fetched repaired-main equality/ancestry and exact CI URL,
ticket/local-main/cleanup state before and after release, and resumed-run events.

**Cleanup and cost.** Restore green main before removing only evaluator-owned
resources. Intentionally breaks shared sandbox `main` and may consume multiple
CI/delivery cycles; conditional under the shared rule above. Any executed run is
valid only while the evaluator observes a fixed base throughout.

### IP-07A — exhausted repair attempts

**Setup.** Inject repeatable implementation failures into repair candidates so
the original repair worker and its one permitted fresh-worker or genuinely
different-approach attempt both finish without a green repair candidate.

**Invocation.** Continue the same broken-main incident through both attempts.

**Required observations.** Cumulative attempt usage is checkpointed and never
reset by a new candidate, turn, task, or repair PR. After both attempts, the owner
records the exact human decision needed and returns **Resumable Stop** while
retaining `repair` ownership and every repair artifact. All ordinary work remains
suspended.

**Forbidden observations.** A third worker or approach, automatic rollback,
release, ordinary work, ticket finalization, local-main synchronization, or
cleanup of repair evidence.

**Evidence.** Worker/task identities, candidate SHAs and failure logs, cumulative
checkpoint usage, retained owner record and artifacts, and final response.

**Cleanup and cost.** The evaluator restores green main after capture, then
removes only its resources. Destructive failure exhaustion; conditional.

### IP-07B — repair provider and merge failures

**Setup.** At separate repair boundaries inject a lost repair-PR write response,
provider outage, credential rejection, transient repair CI failure, uncertain
repair merge response, and a second implementation failure after one repair merge.

**Invocation.** Continue the same fixed-base repair incident once per injected
condition.

**Required observations.** The common retry, reconciliation, observation,
dispatch, rerun, and attempt bounds apply without resetting across repair cycles.
An uncertain merge retains the turn until PR and `origin/main` prove the state.
A further implementation failure starts another bounded repair-only cycle from
the resulting exact broken main. External or exhausted conditions checkpoint the
exact next action and return **Resumable Stop** while retaining `repair` ownership
and suspending ordinary work.

**Forbidden observations.** Duplicate PR or merge writes, assuming success from a
lost response, externally healed/advanced-main logic, release on non-green main,
ordinary work, ticket finalization, or lost repair artifacts.

**Evidence.** Fault-injector and provider logs, request/readback timeline,
checkpointed retry/rerun/attempt usage, PR and `origin/main` state, owner record,
final response, and artifact manifest.

**Cleanup and cost.** Restore green main and remove fault injection after capture.
Destructive provider-failure variants; conditional.

## Result matrix format

Return this concise matrix in the delivery ticket or PR, not this repository:

| Version | Exact source commit | Model/settings | Scenario | Result | Evidence or residual risk |
| --- | --- | --- | --- | --- | --- |
| Baseline | `<sha>` | `<model and settings>` | IP-01 | Pass/Fail/Unstable | `<concise pointers>` |

List IP-01 through IP-06. List IP-06A through IP-06C and IP-07 through IP-07B as
Pass, Fail, Unstable, or Not run; use Not run only for an unexecuted variant and
include the reason. Include staged skill and upstream checksums once beside the
matrix. A failure
starts the Failure Repair Workflow; preserve its evidence and create no Candidate
skill text until every required Baseline scenario passes. Stop only for the
human-only or external blockers defined above.
