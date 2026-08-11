---
name: plain
description: Make Codex-authored chat prose concrete, claim-first, structured, and easy to follow without changing the task or a paired skill's workflow. Use only when the user explicitly invokes $plain, alone or with another skill, for final answers and intermediate commentary.
---

# Plain

Apply only to Codex-authored chat in this invocation: final answers and
commentary such as explanations, findings, recommendations, questions, approval
prompts, and progress. Classify text by its destination.

## Boundaries

- Never rewrite publishable artifacts, even drafts shown in chat: Issues,
  comments, specifications, documentation, and similar output keep their owning
  format. Apply Plain to the surrounding chat.
- Never alter source code, identifiers, commands, configuration, quotes, logs,
  external text, or machine-readable output.
- Change presentation only; preserve facts, meaning, qualifications, precision,
  and evidence.
- A paired skill owns investigation, verification, decisions, actions, workflow,
  questions and their count, stopping points, and output structure. Preserve its
  exact headings, sections, artifacts, and machine-readable formats; improve only
  permitted chat prose.

## Chat shape

- In Plain-owned substantive prose, lead with the strongest honest result, open
  decision, or conclusion rather than process or skill narration. Name its
  subject and develop claim → explanation → nearby support → consequence when
  useful.
- Keep bare acknowledgements and short factual progress updates concrete and
  unheaded. When Plain owns a substantive response's structure, start with one H3
  that states the main claim. Prefer it to `Overview`, `Details`, or `Update`.
- Give every independently meaningful supporting claim its own H4 section, never
  a list or combined paragraph; requested independent reasons always qualify. Do
  not add a redundant H4 for a single point.
- The first sentence sharpens its heading rather than repeating it; each later
  section opens with its claim.
- Prefer familiar, concrete words and briefly define an unavoidable unfamiliar
  term. Do not change abstraction or verbosity based on inferred expertise.
- Brevity prevents waste, not useful context. Remove filler, repetition,
  tangents, needless examples, and redundant conclusions, but keep reasoning,
  evidence, qualifications, and transitions. Add introductions, summaries, or
  conclusions only when they help navigate a longer answer.

## Semantic Markdown

- Use the smallest structure that exposes meaning; keep connected reasoning in
  paragraphs. Never impose a quota, threshold, or fixed item, word, sentence, or
  paragraph count; do not format for visual variety.
- Put independently meaningful peer items in an unordered list; keep incidental
  short enumerations in connected prose. Put meaningful sequences or ranks in an
  ordered list, and use task lists only for real completion criteria or status.
- Use tables for concise comparisons, mappings, or repeated fields, never long or
  connected explanations.
- Render a substantial exact quotation presented as a separate item in a
  blockquote. Copy every character, including quotation marks; do not substitute
  a speaker label, decorate other text, or make summaries look quoted.
- Use bold labels and code formatting only for their established meanings. Emoji
  are optional semantic signposts only when they speed recognition: pair them
  with words, use them consistently, retain normal list markers, and never impose
  a palette or decorate every item, heading, section, or cell. Prefer none when
  emoji or special formatting would add noise.

## Present Available task evidence beside claims

The task or owning skill gathers evidence for its conclusions. Plain selects and
presents Available task evidence already established in the current context; it
never initiates or expands investigation solely to improve presentation.

- Name the actual subject instead of relying on vague references such as “this
  suite,” “the layer,” or “it.”
- When Available task evidence supports a test, search, command, or runtime claim
  that source lines cannot prove, put the exact command beside its observed
  result in the same Plain-controlled chat message. Tool events do not count as
  presented evidence.
- Give precise nearby Available task evidence for every real project location
  explicitly mentioned or materially relied upon to establish a claim. If it is
  unavailable, apply the unverified-claim rule below. Do not substitute broad or
  decorative links, or an unmapped link list.
- Use one precise link for one continuous relevant span in the same file. Link
  its beginning, or a tight range when the link form supports ranges. Link
  non-adjacent locations and locations in different files separately.
- Link every material participant needed to establish a relationship, action
  flow, comparison, or proposed change. Give each participant its own precise
  evidence; one participant's link never proves another. Follow implementation
  only until the evidence directly proves the claim; do not recursively link
  unrelated downstream calls.
- Link a real repository symbol at its first meaningful use as evidence in each
  section. Do not relink repeated references to the same location in that
  section.
- Give every real source snippet a nearby link to its exact source. Clearly
  labelled hypothetical or proposed snippets require no source link.
- Use the evidence form appropriate to the project fact: exact relevant lines
  for code; the exact Issue, comment, commit, check, or native relationship for
  GitHub; and the relevant section for documents.
- For proposed changes, link every known existing modification point, label new
  locations as new, and label uninvestigated scope as tentative.
- When required evidence is unavailable, mark the project-specific claim as
  unverified and identify the missing evidence instead of presenting it as
  proven.
- Exempt a large repetitive set from individual links only when a complete link
  list would dominate the answer and the set is mechanically reproducible. Use
  judgment rather than a fixed count. Link the set itself at its relevant symbol
  or starting point, separately from member links; state the count and give the
  exact editor operation, search, or command that reproduces the set.
- Even under that exception, link every member discussed, compared, or used to
  justify a conclusion individually.

## Examples

Use an example only when context is otherwise missing. Prefer a real example
from the current situation, then a short labelled hypothetical, then an analogy
only if direct explanation still fails. Examples explain; they never prove a
factual claim.
