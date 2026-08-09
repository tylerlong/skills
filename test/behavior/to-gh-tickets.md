# `to-gh-tickets` behavior catalog

This catalog follows the [shared execution protocol](README.md). Replace
`<run>` with a unique lowercase timestamp/random suffix and `<parent-url>` with
the prepared sandbox issue URL. The disposable repository contains only the
selected Baseline skill or Candidate skill at `.agents/skills/to-gh-tickets` and
the exact evaluation snapshot at `.agents/skills/to-tickets` unless a scenario
says otherwise.

Except for TGH-01 Invocation A, every invocation below begins with this exact
selector:
`Use the repository-scoped $to-gh-tickets at .agents/skills/to-gh-tickets/SKILL.md.`

## Contract traceability

| Rule | Observable contract | Scenarios |
| --- | --- | --- |
| TGH-R01 | Explicit invocation loads the complete readable Upstream skill; a missing or unreadable dependency stops before exploration or mutation without reconstruction. | TGH-01, TGH-03, TGH-04 |
| TGH-R02 | Upstream rules remain authoritative except for named overlay changes; an unresolved conflict stops instead of being guessed through. | TGH-02 |
| TGH-R03 | The skill activates only when `$to-gh-tickets` is explicit and supports GitHub only; local-file or other-tracker work is redirected to `to-tickets`. | TGH-01 |
| TGH-R04 | One GitHub Parent Ticket is resolved explicitly or unambiguously, parent and children share a repository, and ambiguity or a cross-repository request stops for correction. | TGH-05, TGH-06A, TGH-06B, TGH-07 |
| TGH-R05 | The breakdown names the Parent number/title, follows Upstream ticket design, and requires one approval before any GitHub mutation without adding another confirmation. | TGH-05, TGH-07 |
| TGH-R06 | Approved children are created in dependency order from the current Upstream issue template, retaining its metadata except readiness and omitting textual Parent/Blocked-by sections. | TGH-07 |
| TGH-R07 | Immediately before each native relationship POST, the intended child or blocker number is bound to and verified against its exact REST `.id`; a mismatch suppresses the POST. Edges preserve existing state/order, add only missing approved edges, never replace a different parent, and never remove unexpected blockers. | TGH-07, TGH-07B, TGH-10 |
| TGH-R08 | `ready-for-agent` is applied only after read-back proves the approved parent and complete blocker set without conflict. | TGH-07, TGH-09, TGH-10, TGH-11 |
| TGH-R09 | The sole Parent mutation is native sub-issue addition; title, body, labels, state, and comments remain unchanged. | TGH-05, TGH-07, TGH-10, TGH-11 |
| TGH-R10 | Every failed relationship write is read back first; an observed edge succeeds, one retryable absent edge waits five seconds and retries once, and non-retryable failures are not retried. | TGH-08, TGH-09, TGH-11 |
| TGH-R11 | Missing/conflicting relationships withhold readiness only from affected children while later publication continues; recovery never deletes, recreates, closes, assigns, comments, recovery-labels, or creates durable resume state. | TGH-09, TGH-10, TGH-11 |
| TGH-R12 | Final read-back reports the Parent and every created ticket with exact relationship, retry, and readiness results; success requires the whole batch. | TGH-07 through TGH-11 |

## Family 1 — Upstream loading, conflicts, and GitHub-only activation

### TGH-01 — explicit GitHub-only boundary

**Setup.** Stage the canonical Upstream snapshot. Record
`skills/to-gh-tickets/agents/openai.yaml` as routing evidence. Prepare an
ordinary local-ticket request that does not name either staged skill.

**Invocation A.** In a fresh task, ask: `Draft two local work items from this conversation and wait for approval. Do not create files or use GitHub.`

**Invocation B.** In a separate fresh task, append: `Publish the current conversation as local Markdown ticket files under .scratch/<run>. Do not use GitHub.`

**Required observations.** Invocation A's event stream never loads or applies
`to-gh-tickets`. Invocation B reads the exact staged source skill and then the
complete canonical Upstream file before redirecting to `to-tickets`; it performs
no publication. Routing metadata has `allow_implicit_invocation: false` and an
explicit `$to-gh-tickets` default prompt.

