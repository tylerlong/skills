# Plain contract specification

This file is the wording-independent semantic authority for the `plain` Source
skill. Its stable atomic obligations state intended behavior; Source wording,
the retired Contract Map, and the retired runtime catalog are migration evidence
only. If those inputs imply genuinely different intended meanings, qualification
stops as **Needs human decision** and states the exact alternatives.

The five sections below are navigational only. Their headings, order, and the
number or order of obligations carry no scoring meaning. Each obligation keeps
its own modality, conditions, and exceptions; reader reports may harmlessly
split or combine meanings.

**Scope.** A Skill contract review evaluates the exact complete `SKILL.md`
instructions. It does not invoke Plain, sample an answer, inspect hidden
reasoning, or claim runtime compliance. It **MUST NOT** read, replace, invoke, or
mutate a user-level Installed skill or use the configured sandbox repository.

**Mechanical Validity.** Run the existing `make validate` Source-skill validator
once for each exact Baseline and Candidate version before semantic
qualification. A deterministic defect is **Fail**; an incomplete result caused
by tooling or infrastructure is **Technical stop**. Do not add a Plain-specific
parser, schema, runner, target, or smoke case.

**Reader profiles.** Use exactly GPT-5.6 SOL max, GPT-5.6 SOL high, and GPT-5.6
SOL medium. Record the exact model, reasoning effort, service tier, personality,
tool version, prompt, and Source identity for each review. Source identity means
the repository path, full Git commit SHA, and SHA-256 digest of the exact
complete `SKILL.md`.

**Blind inputs.** Give each reader only the Reader report directions and approved
Clarity and Readability rubrics below plus the exact complete instructions under
blind labels. Hide the contract authority statement and obligation sections,
Baseline/Candidate identity, issue and revision history, the old catalog, prior
reports, prior scores, mappings, and verdicts. For a
contract-preserving comparison with a valid Baseline, each profile reviews both
Baseline and Candidate in one A/B review, with label order varied across
profiles, and evaluates each version independently. If the Baseline is invalid,
record its gate failure and diagnostic scores without an official composite. An
approved contract change or specification correction freezes this specification
first, qualifies only the Candidate, and promotes a passing Candidate to
Baseline.

**Reader report.** Return one Markdown report per blind version; A/B reports may
be separate top-level sections in one response. For each version, reconstruct
every independently actionable requirement, prohibition, permission,
preference, condition, and exception; state its modality, conditions, and
exceptions; and cite the exact instruction lines supporting it. Then list every
plausible materially different reading, or `None`. Finish with one integer
Instruction Clarity score and one integer Instruction Readability score, each
with a concise reason citing the most material instruction evidence. Do not emit
Pass/Fail, a pairwise preference, or a judgment about whether the approved
behavior is desirable. Evaluate the approved contract rather than substituting a
preferred writing style.

**Instruction Clarity rubric.** Instruction Clarity measures precision and
consistency in expressing obligations, boundaries, conditions, and exceptions.

| Score | Anchor |
| --- | --- |
| 1 | Unusable: obligations or boundaries cannot be recovered reliably. |
| 2 | Major or repeated material obstruction makes obligations inconsistent or ambiguous. |
| 3 | Meaning is recoverable only with significant friction or ambiguity. |
| 4 | Obligations and boundaries are clear and consistent, with only minor localized issues. |
| 5 | Exceptionally precise and consistent, with no meaningful clarity improvement available without trade-off. |

**Instruction Readability rubric.** Instruction Readability measures how easily
a reader can navigate and understand the instructions without avoidable
repetition or cognitive load.

| Score | Anchor |
| --- | --- |
| 1 | Unusable: the instructions cannot be navigated or understood reliably. |
| 2 | Major or repeated material obstruction makes navigation or understanding difficult. |
| 3 | Meaning is recoverable only with significant friction or cognitive load. |
| 4 | The instructions are clear and easy to navigate, with only minor localized issues. |
| 5 | Exceptionally easy to navigate and understand, with no meaningful readability improvement available without trade-off. |

**Coordinator mapping.** The implementation coordinator owns the
obligation-by-profile matrix, Contract Fidelity decision, scorecard, and final
outcome. Map meanings rather than reader identifiers, order, counts, or harmless
splitting and merging. Every matrix cell must cite the reader evidence that
establishes Match or record the exact Mismatch. Vague wording that does not
clearly recover modality, conditions, or exceptions is a Mismatch; do not infer
missing meaning for the reader. Contract Fidelity passes only if every profile
recovers every obligation correctly and no profile recovers a material extra or
incompatible obligation or reports a plausible materially incompatible reading.
There is no fourth judge, majority cure, or favorable resampling.

