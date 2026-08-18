# Personal Skills

This repository is the canonical home for skills authored and maintained by Tyler Liu. Skills are installed elsewhere for use by agents.

## Language

**Source skill**:
The single version-controlled representation of one skill at
`skills/<skill-name>/SKILL.md`. Its body is simultaneously the semantic
authority for the skill's product behavior and the AI-facing instructions.
_Avoid_: Installed skill

**Skill requirements**:
The behavioral requirements held in a Source skill's `SKILL.md` body — the
smallest complete description of the skill's non-obvious behavior — which the
authoring review gates.
_Avoid_: Spec, Instruction set

**Installed skill**:
A disposable copy of a Source skill made available to agents.
_Avoid_: Source skill

**Managed installed skill**:
A disposable Installed skill whose Source skill lives in this repository and
whose folder may be replaced during installation.
_Avoid_: Global skill, Repository-owned installed skill

**Upstream skill**:
An externally maintained skill that a Source skill requires and loads separately.
_Avoid_: Bundled skill

**Worker profile**:
The exact AI model and reasoning-effort combination assigned to a Child Ticket for its Worker Agent.
_Avoid_: Complexity tier, Model profile
