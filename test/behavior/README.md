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

Choose one coordinating Baseline commit for the whole simplification effort and
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

Run every required Baseline scenario before writing Candidate text. Run each
required scenario once per version. A clear failure starts diagnosis: repair a
faulty catalog, exact fixture, or evaluator without weakening the contract, or
make the minimum source skill repair at its owning boundary. A source skill
repair selects a new coordinating Baseline and invalidates all prior Baseline
evidence. Repair reruns are distinct from the single paired Baseline/Candidate
diagnostic rerun allowed for ambiguous AI variation. Persistent inconsistency is
**Unstable** and blocks qualification. Stop only for a human contract decision or
an external permission, credential, or infrastructure blocker.

Conditional scenarios are reserved for exceptionally slow, destructive, or
provider-failure cases. Run one when its protected rule changes materially or
other evidence raises doubt. Otherwise preserve the rule substantially
unchanged, mark the scenario **Not run**, and report the residual risk.

## Evidence, cleanup, and cadence

Capture final responses, relevant agent events, exact settings and checksums, and
provider-native state outside the repository. Put only a concise result matrix in
the delivery ticket or pull request; never commit transcripts, screenshots,
command logs, or cumulative result files.

Use a unique prefix for every resource in
`tylerlong/implement-in-parallel-sandbox`. Capture evidence before best-effort
evaluator cleanup. Cleanup may close evaluator-owned issues and remove disposable
repositories; it is not behavior of the skill under test.

Run required scenarios for every Baseline and final Candidate qualification.
Budget only the fresh tasks and follow-up turns named by each scenario. Run
deterministic repository tests separately afterward; do not add a behavior-test
Make target or generic runner.