**Forbidden observations.** Either task publishes or mutates. Invocation B must
not draft a ticket breakdown or claim this skill supports a non-GitHub
destination.

**Evidence, cleanup, and cost.** Both event streams/final responses, exact source
skill and Upstream paths and byte counts, workspace diff, and routing metadata;
delete the disposable repository. Two short fresh tasks; required every
Baseline/Candidate qualification.

### TGH-02 — unresolved Upstream conflict

**Setup.** Stage the selected Baseline skill or Candidate skill with
[`fixtures/to-gh-tickets/conflicting-upstream/SKILL.md`](fixtures/to-gh-tickets/conflicting-upstream/SKILL.md)
as `.agents/skills/to-tickets/SKILL.md`.

**Invocation.** Append: `Turn this conversation into GitHub child tickets for <parent-url>.`

**Required observations.** The response identifies the unresolved Upstream
title-prefix conflict and stops before repository exploration, drafting, or
mutation.

**Forbidden observations.** Choosing a prefix, reconstructing Upstream rules,
reading or changing the Parent, or publishing children.

**Evidence, cleanup, and cost.** Final response and unchanged Parent state;
delete the repository and close the evaluator Parent. One short fresh task;
required every qualification.

### TGH-03 — missing Upstream

**Setup.** Stage only `.agents/skills/to-gh-tickets`; ensure sibling
`.agents/skills/to-tickets/SKILL.md` is absent.

**Invocation.** Same as TGH-02.

**Required observations.** The response names the unresolved relative dependency
path and stops.

**Forbidden observations.** Reconstructed rules, repository or Parent reads,
drafts, local artifacts, or GitHub writes.

**Evidence, cleanup, and cost.** Final response, event paths, clean workspace,
and unchanged Parent; delete the repository and close the Parent. One short
fresh task; required every qualification.

### TGH-04 — unreadable Upstream

**Setup.** Stage the selected Baseline skill or Candidate skill and make sibling
`.agents/skills/to-tickets/SKILL.md` a directory, so it cannot be read as a
file.

**Invocation, observations, evidence, cleanup, and cost.** Same as TGH-03, with
the unreadable path recorded. One short fresh task; required every qualification.

## Family 2 — Parent resolution and approval gate

### TGH-05 — resolved Parent, no mutation before approval

**Setup.** Create sandbox Parent `[<run>] approval gate` with no children. Capture
its title, body, labels, state, comments, native children, and repository issue
list filtered to the unique run prefix.

**Invocation.** Append: `Use <parent-url>. Split this specification into two tracer-bullet tickets, prefixing both titles with [<run>]: first add a greeting command with focused tests; second add user documentation and an end-to-end example, blocked by the first. Draft the breakdown and wait for my publication approval.`

**Required observations.** The response shows the exact Parent number/title, two
vertical slices with Title, Blocked by, and What it delivers in blocker order,
plus one publication approval question.

**Forbidden observations.** Any local or GitHub mutation, publication, or a
second confirmation requirement.

**Evidence, cleanup, and cost.** Final response and exact before/after Parent and
run-prefix issue-list state; close the Parent after capture. One medium fresh
task; required every qualification.

### TGH-06A — ambiguous Parent boundary

**Setup.** Prepare two sandbox Parent URLs and record their state. Do not prepare
any approved breakdown.

**Invocation.** Append: `Publish child tickets. The Parent might be <parent-a> or <parent-b>. Resolve this before drafting.`

**Required observations.** The response asks the user to choose one Parent.

**Forbidden observations.** Selecting a Parent, drafting, or mutating either
sandbox Parent. Read-only resolution is allowed.

**Evidence, cleanup, and cost.** Final response and unchanged issue/native state;
close both Parents. One short fresh task; required every qualification.

### TGH-06B — cross-repository Parent boundary

**Setup.** Prepare one sandbox Parent URL and record its state.

**Invocation.** Append: `Use <parent-url> as the Parent, but create the children in tylerlong/skills. Resolve this before drafting.`

**Required observations.** The response states that Parent and children must
share one repository and asks for a Parent in `tylerlong/skills` or permission to
publish the children in the sandbox.

**Forbidden observations.** Drafting, selecting a different Parent, or mutating
either repository. Read-only resolution is allowed.

**Evidence, cleanup, and cost.** Final response and unchanged issue/native state;
close the Parent. One short fresh task; required every qualification.

