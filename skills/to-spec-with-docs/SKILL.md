---
name: to-spec-with-docs
description: Turn the current conversation into a spec including project documentation updates, review it with model tencent/hy3, and edit the spec ticket based on the review findings.
---

# To Spec with Docs

1. Invoke the `to-spec` skill with the instruction: "If the change affects project documentation, include the documentation updates in the spec".
2. Review the created spec ticket with model `tencent/hy3`, and edit the ticket based on the review findings.

## Review invocation mechanics

`<repo_dir>` is the git repository root; `#<n>` is the ticket created by `to-spec`.

```bash
hermes --in "<repo_dir>" \
  -z "Review spec ticket #<n> per the rules in the to-spec skill. Report concrete findings and recommended edits." \
  --provider openrouter \
  --model tencent/hy3
```
