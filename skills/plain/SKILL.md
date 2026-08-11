---
name: plain
description: Make Codex chat concrete, claim-first, structured, and easy to follow without changing the task or a paired skill. Use only for requests containing the exact case-sensitive token $plain.
---

# Plain

## 1. Establish scope and ownership

Activate only for a request containing the exact case-sensitive token `$plain`.
One invocation covers that request, all Codex-authored commentary
answering it—including explanations, findings, recommendations, questions,
approval prompts, and progress—and its final response; it ends with that
response.

An output piece is the smallest chat or embedded-artifact segment with one
intended destination. Plain edits only eligible Codex-authored chat presentation.
Adding navigation, a short definition, visible evidence, or an unverified label
never authorizes altering the task, facts, intended meaning, any caveat or
condition, exactness, or evidentiary basis.

By intended destination—not appearance or chat presence—leave the wording and
owner-defined format of every publication-bound artifact untouched, including a
provisional draft.
Issues, comments, specifications, documentation, and comparable output qualify.
Also leave source code, identifiers, commands, configuration, quotations, logs,
text from outside Codex, and machine-consumed output unchanged. Surrounding
Codex-authored chat remains eligible. These limits bind Plain, not an explicitly
requested transformation owned by the task.

The task or owning skill resolves ownership conflicts, never Plain.
User-required structure remains part of the task. A paired skill retains
investigation, verification, decisions, actions, workflow, stopping points,
questions and their count, and response structure. Its rules—including wrappers
and evidence placement—prevail over Plain. Preserve its exact heading text and
levels, section set and arrangement, required artifacts, and machine-consumed
formats. Plain owns only unassigned chat structure.

## 2. Shape Plain-owned chat

Leave a bare acknowledgement unheaded and concrete about what it acknowledges;
leave a short factual progress update unheaded and concrete about its facts.

Start a Plain-owned substantive portion with an H3 stating its primary assertion.
If Plain owns the response hierarchy, the H3 is literally its first content;
otherwise it follows an owner-required wrapper or protected artifact. It names
the subject and gives the most important truthful current outcome,
unresolved choice, or conclusion before process or skill activity. Prefer it to
a content-free lead such as `Overview`, `Details`, or `Update`. When that order
helps understanding, prefer assertion → rationale → nearby support → practical
consequence.

A supporting claim independently advances the primary assertion and stands on
its own. Each gets an H4 section; distinct requested reasons qualify. Never merge
one into another proposition's paragraph or make it a list entry, except as a
label in an all-label-only ranked set. Evidence, qualification, explanation,
transition, and status remain body unless they meet both tests. If the H3
contains the only point, do not add an H4 that repeats its
role; a distinct claim still gets one.

A set is ranked only when its order expresses relative priority. Each item has a
label—only its subject noun or short phrase—and may have a body. Explanatory
wording, reasoning, evidence, qualification, an example, quotation, code block,
nested list, or another associated paragraph is body. If every item is
label-only, use an ordered list. If any has a body, make every item an H4 whose
text starts with its literal rank number, such as `1. Label`. A label-only item
may remain bodyless in that mixed set; never invent body. No ordered-list item
may contain multiple body paragraphs.

For other content, use an unordered list for separate same-level items but prose
for an incidental brief enumeration. Use an ordered list for steps with
meaningful execution or reading order, and task-list checkboxes only for real
completion criteria or status.

A section is content governed by one heading. A permitted bodyless ranked H4 is
the exception: the first sentence after every other heading advances rather than
repeats it, and every later Plain-owned section—including a utility section—opens
with a concrete section-level assertion.

Prefer familiar, concrete words; briefly define an unavoidable unfamiliar term.
Do not change abstraction or length merely because you infer expertise. Remove
filler, meaning-free repetition, tangents, needless examples, and repeated
conclusions while retaining the needed context, supporting reasoning and
evidence, every qualification, and transitions needed to follow the answer.
Plain may add an introduction, summary, or concluding section only when it
materially helps navigate a longer answer.

## 3. Choose semantic Markdown

- Use only markup needed to reveal relationships; keep interdependent reasoning
  in continuous prose. Never format merely for variety.
- Never impose numerical presentation quotas or thresholds, including counts of
  items, words, sentences, paragraphs, headings, or formatting devices. Literal
  rank numbers, evidence counts, and other content-required numbers are not quotas.
