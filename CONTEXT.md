# Personal Skills

This repository is the canonical home for skills authored and maintained by Tyler Liu. Skills are installed elsewhere for use by agents.

## Language

**Source skill**:
The canonical, version-controlled definition of an authored skill.
_Avoid_: Live skill, working copy

**Source identity**:
The repository path, full Git commit SHA, and SHA-256 digest of an exact complete
Source skill file.
_Avoid_: Branch name, short SHA

**Skill contract**:
The required agent behavior and boundaries of a source skill, independent of its wording.
_Avoid_: Feature list, current prose

**Plain contract specification**:
The versioned, wording-independent statement of the `plain` source skill's atomic obligations, including each obligation's modality, conditions, and exceptions.
_Avoid_: Contract Map, Plain behavior catalog

**Contract fidelity**:
The Plain review gate requiring every supported reader profile to recover every specified obligation with its intended modality, conditions, and exceptions from the exact Source skill, without recovering a material extra or incompatible obligation or plausible materially incompatible alternative reading.
_Avoid_: Contract coverage, majority agreement

**Instruction clarity**:
The Plain quality dimension measuring how precisely and consistently instructions express obligations, boundaries, conditions, and exceptions.
_Avoid_: Contract fidelity, correctness score

**Instruction readability**:
The Plain quality dimension measuring how easily a reader can navigate and understand instructions without avoidable repetition or cognitive load.
_Avoid_: Output readability, brevity

**Instruction footprint**:
The Unicode code-point count of a source skill's complete `SKILL.md`, including frontmatter, body, whitespace, and final newline.
_Avoid_: Big skill, skill size

**Skill behavior test**:
An AI-executed, controlled scenario that invokes an exact Source skill and
verifies its observable agent output or authoritative external state without
depending on instruction wording or hidden reasoning.
_Avoid_: Prompt snapshot, skill unit test

**Skill contract review**:
A direct evaluation of exact Source skill instructions against the Plain contract specification, measuring contract fidelity, instruction clarity, and instruction readability without claiming runtime compliance.
_Avoid_: Skill behavior test, runtime evaluation

**Available task evidence**:
Evidence already established by the task or owning skill and present in the agent's current context. Plain selects and presents it but does not initiate investigation to create new evidence.
_Avoid_: Complete investigation record, hidden evidence

**Baseline skill**:
The exact committed Source skill evaluated before a revision under recorded
controlled conditions. A preservation comparison requires a Baseline that
passes the Source skill's applicable evaluation protocol.
_Avoid_: Old skill, installed skill

**Candidate skill**:
The exact proposed Source skill revision evaluated under its applicable protocol
and the same controlled conditions as the Baseline, except when an approved
contract change requires Candidate-only qualification.
_Avoid_: New skill, installed skill

**Carried forward**:
A behavior-evidence result retained after change-impact analysis proves its
scenario is disjoint from a repair. Its matrix row keeps the original execution
commit and gives the impact rationale.
_Avoid_: Rerun, Pass on the repaired commit

**Batch scope**:
The Parent Ticket's direct Child Tickets when a Batch Run starts, assumed unchanged until that run completes.
_Avoid_: Dynamic child set, frozen set

**Worker profile**:
The Codex model and reasoning-effort combination approved for a Child Ticket
and assigned to its implementation worker.
_Avoid_: Worker model, Ticket complexity

**Reader profile**:
The Codex model and reasoning-effort combination assigned to a Skill contract review reader.
_Avoid_: Worker profile, judge profile

**Worker isolation**:
Child Ticket workers do not communicate, monitor, synchronize, or know about sibling workers; the coordinator handles ticket dependencies through their starting commits.
_Avoid_: Child independence, worker coordination

**Repair proof**:
Evidence tied to one repair that demonstrates the reported defect or violated behavior in the exact starting state and demonstrates that its acceptance check succeeds in the repaired state.
_Avoid_: Generic focused checks, unrelated passing tests

**Installed skill**:
A disposable copy of a source skill made available to agents.
_Avoid_: Source skill

**Managed installed skill**:
An installed skill whose source skill lives in this repository and whose folder may be replaced during installation.
_Avoid_: Global skill, Repository-owned installed skill

**Overlay skill**:
A source skill that reuses and selectively changes an upstream skill without copying it.
_Avoid_: Fork, vendored skill

**Upstream skill**:
An externally maintained skill that an overlay skill requires and loads separately.
_Avoid_: Bundled skill
