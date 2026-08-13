# Personal Skills

This repository is the canonical home for skills authored and maintained by Tyler Liu. Skills are installed elsewhere for use by agents.

## Language

**Requirements list**:
The version-controlled, human-facing semantic authority for one skill at
`requirements/<skill-name>.md`.
_Avoid_: Skill contract, behavior-test specification

**Source skill**:
The version-controlled, AI-facing presentation of a Requirements list at
`skills/<skill-name>/SKILL.md`.
_Avoid_: Requirements list, Installed skill

**Requirements reconstruction**:
A fresh blind reader's self-contained rebuild of a Source skill's requirements,
accepted only when it is semantically interchangeable with the authoritative
Requirements list.
_Avoid_: Wording comparison, runtime test

**Installed skill**:
A disposable copy of a Source skill made available to agents.
_Avoid_: Source skill, Requirements list

**Managed installed skill**:
A disposable Installed skill whose Source skill lives in this repository and
whose folder may be replaced during installation.
_Avoid_: Global skill, Repository-owned installed skill

**Upstream skill**:
An externally maintained skill that a Source skill requires and loads separately.
_Avoid_: Bundled skill
