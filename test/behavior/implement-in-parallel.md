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
| R14 | External writes are reconciled before retry and synchronous/asynchronous operations remain within their stated bounds. | IP-04, IP-06, IP-07 |
| R15 | Pre-finalization status goes only to the checkpoint and user; tickets stay unchanged until exact remote-main CI is green. | IP-04, IP-05 |
| R16 | The Delivery Turn serializes merge/main-CI ownership and normal advanced-base changes invalidate candidate evidence. | IP-04, IP-06 |
| R17 | Broken-main repair is repair-only, starts from the exact known-broken `origin/main`, suspends ordinary work, and retains the turn through exact repaired-main CI. | IP-07 |
| R18 | Finalization updates tickets only after exact green remote-main CI, safely synchronizes local `main`, then cleans only proven successful owned artifacts. | IP-04 |
| R19 | Resume reconciles checkpoint claims with GitHub and Git state and does not repeat valid completed work. | IP-05 |
| R20 | Missing trustworthy verification or a non-retryable blocker stops with preserved evidence and an exact next action. | IP-03, IP-05, IP-07 |

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

## Conditional scenarios

These rules remain authoritative even when the variants are not run. Mark each
**Not run** with residual risk unless its rule changes materially or core evidence
raises doubt, in which case it becomes required.

### IP-06 — concurrent Batch Runs and advanced base

Run two uniquely prefixed sandbox Parents concurrently through green exact-head
PR CI. Observe that work proceeds concurrently before delivery, only one exact
owner record acquires the guarded Delivery Turn, the other makes an immediate
checkpointed Resumable Stop without polling or stealing, and a normal
`origin/main` advance causes merge/update plus complete gate invalidation before
the second run can acquire the turn. Exercise ambiguous-owner inheritance only
when evaluator-controlled task liveness can be proven. This is conditional
because it consumes two deliveries and timing-sensitive CI.

### IP-07 — broken-main repair and cooperative suspension

In an evaluator-controlled sandbox window, deliberately merge a unique candidate
whose exact remote-main CI fails for an implementation reason. Observe atomic
`repair` ownership, repository-wide ordinary-work suspension, a repair-only branch
and PR from the fixed exact broken `origin/main`, bounded repair-worker attempts,
review/full verification/exact-head PR CI, exact repaired-main CI, retained turn
until green, and only then finalization. No external actor advances or heals main;
this preserves D3's fixed-base assumption. Also specify but do not normally inject
lost write responses, provider outages, credential failures, exhausted repair
attempts, or uncertain merge responses. This is conditional because it
intentionally breaks shared `main` and can consume multiple CI/delivery cycles.

## Result matrix format

Return this concise matrix in the delivery ticket or PR, not this repository:

| Version | Exact source commit | Model/settings | Scenario | Result | Evidence or residual risk |
| --- | --- | --- | --- | --- | --- |
| Baseline | `<sha>` | `<model and settings>` | IP-01 | Pass/Fail/Unstable | `<concise pointers>` |

List IP-01 through IP-05. List IP-06 and IP-07 as Pass or Not run with the reason.
Include staged skill and upstream checksums once beside the matrix. A failure
starts the Failure Repair Workflow; preserve its evidence and create no Candidate
skill text until every required Baseline scenario passes. Stop only for the
human-only or external blockers defined above.