**Scores, outcomes, and optimization.** Every one of the six profile-by-dimension
scores must be at least 4. Calculate an official composite only after Mechanical
Validity and Contract Fidelity pass; it is the equal-weight arithmetic mean of
all six scores. Use only these outcomes:

- **Pass:** both gates pass and all six scores are at least 4.
- **Fail:** a deterministic Mechanical Validity defect, completed incompatible
  interpretation, Contract Fidelity mismatch, instruction-attributable
  ambiguity, or score below 4 exists.
- **Needs human decision:** intended contract meaning is unresolved; state the
  exact alternatives and stop.
- **Technical stop:** required mechanical or reader evidence could not be
  completed because of tooling or infrastructure; issue no verdict and do not
  rerun automatically.

Run one completed review per exact version/profile. Another review is permitted
only after Candidate instructions or this specification changes; first address
every defect, mismatch, ambiguity, or sub-4 score in the Candidate. Apply this
ordered policy: both gates; all six scores at least 4; valid-Baseline composite
non-regression; higher composite; equal-composite smaller Instruction footprint.
Instruction footprint is the Unicode code-point count of the exact complete
`SKILL.md`, including frontmatter, body, whitespace, and final newline.
Abbreviations improve it only when they remain unambiguous and every Readability
score remains at least 4. A Candidate change invalidates every earlier Candidate
reader report; the complete-instruction review seam permits no disjoint
carry-forward.

**Evidence storage.** Keep raw reader reports and evaluator details outside
version control. Durable delivery evidence records exact Source identities and
settings, both gates, all six scores, any official composite, Instruction
footprint, every mapping result, every mismatch or ambiguity, and pointers to
the raw artifacts.

## Applicability and ownership

| ID | Atomic obligation |
| --- | --- |
| PAO-01 | Use of Plain **MUST** be triggered by an explicit user request naming `$plain`. |
| PAO-02 | Plain's influence **MUST** end at the boundary of the invocation that triggered it. |
| PAO-03 | A Codex-authored final response **MUST** be in scope while Plain is active. |
| PAO-04 | Codex-authored commentary **MUST** be in scope while Plain is active; this includes explanations, findings, recommendations, questions, approval prompts, and progress messages. |
| PAO-05 | Plain **MUST** determine treatment from the intended destination of each piece of text. |
| PAO-06 | Chat prose wrapped around protected material **MUST** remain eligible for Plain's presentation improvements. |
| PAO-07 | Plain's transformations **MUST** be limited to presentation. |
| PAO-08 | Plain **MUST NOT** alter the task being performed. |
| PAO-09 | With a paired skill, authority over investigation **MUST** stay with the paired skill. |
| PAO-10 | With a paired skill, authority over verification **MUST** stay with the paired skill. |
| PAO-11 | With a paired skill, authority over decisions **MUST** stay with the paired skill. |
| PAO-12 | With a paired skill, authority over actions **MUST** stay with the paired skill. |
| PAO-13 | With a paired skill, authority over workflow **MUST** stay with the paired skill. |
| PAO-14 | With a paired skill, authority over stopping points **MUST** stay with the paired skill. |
| PAO-15 | With a paired skill, authority over question content **MUST** stay with the paired skill. |
| PAO-16 | With a paired skill, authority over the number of questions **MUST** stay with the paired skill. |
| PAO-17 | With a paired skill, authority over response structure **MUST** stay with the paired skill. |
| PAO-18 | Evidence acquisition needed for a conclusion **MUST** be performed by the task or owning skill, not by Plain. |
| PAO-19 | Plain **MUST** choose relevant material from Available task evidence. |
| PAO-20 | Plain **MUST** make its selected Available task evidence visible in the response. |
| PAO-21 | Material counts as Available task evidence only when the task or owning skill has already established it and it is present in the current context. |
| PAO-22 | Plain **MUST NOT** widen an investigation beyond the owning task's needs merely to improve presentation. |

## Fidelity and protected material

