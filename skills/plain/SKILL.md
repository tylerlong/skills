---
name: plain
description: Make Codex chat concrete, claim-first, and easy to follow without changing its task or paired skill. Use only when a request contains exact case-sensitive $plain.
---

# Plain

Activate only when an explicit user request contains the exact case-sensitive
token `$plain`. One invocation includes all Codex-authored commentary answering
it—explanations, findings, recommendations, questions, approval prompts, and
progress—and its final response, then ends. An output piece is the smallest chat
or embedded-artifact segment sharing one intended destination.

## Boundaries

- Plain edits presentation only; never change the task, facts, meaning, caveats,
  conditions, exactness, or evidentiary basis.
- Treat each piece by intended destination, never appearance. Keep every
  publication-bound artifact's wording and owner format unchanged, including
  provisional drafts, Issues, comments, specifications, documentation, and
  comparable output. Likewise keep source code, identifiers, commands,
  configuration, quotations, logs, text originating outside Codex, and
  machine-consumed output unchanged. Surrounding Codex chat is eligible. This
  binds Plain, not an explicit task-owned transformation.
- The task or owner resolves conflicts; user requirements stay task-owned. With
  a paired skill, it retains investigation, verification, decisions, actions,
  workflow, stopping points, question content and count, and response structure.
  Its wrappers and evidence placement prevail. Preserve its exact heading text
  and levels, section set and arrangement, required artifacts, and
  machine-consumed formats. Plain owns only unassigned chat presentation.

## Chat shape

Keep a bare acknowledgement concrete and unheaded about what it acknowledges;
keep a brief factual progress message concrete and unheaded about its facts.

Plain-controlled substantive prose starts with its explicit subject and most
important truthful current outcome, unresolved choice, or conclusion, before
process or skill activity. When helpful: assertion → rationale → adjacent
support → practical consequence.

If Plain controls a substantive response's hierarchy, the response's literal
first content is an H3 stating its primary assertion; later portions get no new
opening-H3 requirement. Prefer this to a content-free `Overview`, `Details`, or
`Update`.

Each supporting claim—a stand-alone proposition advancing the primary
assertion—gets a separate H4, never a list entry or part of another claim's
paragraph, except in the all-label-only ranked set below. Each distinct reason
the user explicitly requests counts automatically, with only that exception.
Evidence, qualification, explanation, transition, and status stay body unless
they meet both tests. If the H3 holds the only point, do not add an H4 that
repeats its role.

A set is ranked only when order expresses relative priority. Each item has a
label—its subject noun or short phrase—and may have a body. Body includes
follow-up explanation, reasoning, evidence, qualification, example, quotation,
code block, nested list, or another associated paragraph. Use an ordered list
when every item is label-only. If any has body, make every item a numbered H4
starting with its literal rank, such as `1. Label`; a label-only item may stay
bodyless.
Never invent body or put multiple body paragraphs in an ordered-list item.

Otherwise, use an unordered list for separate same-level items and prose for an
incidental brief enumeration. Use an ordered list for meaningful execution or
reading order; use task-list checkboxes only for real completion criteria or
status.

Except for a permitted bodyless ranked H4, when the first content after any
Plain-owned heading is prose, its first sentence advances rather than repeats
the heading. Each later Plain-owned section puts its assertion first; a table,
list, quotation, or code block may come first when it presents that assertion.

Prefer familiar, concrete words; briefly define an unavoidable unfamiliar term.
Never change abstraction or length merely from inferred expertise. Delete
filler, meaning-free repetition, tangents, needless examples, and repeated
conclusions; retain needed context, reasoning, evidence, qualifications, and
transitions. Add an introduction, summary, or concluding section only when it
materially helps navigate a longer answer.

## Semantic Markdown

- Use only markup needed to reveal relationships; keep interdependent reasoning
  in continuous prose. Never format merely for variety.
- Never impose numerical presentation quotas or thresholds, including counts of
  items, words, sentences, paragraphs, headings, or formatting devices.
  Content-required ranks and evidence counts are not quotas.
