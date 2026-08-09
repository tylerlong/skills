# `plain` behavior catalog

This catalog follows the [shared execution protocol](README.md). The disposable
repository contains the selected Baseline skill or Candidate skill at
`.agents/skills/plain` and, for paired scenarios, the exact fixture at
`.agents/skills/paired-contract`.

Except for PLAIN-01 turn 2, begin every invocation below with this exact selector:
`Use the repository-scoped $plain at .agents/skills/plain/SKILL.md. Read that
complete file before producing any task response.` For PLAIN-03 and PLAIN-04,
append: `Also use the repository-scoped $paired-contract at
.agents/skills/paired-contract/SKILL.md and read it completely before producing
any task response.` The event stream must show those exact staged files being
loaded before observable task output; unavailable, late, or different provenance
is an evaluator failure.

## Contract map

| Rule | Observable contract | Scenarios |
| --- | --- | --- |
| C01 | Explicit invocation affects only Codex-authored chat in that invocation, classified by destination. | PLAIN-01, PLAIN-02 |
| C02 | Chat explanations, findings, recommendations, questions, approval prompts, and progress reports use plain. | PLAIN-01, PLAIN-02, PLAIN-03 |
| C03 | Publishable artifacts, including drafts shown in chat, keep their owning format. | PLAIN-03 |
| C04 | Chat surrounding a protected artifact still follows plain. | PLAIN-03 |
| C05 | Source code, identifiers, commands, configuration, quotes, logs, external text, and machine-readable output are unchanged. | PLAIN-03, PLAIN-04, PLAIN-06 |
| C06 | Presentation changes preserve facts, meaning, qualifications, precision, and evidence. | PLAIN-03, PLAIN-05, PLAIN-07 |
| C07 | A paired skill owns investigation, actions, workflow, decisions, question count, stopping points, and required structure. | PLAIN-03, PLAIN-04 |
| C08 | Exact paired headings, sections, and machine-readable formats survive unchanged; only allowed prose may improve. | PLAIN-03, PLAIN-04 |
| C09 | The strongest honest claim, decision, or current result is immediately visible. | PLAIN-01, PLAIN-05, PLAIN-07 |
| C10 | Content names its subject and places precise evidence beside project claims. | PLAIN-07, PLAIN-08, PLAIN-09 |
| C11 | Reasoning proceeds from claim through explanation and support. | PLAIN-05, PLAIN-07 |
| C12 | Bare acknowledgements and short factual progress updates remain concrete and unheaded. | PLAIN-01 turn 2, PLAIN-02 |
| C13 | A substantive response whose structure plain owns starts with one claim-bearing H3. | PLAIN-01 turn 1, PLAIN-05, PLAIN-07 |
| C14 | Independent supporting claims get H4 sections; a single point gets no redundant H4. | PLAIN-05, PLAIN-09 |
| C15 | Headings state meaningful claims rather than generic labels. | PLAIN-01, PLAIN-05, PLAIN-07 |
| C16 | The first sentence sharpens its heading, and each later section opens with its claim. | PLAIN-05, PLAIN-07 |
| C17 | Markdown is the smallest structure that exposes meaning; connected reasoning stays connected. | PLAIN-05, PLAIN-06, PLAIN-09 |
| C18 | Unordered lists hold peers, ordered lists hold meaningful sequence or rank, and task lists represent genuine status criteria only. | PLAIN-06 |
| C19 | Tables hold concise comparisons or repeated fields, not connected explanations. | PLAIN-06 |
| C20 | Substantial exact external wording may be blockquoted without alteration; Codex summaries are not made to look quoted. | PLAIN-06 |
| C21 | Concise bold labels and code formatting distinguish real labels and literal material. | PLAIN-06 |
| C22 | Emoji appear only as optional, consistently worded semantic signposts with normal Markdown markers. | PLAIN-06 |
| C23 | No mandatory emoji palette or decorative formatting is imposed. | PLAIN-02, PLAIN-05, PLAIN-06 |
| C24 | Explanations use the natural order: claim, explanation, evidence or example, then consequence when useful. | PLAIN-05, PLAIN-07 |
| C25 | Familiar concrete words are preferred, unavoidable terms are briefly defined, and inferred expertise does not change abstraction or verbosity. | PLAIN-05, PLAIN-09 |
| C26 | Filler, repetition, tangents, needless examples, and redundant conclusions are removed without losing useful context or qualifications. | PLAIN-05, PLAIN-09 |
| C27 | No fixed sentence, paragraph, word, heading, item, or formatting quota controls the answer. | PLAIN-02, PLAIN-05, PLAIN-06, PLAIN-09 |
| C28 | Project claims name the actual subject rather than vague substitutes. | PLAIN-07, PLAIN-08, PLAIN-09 |
| C29 | Every relied-on project location has precise adjacent evidence, not a decorative link list. | PLAIN-07, PLAIN-08, PLAIN-09 |
| C30 | One link covers one continuous relevant span; separate or non-adjacent evidence gets separate links. | PLAIN-07, PLAIN-08 |
| C31 | Every material participant in a claimed relationship, flow, comparison, or proposal is linked until the claim is directly proved. | PLAIN-07, PLAIN-09 |
| C32 | A real repository symbol is linked at first meaningful use in each section and not needlessly relinked there. | PLAIN-07 |
| C33 | Every real source snippet has a nearby exact source link; hypothetical or proposed snippets are labelled. | PLAIN-07, PLAIN-09 |
| C34 | Evidence uses exact source lines, native GitHub evidence, document sections, or command results appropriate to the claim. | PLAIN-07, PLAIN-08, PLAIN-09 |
| C35 | Proposals link known modification points and label new or uninvestigated locations honestly. | PLAIN-07 |
| C36 | Search, test, command, and runtime claims cite the command and result when source lines cannot prove them. | PLAIN-07, PLAIN-08 |
| C37 | A claim with unavailable proof is labelled unverified and names the missing evidence. | PLAIN-07 |
| C38 | A mechanically reproducible repetitive set may use a starting link, count, and exact reproducing command instead of links that dominate the answer. | PLAIN-08 |
| C39 | Individually discussed or conclusion-bearing members of an exempt set still receive individual links. | PLAIN-08 |
| C40 | Examples appear only when they add otherwise-missing context. | PLAIN-05, PLAIN-09 |
| C41 | Example escalation prefers real, then labelled hypothetical, then analogy. | PLAIN-09 |
| C42 | Examples explain and never prove factual claims. | PLAIN-07, PLAIN-09 |

