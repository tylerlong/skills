# Skill behavior tests

Skill behavior tests are AI-executed scenarios that characterize observable
agent output and authoritative external state. They do not inspect instruction
wording or hidden reasoning and are not part of `make test`.

The `plain` Source skill is the explicit exception recorded by ADR 0002. Its
[`Plain contract specification`](plain.md) defines a direct Skill contract
review of exact Source instructions; Plain has no runtime scenario or fixture
and does not use the execution protocol below. Other Source skills continue to
use this behavior-test policy unchanged.

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

Before Source-skill edits, classify the revision as behavior-preserving or
behavior-changing and update its specifications. Run every affected Baseline
scenario once, then each affected Candidate scenario once under the same
recorded conditions. A behavior-preserving revision requires a passing
characterized Baseline. A behavior-changing revision may classify a clear
Baseline mismatch with the newly specified behavior as **Gap**; the Candidate
must pass. A clear unexpected failure starts diagnosis at the owning catalog,
fixture, evaluator, Baseline, or Candidate boundary without weakening the Skill
contract.

If either result is ambiguous, permit at most one paired Baseline/Candidate
diagnostic rerun. Persistent inconsistency is **Unstable**; never rerun until a
desired answer appears.

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
Candidate work until affected Baseline scenarios pass or expected
behavior-changing gaps are recorded, and unaffected evidence is explicitly
carried forward. A Candidate repair establishes an amended
Candidate; rerun its affected scenarios and carry forward only disjoint evidence.
Apply the same analysis to accepted review repairs.

Repair reruns caused by an identified evaluator or skill change do not consume
the single paired diagnostic rerun allowed for ambiguous AI variation. Continue
after fixable issues; stop only for a human contract decision or an external
permission, credential, or infrastructure blocker.

Conditional scenarios are reserved for exceptionally slow, destructive, or
provider-failure cases. Run one when its protected rule changes materially or
other evidence raises doubt. Otherwise preserve the rule substantially
unchanged, mark the scenario **Not run**, and report the residual risk.

## Evidence, cleanup, and cadence

Capture final responses, relevant agent events, and provider-native state outside
the repository. For every observation record the exact Source commit; model,
reasoning effort, service tier, and settings; Codex CLI version and command;
personality and permissions; prompt; Source and Upstream checksums; evaluator
environment; result; and evidence location. Put only a concise result matrix in
the delivery ticket or pull request; never commit transcripts, screenshots,
command logs, or cumulative result files. Record each scenario as **Pass**,
**Gap**, **Fail**, **Unstable**, **Not run**, or **Carried forward**. Gap is valid
only for a behavior-changing Baseline. A carried row names its original commit
and rationale; a conditional Not run row names its residual risk.

Use a unique prefix for every resource in
`tylerlong/implement-in-parallel-sandbox`. Capture evidence before best-effort
evaluator cleanup. Cleanup may close evaluator-owned issues and remove disposable
repositories; it is not behavior of the skill under test.

Budget only the fresh tasks and follow-up turns named by each scenario. The
affected-set rule governs iterative Skill behavior tests only. Against the exact
final commit, always rerun deterministic repository tests, any repository-defined
full verification, and required final reviews. Do not add a behavior-test Make
target or generic runner.
