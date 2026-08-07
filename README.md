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
2. Review it and run the relevant Skills CLI checks.
3. Commit and push `main`.
4. Update the installed skill.

Only install committed versions from `main`.

## Install in Codex

```sh
npx --yes skills@latest add tylerlong/skills \
  --global \
  --agent codex \
  --skill implement-in-parallel \
  --skill plain \
  --skill to-gh-tickets \
  --yes
```

## Update

```sh
npx --yes skills@latest update \
  implement-in-parallel \
  plain \
  to-gh-tickets \
  --global \
  --yes
```