## Required scenarios

### PLAIN-01 — Explicit activation and next-turn boundary (2 turns)

**Covers:** C01, C02, C09, C12, C13, C15.

**Setup:** Stage only the selected Baseline or Candidate `plain` skill. Start one
fresh task.

**Turn 1 invocation:**

> Explain why this repository keeps deterministic tests separate
> from Skill behavior tests. Use only README.md and
> docs/adr/0001-characterize-source-skills-before-simplifying.md as project
> evidence. Do not use the network.

**Turn 1 required:** The final begins with exactly one H3 whose text states the
separation claim; the first sentence develops it; every project claim has an
adjacent precise link to the supplied file; the answer does not claim evidence
outside those files.

**Turn 1 forbidden:** A generic `Overview`, `Details`, or `Update` heading; an H1
or H2 added by plain; a link list detached from its claims; invented test results.

**Turn 2 invocation:**

> Reply exactly `ACK` and do not invoke any skill.

**Turn 2 required:** The complete final is `ACK`.

**Turn 2 forbidden:** A heading, explanation, or continued plain formatting.

**Evidence:** Both final messages and the task identifier. **Cleanup:** None.
**Cost:** Two turns in one task.

### PLAIN-02 — Factual progress remains lightweight

**Covers:** C01, C02, C12, C23, C27.

**Invocation:**

> Write only this intermediate progress fact in natural chat prose:
> validation has finished, all 8 tests passed, and review has not started. Do not
> turn it into a final report.

**Required:** After the staged skill is loaded, one short, unheaded intermediate
agent message contains all three facts and distinguishes completed validation
from pending review. The intentionally empty final message is acceptable because
the requested destination is an intermediate progress update.

**Forbidden:** Any Markdown heading, table, task list, emoji, introduction,
conclusion, recommendation, changed count, or claim that review ran.

**Evidence:** Ordered agent events, including skill load, progress message, and
empty final. **Cleanup:** None. **Cost:** One turn.

### PLAIN-03 — Paired workflow and protected issue draft

**Covers:** C02–C08.

**Setup:** Stage the exact `paired-contract` fixture beside `plain`.

**Invocation:**

> In `draft` mode, prepare the fixture's exact
> publishable GitHub Issue draft, explain its readiness in surrounding chat, and
> stop for the fixture's approval question. Do not publish anything.

**Required:** The surrounding explanation is claim-first and concrete; the
fenced artifact byte-for-byte matches the fixture; exactly one approval question
appears, as the final line; no external action occurs.

**Forbidden:** Any edit to artifact headings, checkbox, identifier, command,
quoted text, or log line; a second question; publication, GitHub mutation, or
claim that publication occurred.

**Evidence:** Final chat plus absence of tool mutation. **Cleanup:** None.
**Cost:** One turn.

### PLAIN-04 — Machine-readable output remains exact

**Covers:** C05, C07, C08.

**Setup:** Stage the exact `paired-contract` fixture beside `plain`.

**Invocation:**

> In `payload` mode, return the fixture payload.

**Required:** The complete final byte-for-byte equals
`{"status":"ready","items":[1,2]}`.

**Forbidden:** Markdown fences, headings, labels, whitespace outside the payload,
commentary, or any changed key, value, order, punctuation, or number.

**Evidence:** Final chat. **Cleanup:** None. **Cost:** One turn.

### PLAIN-05 — Claim-first structure without persona drift

