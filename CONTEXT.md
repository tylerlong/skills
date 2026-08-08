# Personal Skills

This repository is the canonical home for skills authored and maintained by Tyler Liu. Skills are installed elsewhere for use by agents.

## Language

**Source skill**:
The canonical, version-controlled definition of an authored skill.
_Avoid_: Live skill, working copy

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
