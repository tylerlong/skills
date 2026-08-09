# Skill behavior tests

Skill behavior tests are AI-executed scenarios that characterize observable
agent output and authoritative external state. They do not inspect instruction
wording or hidden reasoning and are not part of `make test`.

## Scenario format

Each scenario records a stable catalog identifier such as `IP-01`, `TGH-01`, or
`TGH-06A`, covered Skill contract rules, exact setup and invocation (including
follow-up turns), required and forbidden observations, evidence, evaluator
cleanup, execution class, and expected cost or cadence. Every contract rule maps
to an observable check. Version only exact reusable fixtures; keep simple setup
in the catalog.

## Execution protocol

Choose one coordinating Baseline commit for the whole Source skill revision and
record its full SHA. In separate disposable repositories, copy each exact
Baseline skill or Candidate skill to `.agents/skills/<name>`. Snapshot each
required Upstream skill once, record its checksum, and stage byte-identical
copies beside both skills. Never read, replace, invoke, or mutate the user-level
Installed skill.

Record the exact Codex CLI version, command, model, reasoning effort, service
tier, personality, permissions, prompts, Baseline or Candidate source commit and
skill checksum, Upstream checksums, and evaluator-owned environment. Keep all of
them identical between Baseline and Candidate. Invoke explicit-only skills by
name and identify the staged repository path in the prompt so the selected copy
is observable.

Run every required scenario once for initial Baseline qualification before
creating the Candidate skill, then once for initial Candidate qualification. A
clear failure starts diagnosis: repair the catalog, exact fixture, evaluator,
Baseline skill, or Candidate skill at its owning boundary without weakening the
Skill contract.

Before a repair rerun, inspect the exact change and use the catalog's
rule-to-scenario trace to find every scenario whose required or forbidden
observations could change. Include shared setup, fixtures, evaluator behavior,
model or settings, Upstream skills, earlier interaction turns, and dependent
downstream flows. Invalidate and rerun that affected set. Evidence for a
demonstrably disjoint scenario may be **Carried forward**, but its matrix row
must retain the original execution commit and state the impact rationale; never
claim that it ran against the repaired commit. Do not automatically restart the
full required suite merely because the repaired commit changed.

If impact is uncertain, cross-cutting, or cannot be bounded safely, invalidate
the broader family or full required suite. Global evaluator, model, settings,
dependency, routing, and shared-contract changes normally require broad
invalidation. A Baseline repair establishes a new shared Baseline and pauses
Candidate work until affected Baseline scenarios pass and unaffected evidence
is explicitly carried forward. A Candidate repair establishes an amended
Candidate; rerun its affected scenarios and carry forward only disjoint evidence.
Apply the same analysis to accepted review repairs.

Repair reruns do not consume the single paired Baseline/Candidate diagnostic
rerun allowed for ambiguous AI variation. Persistent inconsistency is
**Unstable**. Continue after fixable issues; stop only for a human contract
decision or an external permission, credential, or infrastructure blocker.

Conditional scenarios are reserved for exceptionally slow, destructive, or
provider-failure cases. Run one when its protected rule changes materially or
other evidence raises doubt. Otherwise preserve the rule substantially
unchanged, mark the scenario **Not run**, and report the residual risk.

## Evidence, cleanup, and cadence

Capture final responses, relevant agent events, exact settings and checksums, and
provider-native state outside the repository. Put only a concise result matrix in
the delivery ticket or pull request; never commit transcripts, screenshots,
command logs, or cumulative result files. Record each scenario as **Pass**,
**Fail**, **Unstable**, **Not run**, or **Carried forward**. A carried row names
its original commit and rationale; a conditional Not run row names its residual
risk.

Use a unique prefix for every resource in
`tylerlong/implement-in-parallel-sandbox`. Capture evidence before best-effort
evaluator cleanup. Cleanup may close evaluator-owned issues and remove disposable
repositories; it is not behavior of the skill under test.

Budget only the fresh tasks and follow-up turns named by each scenario. The
affected-set rule governs iterative Skill behavior tests only. Against the exact
final commit, always rerun deterministic repository tests, any repository-defined
full verification, and required final reviews. Do not add a behavior-test Make
target or generic runner.