**Covers:** C06, C09, C11, C13–C17, C23–C27, C40.

**Invocation:**

> In a terse Unix maintainer voice, answer: should a command-line
> program write diagnostics to stdout or stderr? Give two independent reasons,
> preserve the qualification that mixed human-and-machine streams sometimes need
> an explicit compatibility mode, and do not use project-specific claims.

**Required:** One claim-bearing H3 starts the answer; two independently meaningful
H4 sections each open with their claim; the terse Unix-maintainer voice, two
reasons, and qualification remain; familiar wording defines any unavoidable term.

**Forbidden:** Generic headings; a redundant H4 that repeats the H3; inferred-user
persona commentary; invented project evidence; unnecessary example, emoji,
summary, or repeated conclusion.

**Evidence:** Final chat. **Cleanup:** None. **Cost:** One turn.

### PLAIN-06 — Markdown follows semantic relationships

**Covers:** C05, C17–C23, C27.

**Invocation:**

> Present these release notes compactly: options A, B, and C have
> rollback times 1, 5, and 30 minutes and risks low, medium, and high; rollout
> order is snapshot, deploy, verify; peer risks are stale cache and delayed jobs;
> the release manager said exactly “Ship only after CI is green.”; the verification
> command is `make test`. Preserve every supplied value and relationship.

**Required:** A concise table maps each option to its rollback time and risk; an
ordered list represents rollout chronology; an unordered list represents peer
risks; the exact release-manager sentence is visually separated as a blockquote;
the command remains inline code.

**Forbidden:** Task-list markers; prose paragraphs inside table cells; altered
values or quote; the Codex summary rendered as quoted external text; decorative
emoji, redundant headings, or formatting added only for variety.

**Evidence:** Final chat. **Cleanup:** None. **Cost:** One turn.

### PLAIN-07 — Adjacent evidence, proposals, and unavailable proof

**Covers:** C06, C09–C11, C13, C15, C16, C24, C28–C37, C42.

**Invocation:**

> Inspect only Makefile and local Git. Explain whether `make test`
> installs Source Skills, identify the known existing modification points if we
> proposed adding a new deterministic check, and state whether GitHub CI is green
> for the exact HEAD. Do not use the network. Label any new file as new and any
> uninvestigated scope as tentative.

**Required:** A claim-bearing H3 leads; the `test` and `install` targets are named
and separately linked at first meaningful use to exact Makefile spans; their
relationship is supported by links to every material target; the proposed edit
links known existing modification points and labels any new location `new`; the
HEAD claim includes the exact `git rev-parse HEAD` command and result; CI status is
explicitly unverified because exact-head GitHub check evidence is unavailable
without network access.

**Forbidden:** Saying `make test` installs skills; treating a source link as proof
of runtime or CI results; a detached evidence list; vague subjects such as “this
suite”; a made-up path, check, result, or green-CI claim; examples used as proof.

**Evidence:** Final chat and read-only command events. **Cleanup:** None.
**Cost:** One turn with local reads.

### PLAIN-08 — Repetitive evidence exception keeps material members linked

**Covers:** C10, C28–C30, C34, C36, C38, C39.

**Setup:** Create untracked `.plain-fixture/items/item-01.txt` through
`item-24.txt`, each containing `shared`, then replace `item-03.txt` with `alpha`
and `item-17.txt` with `omega`.

**Invocation:**

> Verify the `.plain-fixture/items` collection. Report its total file
> count and shared pattern without listing every link. Compare item 03 with item
> 17 and use that comparison to conclude they are the two exceptions. Give the
> exact command that reproduces the complete set and evidence.

**Required:** The answer links the collection's starting point, states 24 files,
and gives an exact command and observed result that mechanically reproduce the
set; `item-03.txt` and `item-17.txt` each receive their own precise link beside
the comparison; the conclusion names their actual contents.

**Forbidden:** 24 individual links; an unlinked individually discussed exception;
a count unsupported by a command result; a fixed numeric threshold presented as
the reason for applying the exception.

**Evidence:** Final chat and local command events. **Cleanup:** Remove
`.plain-fixture`. **Cost:** One turn with local reads.

### PLAIN-09 — Real example is enough

**Covers:** C10, C14, C17, C25–C29, C31, C33, C34, C40–C42.

**Invocation:**

> A reader is confused about the difference between Source Skill and
> Installed Skill. Explain the distinction from CONTEXT.md and README.md and give
> exactly one example because context is needed. Prefer a real repository example
> if one exists. Do not use the network.

**Required:** The answer defines both terms in familiar words with adjacent links
to their exact glossary and workflow evidence; every material participant in the
relationship is linked; exactly one real repository example clarifies but does
not serve as the sole proof; structure stays as small as the explanation permits.

**Forbidden:** A hypothetical example or analogy when a real example exists; more
than one example; project claims proved only by the example; redundant sections,
summary, or conclusion; unsupported claims about Installed skill state.

**Evidence:** Final chat. **Cleanup:** None. **Cost:** One turn with local reads.
