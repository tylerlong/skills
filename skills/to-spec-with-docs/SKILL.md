---
name: to-spec-with-docs
description: Turn the current conversation into a spec including project documentation updates, delegate review of the created spec ticket to a fresh sub-agent, and edit the spec ticket based on the review findings.
---

# To Spec with Docs

1. Invoke the `to-spec` skill with the instruction: "If the change affects project documentation, include the documentation updates in the spec".
2. Delegate to a fresh sub-agent that has not seen this authoring conversation, giving it (1) the repository path on disk and (2) the Parent Ticket number, and instruct it to review the created spec ticket (the Parent Ticket) against this skill's rules, reporting concrete findings and recommended edits. Edit the ticket based on the findings you accept, and repeat until the review reports no findings or every remaining finding is one you have rejected.
