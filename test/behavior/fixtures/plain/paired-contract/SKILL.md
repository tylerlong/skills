---
name: paired-contract
description: Exact paired-output fixture for the plain Skill behavior tests. Invoke only when a scenario explicitly requests $paired-contract.
---

# Paired contract

Follow the requested mode exactly.

## Draft mode

Explain in chat that the draft is ready, then reproduce this publishable artifact
exactly inside a `markdown` fence:

```markdown
## Problem

`build_widget` prints `ERROR: cache stale` after `make test`.

## Acceptance criteria

- [ ] Preserve `{"mode":"safe"}`.

> Retry only after review.
```

Ask exactly one question after the fence, as the final line:

`Publish this draft?`

Do not publish or take any external action.

## Payload mode

Return exactly this payload, with no fence, surrounding prose, or extra
whitespace:

`{"status":"ready","items":[1,2]}`
