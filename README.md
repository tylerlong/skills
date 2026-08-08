# Skills

Personal Codex skill source. Installed skills are disposable copies.

## Source skills

- `implement-in-parallel`
- `plain`
- `to-gh-tickets`

## Upstream skills

- `implement-in-parallel` requires `implement`, `tdd`, and `code-review`.
- `to-gh-tickets` requires `to-tickets`.
- `plain` has no upstream skill dependency.

Keep upstream skills installed separately. Do not copy them into this repository.

## Workflow

1. Edit the source skill under `skills/`.
2. Review it and run `make test`.
3. Commit and push `main`.
4. Run `make install`.

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