- Use a table for every compact comparison across common dimensions, compact
  repeated key-value mapping, or compact record set with shared fields. Keep
  extended or continuous explanation out of tables.
- Render a sizeable standalone verbatim quotation as a blockquote. Its markers
  are presentation, not source characters. Preserve every quoted source
  character, including quotation marks; never replace wording with a speaker
  label, style non-quoted text as a quotation, or present a Codex paraphrase or
  summary as external quoted wording.
- Use bold only for a label whose role gives it semantic purpose and code styling
  only for material whose role does the same. Emoji may be semantic cues only
  when they speed recognition; pair them with textual labels, give repeated cues
  consistent meanings, and retain list markers. Never require a fixed emoji set
  or apply styling indiscriminately across items, headings, sections, or cells.
  Prefer no emoji or special styling when either adds noise.

## 4. Present evidence in stages

### Stage 1: establish evidence and classify the claim

The task owns evidence unless a separate skill does. The owner decides what is
established and acquires what its conclusion needs; context presence alone is
not enough. Available task evidence is owner-established material still in
current context, including chat, tool results, or inspected files, and may
predate this invocation. Plain neither investigates nor widens investigation for
presentation; within owner-required structure, it selects relevant Available
task evidence and makes it visible.

A project-specific claim is a factual assertion about a particular project or
repository state. Factual negative and historical assertions qualify; a proposal
qualifies only where it asserts current project state. Name its concrete subject,
not `this suite`, `the layer`, or `it`. Beside every such claim, show supporting
Available task evidence or mark it unverified and identify what is missing.

### Stage 2: handle execution claims

If source lines cannot establish a test, search, command, or runtime assertion
and both its exact command and observed result are Available task evidence, show
them beside the assertion in the same Plain-controlled message. Only retained
verbatim command text counts; never reconstruct an equivalent. The result may be
a concise faithful outcome instead of complete raw output. A tool event outside
the response is not presented evidence. If the command or result is unavailable,
mark the assertion unverified and name what is missing even when other evidence
supports it.

### Stage 3: attach repository evidence and links

Every real repository path, line, or symbol mention, even an incidental one,
needs specific Available task evidence beside its claim. Naming a location is
not evidence. If none is available, mark the claim unverified and name what is
missing. Never substitute an imprecise, ornamental, detached, or unmapped link
collection.

- A path or line mentioned only as a location still needs evidence, but no link
  solely for that reason. Cite exact relevant source lines for a code assertion.
- Link a real symbol at its first material mention in each heading-bounded
  section. A later claim about it still needs adjacent evidence but must not
  repeat that link there; use a different relevant span or nearby non-link
  evidence when appropriate.
- Link a copied repository snippet to its nearby precise origin. Label a
  not-yet-existing snippet `proposed` and an explanation-only invention
  `hypothetical`; either labelled form may omit a source link.
- Link every entity needed to prove a multi-part relationship, flow, comparison,
  or proposal, with participant-specific evidence. One jointly attached link may
  prove co-located participants only if one span establishes them all; otherwise
  one participant's evidence never proves another.

Each link covers at most one contiguous relevant region in one file. Target its
first relevant line or a supported narrow range; use separate links for
non-adjacent regions or different files. Stop an implementation trace once the
cited material directly establishes the assertion; never add unrelated
downstream calls. For GitHub, cite the exact Issue, comment, commit, check, or
native relationship. For documentation, cite the relevant section.

### Stage 4: handle proposals and repetitive sets

For a proposed change, link every existing modification point that Available
task evidence shows must be edited, not a location that only proves the need.
Mark a location to be created `new` and uninvestigated scope tentative.

Member links in a repetitive collection may be omitted only when it is
mechanically reproducible and a complete member-link list would overwhelm the
answer. Decide by judgment, never a numeric cutoff. When omitting them, link the
defining symbol or starting location separately from member evidence, state the
member count, and give the exact editor operation, search, or command that
reproduces it. Still link each member discussed, compared, or used to support a
conclusion.

## 5. Use examples only when needed

An example may be used only when context is otherwise insufficient. Prefer a
real current instance, then a short labelled hypothetical if none is suitable.
Use an analogy only if direct explanation and a real or hypothetical example
remain insufficient. Examples explain; they never prove a factual assertion.
