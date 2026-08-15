# Skill requirements and instructions

Every skill's behavior has two version-controlled representations with different
responsibilities:

- `requirements/<skill-name>.md` is the human-facing semantic source of truth.
- The body of `skills/<skill-name>/SKILL.md` is the AI-facing presentation of
  those requirements.

The requirements determine the skill's behavior after invocation. The
`SKILL.md` body may present them in any form that lets an AI recover their
meaning without loss or invention.

The `name` and `description` in `SKILL.md` frontmatter and
`skills/<skill-name>/agents/openai.yaml` are required platform metadata for
discovery, interface, and invocation policy. They are not product behavior, so
they are outside requirements review and reconstruction review.

## Write the requirements

Settle the skill's product behavior with the human owner. Existing skills,
tests, documents, issues, discussions, and history may reveal possible
omissions, but they do not preserve behavior automatically.

Create `requirements/<skill-name>.md` with a title and requirements organized in
a useful conceptual or execution order. Use sections when they clarify distinct
actors or workflows, and use a compact term list when definitions are needed.
Include only non-obvious, skill-specific behavior that changes an AI agent's default
behavior. Do not include common sense, ordinary AI-agent behavior, tool
instructions, or implementation details outside the skill's product scope.

Prefer delegating work to an Upstream skill over doing it in this skill. When the
skill builds on another skill's behavior, delegate as much as possible, and keep
this skill a preprocessor or postprocessor of that dependency. Do not change or
override a dependency skill's behavior in this skill's requirements.

Use the [requirements-list simplification guide](requirements-list-simplification.md)
to draft, organize, and simplify the list.

Only the human owner changes the skill's scope or behavior. The coordinator may
rewrite, reorder, merge, or split requirements to express the settled behavior
more accurately without changing its meaning.

## Review the requirements

The coordinator first compares the complete list with the settled product
decisions. Confirm that every intentional behavior is present, no unapproved
behavior was invented, and legacy material was used only to find possible
omissions. Then review the list using the
[requirements-list simplification guide](requirements-list-simplification.md).

Next, use one fresh subagent with the same AI profile as the coordinating chat.
Give it only the verbatim current contents of the complete requirements file and
the simplification guide, not paths, summaries, or earlier snapshots. It must
have no chat history and must not use tools, inspect other files, see
product-design material, or read prior reports. Ask it to perform one review
cycle and return the report defined by the guide.

The coordinator adjudicates every finding against the settled product decisions.
Reject invalid findings with a reason. For each accepted finding, apply the
smallest correction, review the complete list again, and give the changed list
to another fresh blind reviewer. Do not resample an unchanged list.

Repeat until a reviewer reports no findings or the coordinator rejects every
finding with a reason. Ask the human owner only when a finding requires an
unresolved product decision. Lock the requirements when no valid unresolved
finding remains. Keep review reports with the task, issue, or pull request rather
than version-controlling them.

## Generate `SKILL.md`

Generate `skills/<skill-name>/SKILL.md` from the locked requirements. The
requirements are the only behavioral authority; do not carry forward behavior
merely because an older `SKILL.md`, test, document, or history contains it.
`SKILL.md` may reproduce the requirements directly or present them differently.

There are no general authoring-style requirements for `SKILL.md`. Human
readability, formatting preferences, instruction footprint, and numeric quality
scores are outside the acceptance gate. Do not intentionally make the file hard
for humans to read, but optimize only for accurate AI understanding.

Change the `SKILL.md` body without changing the requirements only when
reconstruction review shows that the current presentation is lossy or
ambiguous.

## Review `SKILL.md`

Use one fresh subagent that did not participate in requirements review. Give it only the verbatim current
contents of the complete `SKILL.md`, not a path, summary, or earlier snapshot,
and instructions to rebuild the behavioral requirements from its body. It must
have no chat history and must not use tools, inspect other files, see the
authoritative requirements, or see prior reports or comparison results.

Ask it to return the complete reconstructed requirements in any clear structure
and identify any materially different readings it cannot resolve. Do not treat
frontmatter as a behavioral requirement.

The coordinator compares the rebuilt list with the authoritative requirements
in both directions:

- every authoritative requirement must be present in the rebuilt list;
- every rebuilt requirement must be authorized by the authoritative list; and
- conditions, boundaries, exceptions, permissions, requirements, and
  prohibitions must have identical meaning.

Wording, numbering, and grouping may differ. The lists match only when either
could replace the other without changing the skill's behavior.

If they do not match, rewrite only the `SKILL.md` body and review the changed
file with another fresh blind reader. Do not change the requirements merely to
make the presentation pass, and do not resample an unchanged `SKILL.md`. If
product behavior must change, return to the requirements process first.

## Review platform metadata

After the `SKILL.md` body passes reconstruction review, ensure its frontmatter
accurately describes what the skill does and when it applies. Ensure
`agents/openai.yaml` still matches the skill, keep `default_prompt` to a minimal
invocation rather than a copy of the instructions, and set
`allow_implicit_invocation` intentionally.

## Finish the change

Do not invoke the skill or test whether an AI agent can carry out clear instructions.
Execution mistakes by an AI agent or an available tool are outside skill-authoring
scope. Runtime scenarios, human-readability scoring, and review matrices are not
part of this process. A lightweight behavioral smoke check (running the skill
against a real repo and tickets) is not part of this gate, but may surface
coordination bugs earlier than production does.

After the rebuilt and authoritative requirements match and platform metadata is
current, run `make validate`. Version-control both the requirements and Source skill,
including metadata changes. Do not finish while their behavior differs.

After the change is committed and pushed to `main`, run `make install` separately
from a clean local `main`.