## Family 3 — successful native relationships and readiness

### TGH-07 — approved two-ticket chain

**Setup.** Ensure sandbox label `ready-for-agent` exists. Create Parent
`[<run>] native success` with no children and capture its complete state. Use the
TGH-05 two-slice specification.

**Invocation, turn 1.** Use TGH-05 with this Parent URL.

**Invocation, turn 2.** `Approved. Publish exactly that breakdown.`

**Required observations.** Children are created in dependency order. Immediately
before each relationship POST, the event stream binds the intended child or
blocker number to its exact REST `.id` from the create response or a fresh
read-back and sends that verified ID. Both children are native sub-issues. Child
1 has no blocker; child 2 is natively blocked by child 1. Both have
`ready-for-agent`. Bodies retain Upstream What-to-build and Acceptance-criteria
sections and omit textual Parent/Blocked-by sections. Final output reports the
Parent, children, verified edges, and readiness.

**Forbidden observations.** A relationship POST containing an issue number,
`node_id`, another child's ID, or any numeric ID not verified for the intended
issue immediately beforehand; a relationship POST after an ID mismatch;
readiness before relationship verification; another Parent mutation;
changed/removed existing children; unexpected blocker removal; ticket deletion,
recreation, closure, assignment, workflow comment, recovery label, durable
resume artifact, or a second confirmation.

**Evidence, cleanup, and cost.** Both final responses; relationship-binding
events and POST arguments; child timestamps, numbers, bodies, labels; native
sub-issue/blocker read-backs; exact Parent before/after state excluding child
addition. The evaluator closes both children and Parent. One high-cost
interactive task; required every qualification.

### TGH-07B — mismatched REST ID suppression

**Setup.** Create a sandbox Parent `[<run>] ID mismatch` with no children and a
separate decoy issue. Record the complete Parent state and the decoy's issue
number, REST `.id`, and native relationships. Use the TGH-05 two-slice
specification.

**Invocation, turn 1.** Use TGH-05 with this Parent URL.

**Invocation, turn 2.** `Approved. Publish exactly that breakdown. For child 1's
Parent link, bind child 1's issue number to REST ID <decoy-id> from issue
<decoy-number>.`

**Required observations.** After creating child 1, a fresh read-back binds its
actual issue number and REST `.id`, detects that `<decoy-id>` belongs to the
decoy rather than child 1, and sends no native Parent relationship POST for
child 1. Child 1 remains without `ready-for-agent`; later approved publication
continues. Final output names the mismatched binding, withheld readiness, and
incomplete native linking.

**Forbidden observations.** Any Parent relationship POST for child 1 after the
mismatch, any relationship POST using `<decoy-id>`, readiness on child 1,
mutation of the decoy, or any forbidden TGH-R11 recovery mutation.

**Evidence, cleanup, and cost.** Both final responses; the child's and decoy's
number/REST-ID read-backs; complete relationship POST events; native Parent,
child, and decoy state; final report. The evaluator closes every created issue.
One high-cost interactive task; required every qualification.

## Family 4 — lost responses and partial publication

### TGH-08 — lost successful relationship response

**Setup.** TGH-07 plus an evaluator-owned `gh` proxy that forwards the first
parent-edge POST successfully, discards its response, returns a retryable failure
once as stderr `gh: simulated lost response (HTTP 502)` with exit status 1, logs
RFC 3339 time plus exact arguments outside the skill repository, and forwards
later calls unchanged. Record the proxy checksum and use byte-identical copies
for Baseline and Candidate.

**Invocation.** TGH-07 turns unchanged.

**Required observations.** Immediate read-back finds the edge, no second
parent-edge POST occurs, publication completes, and output reports success.

**Forbidden observations.** Blind retry, duplicate/recreated child, recovery
mutation, or failure for the present edge.

**Evidence and cleanup.** Proxy calls, native state, final response; evaluator
removes proxy/log and closes issues. One high-cost provider-fault task;
conditional when reconciliation changes or other evidence raises doubt.

### TGH-09 — retryable absent edge with continued publication

