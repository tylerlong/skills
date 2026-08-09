# Personal Skills

This repository is the canonical home for skills authored and maintained by Tyler Liu. Skills are installed elsewhere for use by agents.

## Language

**Source skill**:
The canonical, version-controlled definition of an authored skill.
_Avoid_: Live skill, working copy

**Skill contract**:
The required agent behavior and boundaries of a source skill, independent of its wording.
_Avoid_: Feature list, current prose

**Instruction footprint**:
The text and resulting token cost of a source skill's metadata and instructions.
_Avoid_: Big skill, skill size

**Skill behavior test**:
An AI-executed scenario that invokes a source skill and verifies its observable agent output or external state without depending on instruction wording.
_Avoid_: Prompt snapshot, skill unit test

**Baseline skill**:
The exact committed Source skill whose behavior must pass the agreed Skill behavior tests before Candidate work begins.
_Avoid_: Old skill, installed skill

**Candidate skill**:
The exact proposed source skill revision evaluated with the baseline skill's passing behavior tests.
_Avoid_: New skill, installed skill

**Carried forward**:
A behavior-evidence result retained after change-impact analysis proves its
scenario is disjoint from a repair. Its matrix row keeps the original execution
commit and gives the impact rationale.
_Avoid_: Rerun, Pass on the repaired commit

**Batch scope**:
The Parent Ticket's direct Child Tickets when a Batch Run starts, assumed unchanged until that run completes.
_Avoid_: Dynamic child set, frozen set

**Worker isolation**:
Child Ticket workers do not communicate, monitor, synchronize, or know about sibling workers; the coordinator handles ticket dependencies through their starting commits.
_Avoid_: Child independence, worker coordination

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