| ID | Atomic obligation |
| --- | --- |
| PFP-01 | A presentation edit by Plain **MUST NOT** change any factual assertion. |
| PFP-02 | A presentation edit by Plain **MUST NOT** change the intended semantics. |
| PFP-03 | A presentation edit by Plain **MUST** retain every caveat and condition. |
| PFP-04 | A presentation edit by Plain **MUST** retain the original level of exactness. |
| PFP-05 | A presentation edit by Plain **MUST** retain the evidentiary basis. |
| PFP-06 | Plain **MUST** leave the wording of every publication-bound artifact untouched, including a provisional draft displayed in chat. |
| PFP-07 | A publication-bound artifact **MUST** retain its owner-defined format; protected artifacts include Issues, comments, specifications, documentation, and comparable output. |
| PFP-08 | Source-code text **MUST** remain unchanged by Plain. |
| PFP-09 | Identifier text **MUST** remain unchanged by Plain. |
| PFP-10 | Command text **MUST** remain unchanged by Plain. |
| PFP-11 | Configuration text **MUST** remain unchanged by Plain. |
| PFP-12 | Quoted text **MUST** remain unchanged by Plain. |
| PFP-13 | Log text **MUST** remain unchanged by Plain. |
| PFP-14 | Text originating outside Codex **MUST** remain unchanged by Plain. |
| PFP-15 | Machine-consumed output **MUST** remain unchanged by Plain. |
| PFP-16 | A paired skill's mandated heading text **MUST** survive unchanged. |
| PFP-17 | A paired skill's mandated heading levels **MUST** survive unchanged. |
| PFP-18 | A paired skill's mandated section set **MUST** survive unchanged. |
| PFP-19 | A paired skill's mandated section arrangement **MUST** survive unchanged. |
| PFP-20 | A paired skill's required artifact **MUST** survive unchanged. |
| PFP-21 | A paired skill's machine-consumed format **MUST** survive unchanged. |

## Claim-first prose

| ID | Atomic obligation |
| --- | --- |
| PCP-01 | Substantive prose controlled by Plain **MUST** open with the most important truthful current outcome, unresolved choice, or conclusion before mentioning process or skill activity. |
| PCP-02 | Substantive prose controlled by Plain **MUST** identify what it is about explicitly. |
| PCP-03 | When that order aids understanding, an explanation **SHOULD** move from assertion to rationale, then adjacent support, then practical consequence. |
| PCP-04 | A message that only acknowledges receipt **MUST** say concretely what it acknowledges. |
| PCP-05 | A message that only acknowledges receipt **MUST NOT** have a heading. |
| PCP-06 | A brief progress message containing facts **MUST** state those facts concretely. |
| PCP-07 | A brief progress message containing facts **MUST NOT** have a heading. |
| PCP-08 | If Plain controls a substantive response's hierarchy, the response's first content **MUST** be an H3. |
| PCP-09 | That opening H3 **MUST** communicate the response's primary assertion. |
| PCP-10 | A lead heading **SHOULD NOT** be a content-free label such as `Overview`, `Details`, or `Update`. |
| PCP-11 | Each supporting proposition that can stand on its own **MUST** have a separate H4 section, except when it is a ranked item in an all-label-only ranked set governed by PSS-08. |
| PCP-12 | An independently meaningful supporting proposition **MUST NOT** be reduced to a list entry, except when it is a ranked item in an all-label-only ranked set governed by PSS-08. |
| PCP-13 | An independently meaningful supporting proposition **MUST NOT** be merged into another proposition's paragraph. |
| PCP-14 | Distinct reasons explicitly requested by the user **MUST** be treated as separate supporting propositions. |
| PCP-15 | When a substantive response contains only one point, Plain **MUST NOT** create an H4 that restates the H3's role. |
| PCP-16 | The first sentence after a heading **MUST** advance the heading's assertion rather than restate it. |
| PCP-17 | Each section after the first **MUST** put its section-level assertion first. |
| PCP-18 | Word choice **SHOULD** favor familiar terms. |
| PCP-19 | Word choice **SHOULD** favor concrete terms. |
| PCP-20 | An unavoidable unfamiliar term **MUST** receive a short definition. |
| PCP-21 | Plain **MUST NOT** raise or lower conceptual abstraction merely because it infers a reader's expertise. |
| PCP-22 | Plain **MUST NOT** lengthen or shorten an answer merely because it infers a reader's expertise. |
| PCP-23 | Plain **MUST** delete filler. |
| PCP-24 | Plain **MUST** delete repeated content that adds no meaning. |
| PCP-25 | Plain **MUST** delete tangential content. |
| PCP-26 | Plain **MUST** delete examples that add no needed context. |
| PCP-27 | Plain **MUST** delete a conclusion that merely repeats an earlier conclusion. |
| PCP-28 | Concision edits **MUST** retain context needed to understand the answer. |
| PCP-29 | Concision edits **MUST** retain the reasoning supporting the answer. |
| PCP-30 | Concision edits **MUST** retain the evidence supporting the answer. |
| PCP-31 | Concision edits **MUST** retain qualifications. |
| PCP-32 | Concision edits **MUST** retain transitions needed to follow the argument. |
| PCP-33 | Plain **MAY** add an introduction only when it materially helps navigation in a longer answer. |
| PCP-34 | Plain **MAY** add a summary only when it materially helps navigation in a longer answer. |
| PCP-35 | Plain **MAY** add a concluding section only when it materially helps navigation in a longer answer. |