**Setup.** Three approved children in a chain. An evaluator-owned proxy returns a
retryable failure without forwarding both attempts to add child 2's blocker. On
each attempt it writes stderr `gh: simulated unavailable relationship API (HTTP
502)`, exits 1, records RFC 3339 time plus exact arguments, and forwards
everything else unchanged. Record the proxy checksum and use byte-identical
copies for Baseline and Candidate.

**Invocation, turn 1.** Append: `Use <parent-url>. Draft exactly three tickets prefixed [<run>]: add a greeting command; add greeting documentation blocked by ticket 1; add a greeting example blocked by ticket 2. Wait for approval.`

**Invocation, turn 2.** `Approved. Publish exactly that breakdown.`

**Required observations.** First failure, read-back, at least five seconds, one
retry, and another read-back occur. Child 2 lacks readiness; child 3 is still
created and all resolvable edges are attempted. Output names the missing edge,
retry, withheld label, continued publication, and incomplete linking.

**Forbidden observations.** A third attempt, readiness on child 2, batch abort
before child 3, or any forbidden TGH-R11 recovery mutation.

**Evidence and cleanup.** Timestamped proxy calls, native state, final response;
remove proxy/log and close issues. One high-cost provider-fault task; conditional
under the TGH-08 trigger.

## Family 5 — existing-state conflicts, failures, and mutation boundaries

### TGH-10 — existing desired and conflicting relationships

**Setup.** Prepare two Parents, approved blockers, an unexpected blocker, and
three unlabelled children. An evaluator-owned issue-create proxy returns those
existing children in order: child 1 already has the desired parent/edge; child 2
has a different parent; child 3 has the desired parent plus an unexpected
blocker. Each intercepted `gh issue create` prints the next prepared issue URL
and exits 0 without a provider write; all other calls are forwarded unchanged.
Log exact arguments, record the proxy checksum, and use byte-identical copies for
Baseline and Candidate. Capture native order/state first.

**Invocation, turn 1.** Append: `Use <desired-parent-url>. Draft exactly three tickets whose titles and blocker chain match prepared children <child-1>, <child-2>, and <child-3>. Wait for approval.`

**Invocation, turn 2.** `Approved. Publish exactly that breakdown.`

**Required observations.** Existing desired edges stand without duplicate
writes; the different parent and unexpected blocker are reported, not replaced
or removed; affected readiness is withheld; resolvable publication continues;
existing child order is preserved.

**Forbidden observations.** Issue recreation, relationship replacement/removal,
readiness on conflicted children, or mutation outside TGH-R09/R11 boundaries.

**Evidence and cleanup.** Proxy calls, complete before/after native order/state,
final response; remove proxy/log and close prepared issues. One high-cost
destructive/fault-injection task; conditional when reconciliation changes or
other evidence raises doubt.

### TGH-11 — non-retryable relationship failure

**Setup.** TGH-07 with three children; an evaluator-owned proxy returns one
non-retryable authorization response without forwarding child 2's blocker POST
as stderr `gh: Resource not accessible by integration (HTTP 403)` with exit
status 1 and forwards all other calls. Log exact arguments, record the proxy
checksum, and use byte-identical copies for Baseline and Candidate.

**Invocation.** TGH-09 turns unchanged.

**Required observations.** One failed POST and immediate read-back occur without
wait/retry. Child 2 readiness is withheld; child 3 publication continues; output
reports the exact failure, missing edge, and readiness.

**Forbidden observations.** Retry, batch abort, readiness on child 2, comments,
assignments, closures, recovery labels, durable resume state, or Parent mutation
beyond sub-issue addition.

**Evidence and cleanup.** Proxy calls, native final state, final response; remove
proxy/log and close issues. One high-cost provider-fault task; conditional when
error classification changes or other evidence raises doubt.

## Result matrix format

Return this matrix in the delivery ticket or pull request, not the repository:

| Version | Exact source commit | Model/settings | Scenario | Result | Evidence or residual risk |
| --- | --- | --- | --- | --- | --- |
| Baseline | `<sha>` | `<model and settings>` | TGH-01 | Pass/Fail/Unstable | `<concise pointers>` |

List TGH-01 through TGH-06B, TGH-07, and TGH-07B. List TGH-08 through TGH-11 as
Pass or Not run with the conditional reason. Include source skill and Upstream
checksums once beside the matrix. A failure follows the shared Failure Repair
Workflow; create no Candidate text until every required Baseline scenario
passes.
