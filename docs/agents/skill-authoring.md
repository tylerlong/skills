# Skill authoring

Each skill's behavior has one version-controlled representation: the body of
`skills/<skill-name>/SKILL.md`. It is simultaneously the semantic authority for
the skill's product behavior and the AI-facing instructions served to agents.

The `name` and `description` in `SKILL.md` frontmatter and
`skills/<skill-name>/agents/openai.yaml` are required platform metadata for
discovery, interface, and invocation policy. They are not product behavior, so
they are outside the authoring review.

## Author the behavior

Settle the skill's product behavior with the human owner. Existing skills,
tests, documents, issues, discussions, and history may reveal possible
omissions, but they do not preserve behavior automatically.

Write the `SKILL.md` body so its behavioral requirements are the smallest
complete description of the skill's non-obvious product behavior, following the
[authoring rules](#authoring-rules) below. Include only behavior that changes an
AI agent's default behavior. Do not include common sense, ordinary AI-agent
behavior, tool instructions, or implementation details outside the skill's
product scope.

Prefer delegating work to an Upstream skill over doing it in this skill. When
the skill builds on another skill's behavior, delegate as much as possible, and
keep this skill a preprocessor or postprocessor of that dependency. Do not
change or override a dependency skill's behavior.

Only the human owner changes the skill's scope or behavior. The coordinator may
rewrite, reorder, merge, or split requirements in the `SKILL.md` body to express
the settled behavior more accurately without changing its meaning.

## Authoring rules

Use these rules to draft, organize, and simplify the behavioral requirements in
the `SKILL.md` body. They define the authoring rules and the rules for one
review cycle, not the surrounding coordination process.

### Goal

A skill's requirements are the smallest complete description of its non-obvious
product behavior.

- **Smallest** means the requirements contain no common sense, default AI-agent
  behavior, duplication, rationale, or unnecessary implementation detail.
- **Complete** means they preserve every intentional condition, boundary,
  exception, permission, requirement, and prohibition that the AI agent is
  likely to get materially wrong without instruction.

Concision is not the smallest word count. Never remove, merge, or generalize a
rule when doing so changes behavior or makes a material decision ambiguous.

If every proposed rule merely restates common sense or default AI-agent
behavior, do not author the skill.

### Decide what belongs

Keep a rule only when all of these are true:

1. It is specific to this skill.
2. It changes or constrains normal AI-agent behavior.
3. Without it, the AI agent is reasonably likely to produce a materially wrong result.
4. It states product behavior rather than an incidental way to implement it.

Remove rules that merely describe:

- common sense;
- ordinary AI-agent writing, reasoning, or execution behavior;
- skill invocation, routing, or metadata;
- responsibilities already owned by an upstream or paired skill;
- a particular CLI, API, plugin, or tool when the product behavior is
  tool-independent;
- rationale, history, examples, or review instructions that do not change the
  skill's behavior;
- hypothetical edge cases for which the human has made no product decision; or
- defensive behavior already implied by a precise boundary.

An implementation mechanism belongs only when the mechanism is itself an
intentional product or safety boundary. For example, requiring native GitHub
relationships may be product behavior; prescribing the API call used to create
them is not. Requiring an isolated worktree may be a safety boundary; prescribing
its exact directory name usually is not.

### Simplify without losing meaning

#### Review at word grain

Read the requirements at word grain, not sentence grain. For every word and
clause ask: does it add new information, or does it re-say what is already
established — either earlier in the same statement, or as common sense? If it
adds none, cut it.

Two forces govern every cut:

- **Brevity**: remove anything that carries no new information (below).
- **Clarity**: if brevity would force the reader or the AI agent to infer an
  ambiguous antecedent or a disputed condition, keep the explicit form (next
  subsection).

#### Cut restatement, filler, and duplication

Review every clause for deletion before rewriting it. Delete wording that
carries no new information:

- a negative restatement of an already precise positive rule;
- an `otherwise` clause whose result is already determined by `only when`;
- `if present` when the named removal operation is already a harmless no-op;
- a retry prohibition already expressed by `at most once`;
- a detailed description of what continues when the surrounding workflow makes
  `continue` unambiguous;
- a condition that cannot change the outcome;
- a trailing restatement that echoes the opening of the same statement
  (e.g. "repeat this step for runnable tickets" when the step already opens with
  "for each runnable ticket");
- a common-sense qualifier — a property true by definition of the medium or
  domain (e.g. "human-readable" before a GitHub comment);
- a wrapper noun that names what the content states directly
  ("an explanation of what prevented completion" → "what prevented completion");
- a noun echoed within the same sentence when an unambiguous pronoun suffices
  ("what prevented completion" → "what prevented it" right after "cannot be
  completed");
- a verb whose action the operative verb already implies ("run a Worker Agent"
  implies creating it, so do not also say "create");
- a statement of something that needs no doing; if nothing changes without it,
  do not say it (for example, do not say "leave the ticket open" when the
  ticket is already open).

Do not keep two versions of a boundary merely because one sounds safer;
extra wording can introduce a second interpretation instead of adding safety.

#### Keep clarity over brevity

Brevity stops where it forces inference. Favor the explicit form when:

- a pronoun has two plausible antecedents — name the noun ("whenever one stops"
  → "whenever a Worker Agent stops"); and
- a qualifier resolves a real distinction even if the word repeats — keep "is
  open" (ticket state) and "open blocker" (blocker state), and keep "pushed"
  when it distinguishes the exact commit.

When in doubt, keep the word.

#### Prefer compact shapes over enumerated phrasing

- Collapse multiple sentences into the fewest that hold all distinct information.
- Prefer a compact per-item imperative loop over a sequence of
  prepare-then-launch phrases: "For each X, remove…, run…, and brief…" instead
  of "Find every X…, create each…, brief each…, then run these…".
- Turn a relative or adjective clause into a modifier ("a Child Ticket that is
  Runnable" → "a Runnable Child Ticket").

#### State shared preconditions once

When several rules have the same precedence, applicability, ownership, or scope
condition, state it once before them. Do not repeat phrases such as "when this
skill controls the output" in every item.

#### Prefer the behavior over its rationale

Write what the AI agent must, may, or must not do. Omit why the rule was
introduced unless the reason changes how the rule applies.

### Merge and split requirements

Numbered items are grouping units, not necessarily single semantic clauses. One
item may contain a normal action, its constraints, and its failure behavior when
they form one product decision. Every independently important meaning must remain
recoverable, but it need not receive its own number.

Merge clauses when they share:

- the same subject;
- the same precondition or trigger;
- the same lifecycle stage;
- the same owner; and
- one product decision that would normally change as a unit.

Place an operation's failure behavior with that operation instead of after a
later step. Merge a retry limit, conflict policy, reporting rule, and continuation
rule when all of them govern the same attempted action.

Split clauses when they:

- have different triggers or exceptions;
- occur at different lifecycle stages;
- belong to different owners;
- can change independently as product decisions; or
- become difficult to understand as one item.

Do not optimize for the fewest numbered items. Optimize for the fewest coherent
items that preserve all intended behavior.

### Put the requirements in a useful order

For a workflow skill, prefer this order:

1. Preconditions, precedence, and upstream ownership.
2. Inputs, scope, and authoritative state.
3. Admission or initialization.
4. Main actions in execution order.
5. Failure and recovery behavior beside the action that can fail.
6. Delivery, cleanup, and completion conditions.

Order any no-side-effect gate check before the step that mutates state, so a
failed gate does not leave a spurious mutation. After deleting or reordering a
numbered step, update every cross-reference such as "as in step N".

For a non-workflow skill, order requirements by conceptual dependency: scope
before structure, general rules before their special cases, and a concept before
rules that constrain it.

After editing, read only the first sentence of every numbered item in sequence.
Those sentences should form a coherent outline of the skill.

### Write exact, natural language

Use direct language with an explicit subject, action, condition, and boundary.
Prefer ordinary verbs such as `use`, `remove`, `preserve`, `report`, and
`continue` over indirect constructions.

Review logical and normative words as product behavior:

- `and` requires both conditions; `or` allows either;
- `once` can require exactly one occurrence; `at most once` permits zero;
- `when` introduces a trigger; `only when` restricts an action;
- `must` requires behavior; `may` permits it; `must not` prohibits it; and
- `every`, `any`, `some`, and `only` define different scopes.

Use the simplest accurate term. Replace vague pronouns, undefined terms,
cross-references such as "as required below," and wording that requires the
reader to infer which earlier subject a clause modifies.

Quote literal content exactly, and keep sentence punctuation outside the quotes
so it is not mistaken for part of a quoted string. Give parallel definitions
parallel phrasing (for example, several conditional terms all read "is X when…").
Use a serial comma in a list of three or more verbs.

Do not report a missing condition merely because one can imagine an edge case.
Report it only when multiple reasonable readings would cause materially
different behavior, and do not invent the missing decision.

### Terms & vocabulary

Manage the skill's vocabulary as closely as its rules.

Choose what deserves a term:

- Make a thing a term when it is awkward to explain inline and appears more
  than once.
- Inline a term used only once.

Fold reusable boundaries into a glossary:

- Put role and safety boundaries in the glossary once, so the workflow does not
  restate them (for example, that a role only coordinates, or that a shared
  branch is pushed to without force).
- Define terms without cycles: a term defined earlier must not reference a term
  defined later.

Use each term consistently:

- Refer to each term by one canonical spelling and case.
- Use the same words or phrases for the same referent everywhere; do not rename
  the same thing from one clause to the next.

## Review

The coordinator first compares the complete `SKILL.md` body with the settled
product decisions. Confirm that every intentional behavior is present, no
unapproved behavior was invented, and legacy material was used only to find
possible omissions. Then review the body using the
[authoring rules](#authoring-rules) above.

Use one fresh subagent with the same AI profile as the coordinating chat. Give
it only the verbatim current contents of the complete `SKILL.md` body and the
single-cycle review checks, not paths, summaries, or earlier snapshots. It must
have no chat history and must not use tools, inspect other files, see
product-design material, or read prior reports. Ask it to perform one review
cycle, return the report defined by the checks, and record the behavioral
requirements it recovers from the body plus any reading it could not determine.

The coordinator adjudicates every finding against the settled product decisions.
Reject invalid findings with a reason. For each accepted finding, apply the
smallest correction, review the complete body again, and give the changed body
to another fresh blind reviewer. Do not resample an unchanged `SKILL.md`.

Repeat until a reviewer reports no findings or the coordinator rejects every
finding with a reason. Ask the human owner only when a finding requires an
unresolved product decision. Lock the `SKILL.md` when no valid unresolved
finding remains. Keep review reports with the task, issue, or pull request
rather than version-controlling them.

### Single-cycle review checks

Review the complete `SKILL.md` body and report only material findings under
these checks:

1. **Necessity and scope**: common sense, default AI-agent behavior, rationale,
   metadata, upstream responsibilities, or tool and implementation mechanics
   that do not belong to the product behavior.
2. **Duplication and implication**: repeated behavior, overlapping rules, or
   clauses already determined by another rule.
3. **Semantic consistency**: contradictory behavior or inconsistent obligations,
   permissions, and prohibitions under the same conditions.
4. **Material ambiguity**: materially different readings, vague references,
   undefined terms, or inaccurate logical words and quantities.
5. **Missing conditions**: a material condition, boundary, or exception needed
   to determine the behavior stated by the body.
6. **Grouping**: closely related clauses that should be merged or independent
   decisions that should be split.
7. **Ordering**: prerequisites, definitions, actions, failure handling, or
   finalization presented in an order that obscures their relationship.
8. **Language quality**: indirect, awkward, misleading, overly technical, or
   unnecessarily verbose wording.

For each finding, quote the affected text, name the check, explain the materially
different behavior or avoidable problem, and give the smallest concrete
correction that does not invent product behavior. If there are no findings, say
`No findings.`

## Review platform metadata

After the `SKILL.md` body passes review, ensure its frontmatter accurately
describes what the skill does and when it applies. Ensure
`agents/openai.yaml` still matches the skill, keep `default_prompt` to a minimal
invocation rather than a copy of the instructions, and set
`allow_implicit_invocation` intentionally.

## Finish the change

Do not invoke the skill or test whether an AI agent can carry out clear instructions.
Execution mistakes by an AI agent or an available tool are outside skill-authoring
scope. Runtime scenarios, human-readability scoring, and review matrices are not
part of this process. A lightweight behavioral smoke check (running the skill
against a real repo and tickets) is not part of this gate, but may surface
coordination bugs earlier than production does.

After the review is locked and platform metadata is current, run `make validate`.
Version-control the Source skill, including metadata changes. Do not finish while
unresolved behavior remains.

After the change is committed and pushed to `main`, run `make install` separately
from a clean local `main`.
