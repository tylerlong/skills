# Plain contract specification

This wording-independent contract is the sole authority for behavior required
of the `plain` Source skill. Direct review compares the exact complete
`SKILL.md` with every obligation below; it does not invoke Plain or claim
runtime compliance.

Identifiers, headings, order, and obligation count are navigational only. No
omitted legacy rule survives implicitly, and silence about a presentation form
neither requires nor forbids it.

## Applicability and authority

- **PLN-01 — Trigger.** Plain applies only when an explicit request contains
  the exact case-sensitive token `$plain`.
- **PLN-02 — Invocation scope.** Plain covers Codex-authored commentary and
  the final response belonging to the request that activated it.
- **PLN-03 — Presentation fidelity.** Plain changes presentation only and
  preserves facts, meaning, qualifications, precision, and evidentiary basis.
- **PLN-04 — Owning authority.** The underlying task or paired skill retains
  authority over both the work and the response structure.
- **PLN-05 — Destination.** Treatment follows where a piece of content is
  destined, rather than how it happens to appear in chat.
- **PLN-06 — Protected content.** Unless the underlying task explicitly asks
  for a transformation, task- or owner-controlled artifacts and literal or
  machine-consumed material remain exactly as supplied; eligible surrounding
  chat remains subject to Plain.
- **PLN-07 — Available evidence.** Plain may use only evidence already
  established by the task or owning skill and still present in current context.
- **PLN-08 — No task work.** Plain performs no task work and invokes no tool
  or command.

## Response organization

- **PLN-09 — Lead.** Substantive Plain-controlled chat begins with its
  concrete subject and most important current conclusion before process detail.
- **PLN-10 — Primary hierarchy.** When Plain controls the hierarchy, that
  lead is an opening H3.
- **PLN-11 — Supporting hierarchy.** Each distinct supporting claim or
  explicitly requested reason receives its own H4, except in a ranked set whose
  items are all labels without follow-up content.
- **PLN-12 — Ranked sets.** Every ranked item has a short subject label. Use
  an ordered list when all items are label-only. If any item has follow-up
  content, format every item as a numbered H4; label-only items remain bodyless.
- **PLN-13 — Useful markup.** Use Markdown only when it makes relationships
  easier to understand.
- **PLN-14 — Ordered-list paragraphs.** Do not place multiple paragraphs in
  one ordered-list item.
- **PLN-15 — Concision.** Remove filler, meaning-free repetition, tangents,
  unnecessary examples, and conclusions already stated.

## Evidence presentation

- **PLN-16 — Direct support.** Give a project-specific factual claim the most
  direct support already available, preferring the smallest precise
  authoritative link and placing it with the claim.
- **PLN-17 — Link instead of copied proof.** Do not duplicate linked content
  or manufacture a source excerpt solely to prove the linked claim.
- **PLN-18 — Link reuse.** Within an H3 section, link the same repository
  location only at its first relevant mention; that link supports later mentions
  in the section. If the response has no H3, the whole response is one such
  scope.
- **PLN-19 — Unlinked observed results.** When an observed result has no
  linkable authoritative record, show the exact command and a concise result
  only if both are already available. Do not paste a full log as proof or
  reconstruct missing evidence.
- **PLN-20 — Unsupported claims.** Mark an unsupported project-specific
  factual claim unverified and state what evidence is missing.
