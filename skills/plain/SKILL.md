---
name: plain
description: Make Codex-authored chat prose concrete, claim-first, structured, and easy to follow without changing the task or a paired skill's workflow. Use only when the user explicitly names $plain, alone or with another skill, for final answers and intermediate commentary.
---

# Plain

## 1. Establish scope and ownership

Plain activates only when the user's request literally names `$plain`. One Plain
invocation comprises that request, all Codex-authored commentary while answering
it—including explanations, findings, recommendations, questions, approval
prompts, and progress—and the final response that answers it. Plain's influence
ends with that final response. Classify each piece of output by its intended
destination before applying Plain.

- Plain changes eligible chat presentation only. Later rules may add navigation,
  a brief definition, visible evidence, or an unverified-status label, but never
  authorize changing or inventing a factual assertion or intended meaning,
  dropping a caveat or condition, changing its level of exactness or evidentiary
  basis, or altering the task.
- A publication-bound artifact is identified by its intended destination, not by
  visual structure or by appearing in chat. Never rewrite its wording, even in a
  provisional draft shown in chat, and preserve its owner-defined format. Issues,
  comments, specifications, documentation, and comparable output are protected;
  surrounding Codex-authored chat remains eligible for Plain.
- Never alter source code, identifiers, commands, configuration, quotations,
  logs, text originating outside Codex, or machine-consumed output.
- Determine structure ownership before applying any rule below. Structure
  explicitly required by the user remains part of the task. A paired skill owns
  investigation, verification, decisions, actions, workflow, questions and their
  count, stopping points, and response structure. Every paired-skill structure
  rule wins, including a required wrapper or a conflict with Plain's headings,
  lists, tables, or evidence placement. Preserve its exact heading text and
  levels, section set and arrangement, required artifacts, and machine-consumed
  formats. Plain controls only otherwise-unassigned chat structure.

## 2. Shape Plain-owned chat

Keep a bare acknowledgement concrete about what it acknowledges, and keep a
short factual progress update concrete about its facts. Leave either unheaded.
For substantive prose whose structure Plain owns, apply this order:

1. Make the response's first content an H3 stating its primary assertion. Lead
   with the most important truthful current outcome, unresolved choice, or
   conclusion before process or skill activity, and name its subject. Prefer
   this to a content-free heading such as `Overview`, `Details`, or `Update`.
2. When it helps understanding, move from the assertion through its rationale,
   nearby support, and practical consequence.
3. A supporting claim independently advances the main assertion and can stand on
   its own. Evidence, qualification, explanation, transition, or status data
   remains body under its claim unless it meets both tests. Give every supporting
   claim its own H4 section and never merge it into another proposition's
   paragraph; distinct reasons requested by the user always qualify. Do not put a
   supporting claim in a list except in an all-label-only ranked set. If the
   response has only the opening H3's point, do not add an H4 that restates that
   role; this exception never covers a distinct supporting claim.
4. For a ranked set, each item has a label and may have a body. Its label is only
   its subject noun or short phrase. Any explanatory wording, follow-up
   reasoning, evidence, qualification, example, quotation, code block, nested
   list, or another associated paragraph is body. If every item is label-only,
   use an ordered list. If any item has a body, use a numbered H4 for every item
   and begin each heading's text with its literal rank number, such as
   `1. Label`. A label-only item in a mixed set may remain a bodyless H4; never
   invent body content. Never put multiple body paragraphs inside an ordered-list
   item.
5. A section is the content governed by one heading. The first sentence after
   every heading advances rather than repeats it. Every later Plain-owned
   section, including a utility section, opens with a concrete assertion stating
   what that section establishes.

Prefer familiar, concrete words and briefly define an unavoidable unfamiliar
term. Do not change abstraction or verbosity merely because you infer expertise.
Remove filler, meaning-free repetition, tangents, needless examples, and a
conclusion that only repeats an earlier one, while retaining the context,
reasoning, evidence, qualifications, and transitions needed to follow the
answer. Plain may add an introduction, summary, or concluding section only when
it materially helps navigation in a longer answer.

## 3. Choose semantic Markdown

- Use no more structural markup than needed to reveal relationships. Keep
  reasoning whose parts depend on one another in continuous paragraph prose.
  Never impose a numerical quota or threshold, including counts of items, words,
  sentences, paragraphs, headings, or formatting devices, and never format merely
  for visual variety.
- Put separate items at the same semantic level in an unordered list; keep a
  brief enumeration incidental to a larger thought in prose. Put steps with a
  meaningful execution or reading order in an ordered list. Do not use task-list
  checkboxes unless they represent real completion criteria or real status.
  Apply the supporting-claim and ranked-set rules above before these general list
  rules.
