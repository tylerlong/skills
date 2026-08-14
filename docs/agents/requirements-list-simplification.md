# Requirements-list simplification guide

Use this guide to review and improve one version of a skill requirements list.
It defines the rules for one review cycle, not the surrounding authoring process.

## Goal

A requirements list is the smallest complete description of the skill's
non-obvious product behavior.

- **Smallest** means it contains no common sense, default Codex behavior,
  duplication, rationale, or unnecessary implementation detail.
- **Complete** means it preserves every intentional condition, boundary,
  exception, permission, requirement, and prohibition that Codex is likely to
  get materially wrong without instruction.

Concision is not the smallest word count. Never remove, merge, or generalize a
rule when doing so changes behavior or makes a material decision ambiguous.

If every proposed rule merely restates common sense or default Codex behavior,
do not author the skill.

## Authority and source material

The human owner decides the skill's product behavior. The requirements list is
the human-facing semantic authority for that behavior.

An existing `SKILL.md`, test, document, issue, discussion, or Git history may
help produce a first draft or reveal a possible omission. It does not preserve
behavior automatically. For every discovered legacy rule, ask whether omitting
it would make Codex likely to behave materially incorrectly. If not, leave it
out.

Do not change the requirements merely to match an existing `SKILL.md` or make a
later reconstruction review pass. Change them only when the human owner changes
or clarifies the product behavior.

## Decide what belongs

Keep a rule only when all of these are true:

1. It is specific to this skill.
2. It changes or constrains normal Codex behavior.
3. Without it, Codex is reasonably likely to produce a materially wrong result.
4. It states product behavior rather than an incidental way to implement it.

Remove rules that merely describe:

- common sense;
- ordinary Codex writing, reasoning, or execution behavior;
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

## Simplify without losing meaning

Review every clause for deletion before rewriting it.

### Remove duplication and implication

State each behavior once. Delete:

- a negative restatement of an already precise positive rule;
- an `otherwise` clause whose result is already determined by `only when`;
- `if present` when the named removal operation is already a harmless no-op;
- a retry prohibition already expressed by `at most once`;
- a detailed description of what continues when the surrounding workflow makes
  `continue` unambiguous; and
- a condition that cannot change the outcome.

Do not keep two versions of a boundary merely because one sounds safer. Extra
wording can introduce a second interpretation instead of adding safety.

### State shared preconditions once

When several rules have the same precedence, applicability, ownership, or scope
condition, state it once before them. Do not repeat phrases such as "when this
skill controls the output" in every item.

### Prefer the behavior over its rationale

Write what Codex must, may, or must not do. Omit why the rule was introduced
unless the reason changes how the rule applies.

## Merge and split requirements

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

## Put the list in a useful order

For a workflow skill, prefer this order:

1. Preconditions, precedence, and upstream ownership.
2. Inputs, scope, and authoritative state.
3. Admission or initialization.
4. Main actions in execution order.
5. Failure and recovery behavior beside the action that can fail.
6. Delivery, cleanup, and completion conditions.

For a non-workflow skill, order requirements by conceptual dependency: scope
before structure, general rules before their special cases, and a concept before
rules that constrain it.

After editing, read only the first sentence of every numbered item in sequence.
Those sentences should form a coherent outline of the skill.

## Write exact, natural language

Use direct language with an explicit subject, action, condition, and boundary.
Prefer ordinary verbs such as `use`, `remove`, `preserve`, `report`, and
`continue` over indirect constructions.

Review logical and normative words as product behavior:

- `and` requires both conditions; `or` allows either;
- `once` can require exactly one occurrence; `at most once` permits zero;
- `when` introduces a trigger; `only when` restricts an action;
- `must` requires behavior; `may` permits it; `must not` prohibits it; and
- `every`, `any`, `some`, and `only` define different scopes.

Use the least technical accurate term. Replace vague pronouns, undefined terms,
cross-references such as "as required below," and wording that requires the
reader to infer which earlier subject a clause modifies.

Do not add a condition merely because one can imagine an edge case. Add it only
when multiple reasonable readings would cause materially different behavior and
the human owner has an intentional decision to express.

## Single-cycle review checks

Review the complete list and report only material findings under these checks:

1. **Necessity and scope**: common sense, default Codex behavior, rationale,
   metadata, upstream responsibilities, or tool and implementation mechanics
   that do not belong to the product behavior.
2. **Duplication and implication**: repeated behavior, overlapping rules, or
   clauses already determined by another rule.
3. **Semantic consistency**: contradictory behavior or inconsistent obligations,
   permissions, and prohibitions under the same conditions.
4. **Material ambiguity**: materially different readings, vague references,
   undefined terms, or inaccurate logical words and quantities.
5. **Missing conditions**: a material condition, boundary, or exception needed
   to determine the behavior stated by the list.
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
