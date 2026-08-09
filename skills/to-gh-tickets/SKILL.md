---
name: to-gh-tickets
description: GitHub-only to-tickets overlay for approved child tickets with verified native parent and blocker relationships. Use only when the user explicitly invokes $to-gh-tickets.
---

# To GitHub Tickets

Reuse the complete `to-tickets` workflow, changing only publication for a
resolved GitHub parent.

## Load upstream

On every invocation, read `../to-tickets/SKILL.md` completely. If it is missing
or unreadable, stop before any other work; never reconstruct its rules.

Upstream remains authoritative except where this overlay explicitly differs.
This overlay wins only for those differences. Stop and report any other
conflict instead of guessing.

This skill supports GitHub only. Even when asked, never draft or publish local
files or another tracker's tickets; tell the user to invoke `to-tickets`.

## Resolve and approve the parent

Accept an explicit GitHub issue number or URL. Otherwise infer exactly one
parent only when the conversation is unambiguous; ask if it is not. Parent and
children must share a repository.

Follow upstream for context, exploration, slicing, dependencies, approval,
titles, acceptance criteria, ordering, labels, and future rules. Include the
parent number and title in its approval breakdown. After approval, apply the
publication overlay below without another confirmation.

## Publish with native relationships

Publish approved children in upstream dependency order. For each child:

1. Use the current upstream GitHub issue template, omitting only its complete
   `Parent` and `Blocked by` sections.
2. Create the issue with all upstream metadata except `ready-for-agent`.
3. Read its native parent and blockers. Keep relationships upstream already
   created and add only missing approved edges.
4. Add the approved parent only when no different parent exists. Preserve every
   existing child and its order; verify inclusion rather than exact batch
   equality.
5. Add each now-resolvable approved blocker. Never remove or replace an
   unexpected blocker.
6. Read back the parent's children and the child's `blocked_by` list. Add
   `ready-for-agent` only after the approved parent and complete blocker set are
   present without conflict.

Immediately before each native relationship POST, bind the intended issue
number and exact REST `.id` from its create response or a fresh read-back: the
child for a parent edge, or the blocker for a blocker edge. If any candidate ID
was supplied or carried forward, verify it against this binding. A missing or
mismatched binding fails that edge; never substitute another ID or POST after a
mismatch. POST only the verified `.id` with `-F`, never an issue number,
`node_id`, another child's ID, or an unverified number:

```sh
gh api --method POST repos/OWNER/REPO/issues/PARENT/sub_issues -F sub_issue_id=CHILD_DATABASE_ID
gh api --method POST repos/OWNER/REPO/issues/CHILD/dependencies/blocked_by -F issue_id=BLOCKER_DATABASE_ID
```

The only permitted parent mutation is native sub-issue addition. Never change
its title, body, labels, state, or comments.

## Reconcile and report

After a failed relationship write, read back first. An observed desired edge is
success. If a retryable failure left it absent, wait five seconds, retry that
edge once, then read back again. Never retry authorization, permission,
validation, semantic-conflict, or different-parent failures.

One missing edge must not stop later approved tickets. Withhold
`ready-for-agent` from every incompletely linked or mismatched child. During
normal execution never delete, recreate, close, assign, or comment on tickets,
never apply recovery labels, and never create durable resume state.

Finally read back the whole new batch. Report success only when every child has
its approved parent, complete blockers, and readiness label; include the parent,
every child, verified relationships, and readiness. Otherwise report every
child, each missing or conflicting relationship, any attempted retry, and
withheld readiness, stating that publication continued but native linking is
incomplete.