- Put every compact comparison across common dimensions, compact mapping between
  repeated keys and values, or compact record set sharing the same fields in a
  table. Never put an extended or continuous explanation in one.
- Render a sizeable verbatim quotation that stands as its own item as a
  blockquote. Preserve its full character sequence, including quotation marks;
  never replace wording with a speaker label, decorate non-quoted text as a
  quotation, or present a Codex-authored paraphrase or summary as external quoted
  wording.
- Use bold only for a label whose role gives that styling semantic purpose, and
  code formatting only for material whose role does the same. Emoji may be added
  as semantic cues only when they speed recognition: pair each with a textual
  label, keep repeated cues consistent, and retain normal list markers. Never
  require a predetermined emoji set or apply emoji or other special styling
  indiscriminately across items, headings, sections, or cells. Prefer to omit
  emoji and special styling whenever they add noise.

## 4. Present evidence in stages

The structure-ownership rule above still controls evidence placement.

### Stage 1: classify the claim and available evidence

A project-specific claim is a factual assertion about a particular project or
repository state. Factual negative and historical assertions qualify. A proposal
qualifies only where it asserts current project state. Name the concrete subject
instead of relying on a vague reference such as “this suite,” “the layer,” or
“it.”

The task or owning skill decides whether evidence is established; mere presence
in context does not establish it. Available task evidence is material the owner
already established and that remains in the model's current context, including
chat, tool results, or inspected files. That context may extend beyond the
narrower Plain invocation. Plain selects relevant Available task evidence and
makes it visible. The task or owning skill performs any evidence acquisition
needed for its conclusion and may investigate for its own needs; Plain never
initiates or widens investigation.

Beside every project-specific claim, present supporting Available task evidence
or mark the claim unverified and identify the missing evidence. Apply every
specialized rule below that fits; those rules refine this general rule.

### Stage 2: handle execution claims

For a test, search, command, or runtime assertion that source lines cannot prove,
show the exact command and its observed result beside the assertion in the same
Plain-controlled message when both are Available task evidence. The result may
be a concise faithful outcome rather than the complete raw output. A tool event
alone is not evidence presented to the reader. If the exact command or result is
unavailable, the unverified label and missing-evidence disclosure are mandatory
even when different evidence supports the assertion.

### Stage 3: attach repository evidence and links

For every real repository location—a path, line, or symbol—that is named or used
materially, put specific Available task evidence next to the claim. Merely naming
the location is not evidence. If evidence is unavailable, use the general
unverified fallback. Do not substitute an imprecise, ornamental, detached, or
unmapped collection of links.

A path or line mentioned only as a location needs specific evidence but is not,
for that reason alone, required to be a link. A precise link is mandatory for
these cases:

- Support a code assertion with the exact relevant source lines.
- Link a real repository symbol at its first material use in each section; do not
  relink later mentions of the same location in that section.
- Give a snippet copied from the repository a nearby link to its precise origin.
  Label a not-yet-existing snippet `proposed` and an explanation-only invention
  `hypothetical`; either correctly labelled form may omit a source link.
- Link every entity needed to prove a multi-part relationship, flow, comparison,
  or proposal. Each entity needs participant-specific evidence. One link jointly
  attached to co-located participants may prove each when its single source span
  directly establishes each participant; otherwise one participant's evidence
  never proves another.

Each evidence link covers no more than one contiguous relevant region of one
file. Target its first relevant line or, when supported, a narrowly bounded
range. Use separate links for non-adjacent regions or different files. Stop an
implementation trace once the cited material directly establishes the assertion;
do not add unrelated downstream calls. For GitHub assertions, cite the exact
Issue, comment, commit, check, or native relationship; for documentation
assertions, cite the relevant section.

### Stage 4: handle proposals and repetitive sets

For a proposed change, link every existing location already known from Available
task evidence to require that change. Mark a location that would be created as
`new`, and mark uninvestigated scope as tentative.

Individual links for a repetitive collection may be omitted only when the
collection is mechanically reproducible and a complete member-link list would
overwhelm the answer. Decide by judgment, never a numeric cutoff. When using this
exception, link the collection's defining symbol or starting location separately
from member links, state its member count, and give the exact editor operation,
search, or command that reproduces it. Even then, individually link every member
discussed, compared, or used to support a conclusion.

## Examples

An example may be used only when context is otherwise missing. Prefer a real
example from the current situation. If no suitable real instance exists, prefer
a short labelled hypothetical. An analogy may be used only after direct
explanation and a real or hypothetical example remain insufficient. Examples
explain; they never prove a factual assertion.
