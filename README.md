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

1. Define or update the Skill behavior tests outside `skills/`.
2. Resolve the exact Baseline skill and run every required scenario once. Repair
   failures at their owning boundary until all invalidated scenarios pass and
   unaffected evidence is explicitly carried forward.
3. Revise the Source skill without weakening its Skill contract, then run
   every required scenario once against the exact Candidate skill. Apply the
   same change-impact process to later repairs.
4. After behavioral evidence is complete, commit the proposed final tree, then
   run `make test`, any additional repository-defined full verification, and
   final review against that exact commit. An accepted repair repeats
   change-impact analysis for Skill behavior evidence before rerunning these
   exact-final gates.
5. Push `main`.
6. Run `make install` as a separate post-merge consumer action.

The [Skill behavior test guide](test/behavior/README.md) defines isolated setup,
change-impact reruns, carried-forward evidence, and delivery reporting. Keep raw
execution evidence out of the repository.

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
