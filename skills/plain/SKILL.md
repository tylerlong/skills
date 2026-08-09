---
name: plain
description: Make Codex-authored chat prose concrete, claim-first, structured, and easy to follow without changing the task or a paired skill's workflow. Use only when the user explicitly invokes $plain, alone or with another skill, for final answers and intermediate commentary.
---

# Plain

Improve only Codex-authored conversational prose in the current invocation:
final answers and intermediate commentary. Classify text by its intended
destination, not merely by whether it appears in the conversation.

## Keep publishable artifacts outside the skill

- Apply these rules to chat explanations, findings, recommendations, questions,
  approval prompts, and progress reports.
- Do not apply them to GitHub Issue bodies or comments, specifications,
  documentation, or other publishable artifacts, including drafts previewed in
  chat. Preserve the artifact's owning workflow and format.
- Apply these rules to chat prose surrounding an excluded artifact.
- Do not rewrite source code, identifiers, commands, configuration, quoted text,
  logs, external source text, or machine-readable output.

## Preserve the task and paired skills

- Change presentation only. Preserve facts, meaning, qualifications, technical
  precision, and required evidence.
- Let a paired skill own investigation, verification, decisions, actions,
  workflow, question count, stopping points, and required output structure.
- When a paired skill requires exact headings, sections, or a machine-readable
  format, preserve that structure and improve only the prose within it.

## Write for three priorities

1. **Visible main claim:** Make the strongest honest conclusion, open decision,
   or current result easy to find.
2. **Concrete content:** Name the actual subject and place precise evidence beside
   project-specific factual claims.
3. **Easy-to-follow reasoning:** Use familiar language and develop each point from
   claim to explanation and support.

## Make substantive chat claim-first

- Leave a bare acknowledgement or short progress update unheaded while keeping
  it concrete and readable.
- When `$plain` controls a substantive response's structure, begin with one H3
  heading that states its strongest honest claim, unresolved decision, or current
  result.
- When a response has multiple independently meaningful supporting claims, give
  each its own H4 heading. Create sections from distinct ideas, not word count,
  and do not add one redundant H4 beneath a single-point H3.
- Prefer a meaningful claim, decision, or result over generic headings such as
  `Overview`, `Details`, or `Update`.
- Make the first sentence expand or sharpen the heading instead of repeating it.
  Begin every later section with that section's main claim.

## Choose presentation by meaning

- Prefer the smallest Markdown structure that makes the content's relationship
  faster to recognize. Keep connected reasoning in paragraphs when dividing it
  would interrupt the argument; do not force formatting for visual variety or
  to meet quotas, fixed thresholds, or item counts.
- Use unordered lists for peer items and ordered lists only when order, rank,
  chronology, or priority carries meaning. Use task lists only for genuine
  completion criteria or status.
- Use tables for concise comparisons, mappings, or repeated fields across shared
  dimensions. Keep long or connected explanations out of table cells.
- Render substantial exact user or external wording as a blockquote when visual
  separation helps, without changing it. Do not use blockquotes as decorative
  callouts or make Codex-authored summaries look quoted.
- Use concise bold labels and inline or fenced code when their established
  meanings clarify distinctions or literal material.
- Use familiar emoji as optional semantic signposts for recognizable statuses or
  categories when they speed recognition. Pair each emoji with words, keep its
  meaning consistent within the response, and retain ordinary Markdown list
  markers around emoji-enhanced list items.
- Do not prescribe a mandatory emoji palette or add emoji to every item, heading,
  section, or table cell. Prefer no emoji or special formatting when it would add
  noise.

## Explain in a natural order

- Lead with the claim, then give its explanation, nearby evidence or an example
  when needed, and a recommendation or consequence when useful.
- Prefer familiar, concrete words. Define an unavoidable unfamiliar term briefly
  on first use. Do not vary abstraction or verbosity according to inferred
  expertise.
- Treat brevity as an anti-waste guardrail, not the goal. Remove filler,
  repetition, irrelevant tangents, unnecessary examples, and redundant
  conclusions without removing useful context, reasoning, evidence,
  qualifications, or transitions.
- Do not impose a sentence, paragraph, or word count. Use introductions,
  conclusions, and summaries only when they help navigate a longer response.

## Ground project facts beside their claims

- Name the actual subject instead of relying on vague references such as “this
  suite,” “the layer,” or “it.”
- Give precise nearby evidence for every real project location explicitly
  mentioned or materially relied upon to establish a claim. Do not substitute
  broad or decorative links, or an unmapped link list.
- Use one precise link for one continuous relevant span in the same file. Link
  its beginning, or a tight range when the link form supports ranges. Link
  non-adjacent locations and locations in different files separately.
- Link every material participant needed to establish a relationship, action
  flow, comparison, or proposed change. Follow implementation only until the
  evidence directly proves the claim; do not recursively link unrelated
  downstream calls.
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
- For test, search, command, or runtime claims that source lines cannot prove,
  give the relevant command and result.
- When required evidence is unavailable, mark the project-specific claim as
  unverified and identify the missing evidence instead of presenting it as
  proven.
- Exempt a large repetitive set from individual links only when a complete link
  list would dominate the answer and the set is mechanically reproducible. Use
  judgment rather than a fixed count. Link the relevant symbol or starting
  point, state the count, and give the exact editor operation, search, or command
  that reproduces the set.
- Even under that exception, link every member discussed, compared, or used to
  justify a conclusion individually.

## Use examples only when they add context

When an explanation would otherwise lack context, prefer:

1. a real example from the current code, Issue, document, or situation;
2. a short example labelled as hypothetical when no real example is available;
3. an analogy only when direct explanation and the first two options remain
   insufficient.

Do not force an example when the explanation is already clear. Use examples to
explain, never to prove a factual claim.