## Semantic structure

| ID | Atomic obligation |
| --- | --- |
| PSS-01 | Plain **MUST** choose no more structural markup than is needed to reveal the relationships in the content. |
| PSS-02 | Reasoning whose parts depend on one another **MUST** remain continuous paragraph prose. |
| PSS-03 | Plain **MUST NOT** enforce numerical presentation quotas or thresholds of any kind, including counts of items, words, sentences, paragraphs, headings, or formatting devices. |
| PSS-04 | A formatting element **MUST NOT** be introduced merely to vary appearance. |
| PSS-05 | Separate items at the same semantic level **MUST** be represented as an unordered list. |
| PSS-06 | A brief enumeration that is incidental to a larger thought **MUST** stay within the prose. |
| PSS-07 | Steps with a meaningful execution or reading order **MUST** be represented as an ordered list. |
| PSS-08 | If every item in a ranked set is label-only, the set **MUST** be represented as an ordered list. |
| PSS-09 | Task-list checkboxes **MUST NOT** be used unless they represent real completion criteria or real status. |
| PSS-10 | A compact comparison across common dimensions **MUST** be represented in a table. |
| PSS-11 | A compact mapping between repeated keys and values **MUST** be represented in a table. |
| PSS-12 | A compact record set sharing the same fields **MUST** be represented in a table. |
| PSS-13 | A table **MUST NOT** contain an extended or continuous explanation. |
| PSS-14 | When a sizeable verbatim quotation stands as its own item, it **MUST** be displayed as a blockquote. |
| PSS-15 | The displayed quotation **MUST** preserve its full character sequence, including quotation marks. |
| PSS-16 | A speaker label **MUST NOT** replace any portion of quoted wording. |
| PSS-17 | Text that is not a quotation **MUST NOT** receive quotation styling for decoration. |
| PSS-18 | A Codex-authored paraphrase or summary **MUST NOT** be presented as external quoted wording. |
| PSS-19 | Bold styling **MUST** mark only a label whose role gives the styling semantic purpose. |
| PSS-20 | Inline or fenced code styling **MUST** mark only material whose role gives that styling semantic purpose. |
| PSS-21 | An emoji **MAY** be added as a semantic cue only when the cue makes recognition faster. |
| PSS-22 | An emoji used as a cue **MUST** have a textual label. |
| PSS-23 | Repeated emoji cues **MUST** retain consistent meanings. |
| PSS-24 | An emoji placed in a list **MUST NOT** replace the list's normal bullet or number marker. |
| PSS-25 | Plain **MUST NOT** require a predetermined set of emoji. |
| PSS-26 | Emoji **MUST NOT** be applied indiscriminately across content units such as items, headings, sections, or cells. |
| PSS-27 | Special styling **MUST NOT** be applied indiscriminately across content units such as items, headings, sections, or cells. |
| PSS-28 | Plain **SHOULD** omit emoji whenever it would increase noise. |
| PSS-29 | Plain **SHOULD** omit special styling whenever it would increase noise. |
| PSS-30 | A ranked item **MUST** have a label. |
| PSS-31 | A ranked item **MAY** have a body. |
| PSS-32 | Follow-up explanation, reasoning, evidence, qualification, example, quotation, code block, nested list, or another paragraph associated with a ranked item's label **MUST** count as that item's body. |
| PSS-33 | If any item in a ranked set has a body, every item in that set **MUST** be represented as a numbered H4 section. |
| PSS-34 | An ordered-list item **MUST NOT** contain multiple body paragraphs. |
| PSS-35 | Plain **MUST NOT** invent body content for a ranked item. |
| PSS-36 | In a ranked set containing any body, a label-only item **MUST** still be represented as a numbered H4 section. |
| PSS-37 | A label-only item governed by PSS-36 **MAY** remain without body content. |

## Evidence and examples

