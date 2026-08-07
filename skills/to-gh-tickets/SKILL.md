---
name: to-gh-tickets
description: Publish approved tracer-bullet tickets to GitHub with verified native parent and blocker relationships by reusing the installed to-tickets skill. Use only when the user explicitly invokes $to-gh-tickets to turn a specification, issue, or conversation into GitHub child tickets with relationship read-back and readiness gating.
---

# To GitHub Tickets

Reuse the complete installed `to-tickets` workflow. Change only GitHub child
publication for a resolved parent.

## Load the upstream workflow

Resolve `../to-tickets/SKILL.md` relative to this skill and read it completely on
every invocation. Stop before work if it is missing or unreadable; never copy or
reconstruct its rules.

Treat every current and future upstream instruction as authoritative except for
the explicit changes in the overlay below. Let those listed changes take
precedence. If a future instruction creates another conflict that the overlay
does not resolve, stop immediately after loading upstream and report it instead
of guessing.

Support GitHub only. For local files or another tracker, tell the user to invoke
`to-tickets` instead.

## Resolve and approve the parent

Accept an explicit GitHub issue number or URL. Otherwise infer one parent only
when the conversation identifies it unambiguously; ask when it does not.

Require the parent and newly created children to belong to the same repository.
Show the resolved parent number and title in the upstream ticket-breakdown
approval. Do not add another confirmation step.

Follow the entire upstream workflow for context gathering, exploration, vertical
slicing, dependency design, approval, titles, acceptance criteria, ordering,
labels, and every future step. Apply the following overlay only after the user
approves publication.

## Publish with native relationships

Publish approved children in upstream dependency order.

For relationship writes, use each issue's numeric database `.id`, not its issue
number. With `gh api`, pass numeric fields with `-F`:

```sh
gh api --method POST repos/OWNER/REPO/issues/PARENT/sub_issues -F sub_issue_id=CHILD_DATABASE_ID
gh api --method POST repos/OWNER/REPO/issues/CHILD/dependencies/blocked_by -F issue_id=BLOCKER_DATABASE_ID
```

For each child:

1. Derive its body from the current upstream GitHub issue template. Omit only the
   complete `Parent` and `Blocked by` sections; preserve every other current or
   future section.
2. Create the issue with all upstream metadata except `ready-for-agent`.
3. Read its native parent and blocker state. Let relationships already created by
   upstream stand, and add only missing approved relationships.
4. Reconcile the native parent without replacing a different parent. Preserve all
   existing children and their order; verify the new child by inclusion rather
   than by requiring the parent child list to equal this batch.
5. Reconcile every approved blocker that is now resolvable. Never remove or
   replace an unexpected blocker.
6. Read back the parent's native sub-issue list and the child's native
   `blocked_by` list. Apply `ready-for-agent` only when the approved parent and
   complete blocker set are verified and no conflicting relationship exists.

Permit only native sub-issue addition as a parent mutation. Do not edit the
parent's title, body, labels, state, or comments.

## Reconcile failed writes

After any unsuccessful relationship write, read the relationship back. Treat the
write as successful when the desired edge exists.

When the edge remains absent after a retryable failure, wait five seconds and
retry that relationship once, then read it back again. Do not retry authorization,
permission, validation, semantic-conflict, or different-parent failures.

Continue publishing later approved tickets when one relationship remains missing.
Leave every incompletely linked or mismatched child without `ready-for-agent`.
During normal execution, never delete, recreate, close, or assign tickets; never
relabel them as recovery; never post workflow comments; and never create durable
resume state.

## Report the result

Perform one final read-back of the new batch.

- Report complete success only when every created ticket has its approved native
  parent, complete blocker set, and readiness label. Include the resolved parent,
  every created ticket, verified parent and blocker relationships, and readiness
  state.
- Otherwise report every created ticket, exact missing or conflicting
  relationship, attempted retry, and withheld readiness label. State that ticket
  publication continued but native linking is incomplete.