- Use a table for every compact common-dimension comparison, repeated key-value
  mapping, or same-field record set; exclude extended or continuous explanation.
- Blockquote a sizeable standalone verbatim quotation. Markers are presentation,
  not source characters; preserve its full sequence, including quotation marks.
  Never replace wording with a speaker label, apply quotation styling to
  non-quoted text, or present a Codex paraphrase or summary as external quoted
  wording.
- Bold only a label whose role gives the styling semantic purpose; code-style
  only material whose role does likewise. No explicit task or owner declaration
  is required. Emoji may cue semantics only when they speed recognition: pair
  them with text, keep repeated meanings consistent, and retain list markers.
  Never require fixed emoji or apply emoji or special styling indiscriminately
  across items, headings, sections, or cells. Prefer no emoji or special styling
  when either adds noise.

## Present Available task evidence beside claims

Evidence presentation applies only to Plain-controlled Codex-authored claims
outside protected material; never insert it into or rewrite protected material.
The task or other owning skill establishes and acquires evidence; context
presence alone does not. Available task evidence is owner-established chat,
tool results, or inspected files still in current context, even from before this
invocation. Plain selects relevant evidence and makes it visible within owner
structure; it never investigates or widens investigation.

A project-specific claim means a factual assertion about a particular project
or repository state; negative and historical facts qualify. In a proposal, only
each factual current-state assertion qualifies, not its prescriptive remainder.
Name the concrete subject, not `this suite`, `the layer`, or `it`. Put supporting
Available task evidence beside each claim; otherwise mark it unverified and name
the missing evidence.

If Source lines cannot prove a test, search, command, or runtime assertion but
Available task evidence proves that same assertion, reproduce beside it, in the
same Plain-controlled message, the complete exact command text already present
anywhere in that evidence and its observed result. Never reconstruct an
equivalent. The result may be a concise faithful outcome; a tool event outside
the response is no substitute. If the complete command or result is unavailable,
mark that assertion unverified and name what is missing, even when other evidence
supports it.

Every real repository path, line, or symbol named or materially used in a
Plain-controlled claim—even incidentally—gets specific Available task evidence
beside it or the unverified fallback. Naming a location is not evidence. A
location-only path or line needs evidence, but no link solely for that reason.
Never substitute an imprecise, ornamental, detached, or unmapped link collection.

- For code, cite exact relevant Source lines; for GitHub, the exact Issue,
  comment, commit, check, or native relationship; for documentation, the
  relevant section.
- Each evidence link covers at most one contiguous relevant region in one file.
  Target its first relevant line or a supported tight range. Link non-adjacent
  regions and different files separately.
- Give each entity needed to prove a relationship, flow, comparison, or proposal
  its own specific link. One joint link may serve co-located entities only when
  its span proves each; one entity's evidence never proves another. Stop an
  implementation trace at direct proof; omit unrelated downstream calls.
- Link a real repository symbol at its first material use as evidence in each
  heading-bounded section. Never link that repository location again in the
  section, regardless of URL rendering. Later claims still need adjacent
  evidence without another same-location link.
- Link a copied repository snippet near its precise origin. Label one not yet
  existing `proposed` and one invented only to explain `hypothetical`; either
  correctly labelled form may omit a source link.
- For a proposal, link each existing location that Available task evidence
  establishes as a necessary edit. Mark a to-be-created location `new` and
  uninvestigated scope tentative; claim no completeness beyond Available task
  evidence.
- Omit repetitive-set member links only when the set is mechanically reproducible
  and a complete list would overwhelm the answer, judged without a numeric
  cutoff. Link its defining symbol or start separately from member evidence,
  state the member count, and give the exact editor operation, search, or command
  that reproduces it. Still link every member discussed, compared, or used to
  support a conclusion.

## Examples

Use an example only when context would otherwise be insufficient. Prefer a real
current instance, then a short labelled hypothetical if none is suitable. Use
an analogy only when direct explanation and a real or hypothetical example
remain insufficient. Examples explain; they never prove a factual assertion.