| ID | Atomic obligation |
| --- | --- |
| PEE-01 | A claim about a project **MUST** identify its concrete subject rather than depend on a vague pointer such as `this suite`, `the layer`, or `it`. |
| PEE-02 | If Source lines cannot establish a test, search, command, or runtime assertion but Available task evidence can, the response **MUST** show the exact command that produced the evidence. |
| PEE-03 | Under the condition in PEE-02, the response **MUST** show the command's observed result. |
| PEE-04 | Under the condition in PEE-02, the command and result **MUST** sit beside the assertion they support. |
| PEE-05 | Under the condition in PEE-02, the command, result, and supported assertion **MUST** appear in the same Plain-controlled message. |
| PEE-06 | A tool event outside the response **MUST NOT** substitute for evidence presented to the reader. |
| PEE-07 | A real repository location that is named or used materially **MUST** receive specific Available task evidence next to the claim; if that evidence is absent, PEE-29 and PEE-30 govern instead. |
| PEE-08 | An imprecise, ornamental, detached, or unmapped collection of links **MUST NOT** replace evidence placed with its claim. |
| PEE-09 | A single evidence link **MUST** cover no more than one contiguous relevant region of one file. |
| PEE-10 | The target of a file link **MUST** be the first relevant line or, when supported, a narrowly bounded relevant range. |
| PEE-11 | Relevant regions separated within one file **MUST** use different links. |
| PEE-12 | Relevant regions in different files **MUST** use different links. |
| PEE-13 | In a multi-part relationship, flow, comparison, or proposal, each entity necessary to prove the assertion **MUST** have its own specific link. |
| PEE-14 | Evidence attached to one entity **MUST NOT** be used as evidence for another entity. |
| PEE-15 | An implementation trace **MUST** stop once the cited material directly establishes the assertion. |
| PEE-16 | An implementation trace **MUST NOT** add links to downstream calls unrelated to proving the assertion. |
| PEE-17 | Within each response section, the first material mention of a real repository symbol **MUST** carry its evidence link. |
| PEE-18 | Later mentions of the same location in that section **MUST NOT** repeat the link. |
| PEE-19 | A snippet copied from the repository **MUST** have a nearby link to its precise origin. |
| PEE-20 | A snippet that does not yet exist **MUST** be labelled proposed. |
| PEE-21 | A snippet invented only for explanation **MUST** be labelled hypothetical. |
| PEE-22 | A correctly labelled proposed or hypothetical snippet **MAY** omit a source link. |
| PEE-23 | Support for a code assertion **MUST** cite the exact relevant Source lines. |
| PEE-24 | Support for a GitHub assertion **MUST** cite the exact relevant Issue, comment, commit, check, or native relationship. |
| PEE-25 | Support for a documentation assertion **MUST** cite the relevant document section. |
| PEE-26 | A change proposal **MUST** link every existing location already known to require modification. |
| PEE-27 | A location that would be created by a proposal **MUST** be marked `new`. |
| PEE-28 | Proposed scope that has not been investigated **MUST** be marked tentative. |
| PEE-29 | If Available task evidence does not support a project assertion, the response **MUST** identify that assertion as unverified. |
| PEE-30 | Every unverified project assertion **MUST** state what evidence is missing. |
| PEE-31 | Links for individual members of a repetitive collection **MAY** be omitted only when the collection is mechanically reproducible and a complete member-link list would overwhelm the answer. |
| PEE-32 | Eligibility for the repetitive-collection exception **MUST** be decided by judgment, not by a numeric cutoff. |
| PEE-33 | When the repetitive-collection exception is used, the collection's defining symbol or starting location **MUST** be linked. |
| PEE-34 | The collection-level link **MUST** remain separate from any evidence links for individual members. |
| PEE-35 | Use of the repetitive-collection exception **MUST** include the collection's member count. |
| PEE-36 | Use of the repetitive-collection exception **MUST** include the exact editor operation, search, or command that reproduces the collection. |
| PEE-37 | A member discussed on its own **MUST** retain an individual evidence link despite the repetitive-collection exception. |
| PEE-38 | A member compared on its own **MUST** retain an individual evidence link despite the repetitive-collection exception. |
| PEE-39 | A member used to support a conclusion **MUST** retain an individual evidence link despite the repetitive-collection exception. |
| PEE-40 | An example **MAY** be introduced only when the surrounding context would otherwise be insufficient. |
| PEE-41 | When an example is warranted, a real instance from the current situation **SHOULD** be the first choice. |
| PEE-42 | If no suitable real instance exists, a short hypothetical **SHOULD** be the next choice. |
| PEE-43 | A hypothetical example **MUST** be labelled hypothetical. |
| PEE-44 | An analogy **MAY** be used only after direct explanation and a real or hypothetical example remain insufficient. |
| PEE-45 | An example **MUST NOT** serve as proof for a factual assertion. |
| PEE-46 | The term project-specific claim **MUST** mean a factual assertion about a particular project or repository state. |
