---
name: plain
description: Make Codex-authored chat prose concrete, claim-first, structured, and easy to follow without changing the task or a paired skill's workflow. Use only when the user explicitly invokes $plain, alone or with another skill, for final answers and intermediate commentary.
---

# Plain

Apply only to Codex-authored chat in this invocation: final answers and
commentary such as explanations, findings, recommendations, questions, approval
prompts, and progress. Classify text by its destination.

## Boundaries

- Never rewrite any publication-bound artifact, including a provisional draft
  shown in chat. Issues, comments, specifications, documentation, and similar
  output are examples; each keeps its owning format. Apply Plain to the
  surrounding chat.
- Never alter source code, identifiers, commands, configuration, quotes, logs,
  external text, or machine-readable output.
- Change presentation only; preserve facts, meaning, qualifications, precision,
  and evidence.
- A paired skill owns investigation, verification, decisions, actions, workflow,
  questions and their count, stopping points, and output structure. Preserve its
  exact headings, sections, artifacts, and machine-readable formats; improve only
  permitted chat prose. Its structure rules take precedence; apply Plain's
  structure rules only where the paired skill leaves structure to Plain.

## Chat shape

- In Plain-owned substantive prose, lead with the strongest honest result, open
  decision, or conclusion rather than process or skill narration. Name its
  subject and develop claim → explanation → nearby support → consequence when
  useful.
- Keep bare acknowledgements and short factual progress updates concrete and
  unheaded. When Plain owns a substantive response's structure, start at H3 with
  an opening heading that states the main claim. Prefer it to `Overview`,
  `Details`, or `Update`.
- A supporting claim is a proposition that advances the main assertion and can
  stand on its own. Give every such claim its own H4 section, never a list or
  combined paragraph; requested independent reasons always qualify. When a
  substantive response contains only the point stated by its opening H3, do not
  add an H4 that repeats that role; this exception never covers a distinct
  supporting claim.
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
- Put separate items at the same semantic level in an unordered list unless they
  are supporting claims, which follow the H4 rule above; keep incidental short
  enumerations in connected prose. Put meaningful sequences or ranks in an
  ordered list, and use task lists only for real completion criteria or status.
- Put every compact comparison across common dimensions, compact mapping between
  repeated keys and values, or compact record set sharing the same fields in a
  table; never put an extended or continuous explanation in one.
- Render a substantial exact quotation presented as a separate item in a
  blockquote. Copy every character, including quotation marks; do not substitute
  a speaker label, decorate other text, or make summaries look quoted.
- Use bold only for a label and code formatting only for material when the task or
  owning format establishes a semantic role for that styling. Emoji are optional
  semantic signposts only when they speed recognition: pair them with words, use
  them consistently, retain normal list markers, and never impose a palette or
  decorate every item, heading, section, or cell. Prefer none when emoji or
  special formatting would add noise.

## Present Available task evidence beside claims

The task or owning skill gathers evidence for its conclusions. For every
project-specific claim, Plain presents supporting Available task evidence beside
it or uses the unverified fallback below; the specialized rules below refine,
rather than limit, that general rule. Available task evidence includes material
the task or owning skill has already established in current-context chat, tool
results, or inspected files. Plain's role is presentation only; it never
initiates or expands investigation. The task or owning skill may investigate as
its own needs require.

- Name the actual subject instead of relying on vague references such as “this
  suite,” “the layer,” or “it.”
- For a test, search, command, or runtime claim that source lines cannot prove,
  put the exact command and its observed result beside the claim in the same
  Plain-controlled chat message when Available task evidence supplies both. Tool
  events alone do not count as presented evidence. If the exact command or result
  is unavailable, mark the claim unverified and identify what is missing.
- Give precise nearby Available task evidence for every real repository location,
  such as a path, line, or symbol, whether it is named incidentally or relied upon
  materially to establish a claim. If the evidence is unavailable, apply the
  unverified-claim rule below. Do not substitute broad or decorative links, or an
  unmapped link list.
- Each precise link may cover only one continuous relevant span in one file. Link
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
- For proposed changes, link every existing modification point known from
  Available task evidence, label new locations as new, and label uninvestigated
  scope as tentative.
- When required evidence is unavailable, mark the project-specific claim as
  unverified and identify the missing evidence instead of presenting it as
  proven.
- Exempt a large repetitive set from individual links only when a complete link
  list would dominate the answer and the set is mechanically reproducible. Use
  judgment rather than a fixed count. Link the set itself at its relevant symbol
  or starting point, separately from member links; state the count and give the
  exact, reproducible editor operation, search, or command that another reader
  can follow to reproduce the set.
- Even under that exception, link every member discussed, compared, or used to
  justify a conclusion individually.

## Examples

Use an example only when context is otherwise missing. Prefer a real example
from the current situation, then a short labelled hypothetical, then an analogy
only if direct explanation still fails. Examples explain; they never prove a
factual claim.
