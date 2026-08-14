# Skill requirements and instructions

Every skill's behavior has two version-controlled semantic artifacts with
different responsibilities:

- `requirements/<skill-name>.md` is the human-facing semantic source of truth.
- `skills/<skill-name>/SKILL.md` is the AI-facing presentation of those requirements.

The requirements determine what the skill means. `SKILL.md` may present them in
any form that lets an AI recover their meaning without loss or invention.

`skills/<skill-name>/agents/openai.yaml` is required platform metadata for the
skill's interface and invocation policy. It is not product behavior, so it is
outside requirements review and reconstruction review.

## Write the requirements

Create `requirements/<skill-name>.md` with a title and ordered requirements.
Use sections when they clarify distinct actors or workflows, and use a compact
term list when definitions are needed. Include only non-obvious, skill-specific
behavior that changes Codex's default behavior. Do not include common sense,
ordinary Codex behavior, tool instructions, or implementation details outside
the skill's product scope.

Use the [requirements-list simplification guide](requirements-list-simplification.md)
to draft, organize, and simplify the list.

Product design alone determines the requirements. Change them only when the
human owner intentionally changes the skill's scope or behavior.

## Review the requirements

The coordinator first compares the complete list with the settled product
decisions. Confirm that every intentional behavior is present, no unapproved
behavior was invented, and legacy material was used only to find possible
omissions. Then review the list using the
[requirements-list simplification guide](requirements-list-simplification.md).

Next, use one fresh subagent with the same AI profile as the coordinating chat.
Give it only the exact requirements list and the simplification guide. It must
have no chat history and must not use tools, inspect other files, see
product-design material, or read prior reports. Ask it to perform one review
cycle and return the report defined by the guide.

The coordinator adjudicates every finding against the settled product decisions.
Reject invalid findings with a reason. For each accepted finding, apply the
smallest correction, review the complete list again, and give the changed list
to another fresh blind reviewer. Do not resample an unchanged list.

Repeat until a reviewer reports no findings or the coordinator rejects every
finding with a reason. Ask the human owner only when a finding requires an
unresolved product decision. Finalize the requirements when no valid unresolved
finding remains. Keep review reports with the task, issue, or pull request rather
than version-controlling them.

## Generate `SKILL.md`

Generate `skills/<skill-name>/SKILL.md` from the finalized requirements. The
requirements are the only behavioral authority; do not carry forward behavior
merely because an older `SKILL.md`, test, document, or history contains it.
`SKILL.md` may reproduce the requirements directly or present them differently.

There are no general authoring-style requirements for `SKILL.md`. Human
readability, formatting preferences, instruction footprint, and numeric quality
scores are outside the acceptance gate. Do not intentionally make the file hard
for humans to read, but optimize only for accurate AI understanding.

Change `SKILL.md` without changing the requirements only when reconstruction
review shows that the current presentation is lossy or ambiguous.

## Review `SKILL.md`

Use one fresh subagent that did not participate in requirements review, with the
same AI profile as the coordinating chat. Give it only the exact complete
`SKILL.md` and instructions to rebuild the requirements. It must have no chat
history and must not use tools, inspect other files, see the authoritative
requirements, or see prior reports or comparison results.

Ask it to return an ordered requirements list and identify any materially
different readings it cannot resolve.

The coordinator compares the rebuilt list with the authoritative requirements
in both directions:

- every authoritative requirement must be present in the rebuilt list;
- every rebuilt requirement must be authorized by the authoritative list; and
- conditions, boundaries, exceptions, permissions, requirements, and
  prohibitions must have identical meaning.

Wording, numbering, and grouping may differ. The lists match only when either
could replace the other without changing the skill's behavior.

If they do not match, rewrite only `SKILL.md` and review the changed file with
another fresh blind reader. Do not change the requirements merely to make the
presentation pass, and do not resample an unchanged `SKILL.md`. If product
behavior must change, return to the requirements process first.

## Finish the change

Do not invoke the skill or test whether Codex can carry out clear instructions.
Execution mistakes by Codex or an available tool are outside skill-authoring
scope. Runtime scenarios, human-readability scoring, and review matrices are not
part of this process.

After the rebuilt and authoritative requirements match, run `make test` and
normal code review. Version-control the finalized requirements and matching
`SKILL.md` together, along with platform metadata when it changes.

After the change is committed and pushed to `main`, run `make install` separately
from a clean local `main`.
