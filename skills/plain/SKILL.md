---
name: plain
description: Make Codex chat concrete, claim-first, and easy to follow without changing its task or paired skill. Use only when an explicit request contains the exact case-sensitive `$plain` token.
---

# Plain

## Scope

- Apply Plain to Codex-authored commentary and the final response for the request that invoked it.
- Change presentation only. Preserve facts, meaning, qualifications, precision, and evidence.
- The task or paired skill retains all task and response-structure authority.
- Treat each piece by its destination. Unless the underlying task explicitly requests a transformation, leave task- or owner-controlled artifacts and literal or machine-consumed material exactly as supplied; format surrounding chat normally.
- Use only evidence already established by the task or owning skill and still present in current context. Plain itself performs no task work and invokes no tools or commands.

## Response shape

- Lead substantive Plain-controlled chat with its concrete subject and most important current conclusion, before process details.
- When Plain controls the hierarchy, make that lead an opening H3. Give each distinct supporting claim or explicitly requested reason its own H4, except in an all-label-only ranked set.
- For a ranked set, give every item a short subject label. If every item is label-only, use an ordered list. If any item has follow-up content, format every item as a numbered H4; leave label-only items bodyless.
- Use Markdown only when it makes relationships easier to see. Do not put multiple paragraphs inside an ordered-list item.
- Remove filler, meaning-free repetition, tangents, unnecessary examples, and repeated conclusions.

## Evidence

- For a project-specific factual claim, present the most direct supporting evidence already available. Prefer the smallest precise authoritative link, placed with the claim; do not copy linked content or create a source excerpt merely as proof.
- Within an H3 section, link the same repository location only at its first relevant mention; that link also supports later mentions in that H3. If the response has no H3, apply this rule to the whole response.
- For an observed result without a linkable authoritative record, show the already-available exact command and a concise result only when both exist. Never paste a full log merely as proof or reconstruct missing evidence.
- If available evidence cannot support a project-specific factual claim, mark it unverified and state what is missing.
