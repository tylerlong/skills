# Skills

Personal AI-agent skill source. This repository is published to GitHub and its
Source Skills are installed on this machine from there via the Skills CLI.

## Source skills

- `chat-only`
- `implement-in-parallel`
- `plain`
- `to-gh-tickets`

## Upstream skills

- `implement-in-parallel` requires `implement`.
- `to-gh-tickets` requires `to-tickets`.
- `plain` has no upstream skill dependency.
- `chat-only` has no upstream skill dependency.

Keep upstream skills installed separately. Do not copy them into this repository.

## Workflow

1. Author and review each skill through the
   [skill authoring workflow](docs/agents/skill-authoring.md).
2. Run `make validate` and normal code review.
3. Push `main`.
4. Run `make install` as a separate post-merge consumer action.

A skill edit takes effect only after it is committed to `main`, pushed to
GitHub, and reinstalled with `make install` — `make install` pulls from GitHub
and never pushes.

Skill-authoring validation reviews instructions; it does not invoke a skill to
test whether an AI agent executes clear instructions correctly.

Only install committed versions from `main`.

## Commands

```sh
make validate
make install
```

Bare `make` lists these commands without changing anything.

`make install` validates a clean local `main`, updates upstream skills tracked
by the Skills CLI, and installs this repository's Source Skills from the
published GitHub repo (`tylerlong/skills`) via `npx skills add --global`.