# Skills

Personal Codex skill source. Installed skills are disposable copies.

## Source skills

- `implement-in-parallel`
- `plain`
- `to-gh-tickets`

## Upstream skills

- `implement-in-parallel` requires `implement`.
- `to-gh-tickets` requires `to-tickets`.
- `plain` has no upstream skill dependency.

Keep upstream skills installed separately. Do not copy them into this repository.

## Workflow

1. Author and review the requirements and Source skill through the
   [requirements-first workflow](docs/agents/skill-authoring.md).
2. Run `make test` and normal code review.
3. Push `main`.
4. Run `make install` as a separate post-merge consumer action.

Skill-authoring validation reviews instructions; it does not invoke a skill to
test whether Codex executes clear instructions correctly.

Only install committed versions from `main`.

## Commands

```sh
make validate
make test-install
make test
make install
```

Bare `make` lists these commands without changing anything.

`make install` validates a clean local `main`, updates every Installed Skill
tracked by the Skills CLI, and then reconciles each Source Skill into its Managed
Installed Skill folder. It removes legacy content only inside currently managed
folders. This local reconciliation does not change unrelated Installed Skills or
Skills CLI metadata.
