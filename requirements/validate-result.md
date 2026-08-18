# validate-result requirements

Validate and correct the current result without recreating the task or expanding
its scope. The coordinating agent owns adjudication and editing; reviewers only
report findings.

## Establish the review basis

Identify:

- the exact current candidate;
- the original request and later settled decisions;
- applicable requirements, constraints, permissions, and acceptance criteria;
- authoritative evidence and relevant source or environment snapshots.

Include all task-relevant context, even if the producer overlooked some of it,
but exclude unrelated conversation, producer reasoning, suspected defects,
previous reviews, and adjudications.

Prefer verbatim inputs and raw evidence. For large sources, give the reviewer
read-only access to the same source and identify the exact revision when
possible.

If there is no identifiable candidate, ask the user what to validate. If there
is no objective basis for judgment, explain that the candidate can only be
critiqued, not validated.

## Run objective checks

Run existing applicable checks such as tests, compilation, schema validation, or
link checking. Do not invent a new validation framework. Objective failures take
precedence over reviewer opinion.

## Review independently

Create a fresh sub-agent that did not produce or edit the candidate. Give it the
review basis, exact candidate, and objective-check results. Keep it read-only and
do not expose earlier review history.

Instruct it to review the complete candidate for material:

- mismatch with the request or settled decisions;
- missing, incorrect, contradictory, or unsupported content;
- conflict with authoritative evidence;
- scope, constraint, permission, or acceptance-criteria violations;
- failures that prevent the candidate from serving its intended purpose.

Apply supplied artifact-specific criteria. Do not invent requirements from
personal taste, stylistic preference, or speculative best practices.

For each finding, require:

- affected location;
- conflicting requirement or evidence;
- concrete problem and impact;
- smallest correction.

Require a **Context gap** when a judgment needs missing information, identifying
what is missing and why. If there are no findings or context gaps, require the
exact response `No findings.`

## Adjudicate and correct

For every finding:

- **Accept** it when supported, then apply the smallest complete correction.
- **Reject** it when incorrect, unsupported, subjective, duplicate, out of
  scope, or already satisfied, and record the reason.
- **Resolve a context gap** from authorized sources, or ask the user when it
  requires a new product decision or additional authority.

Do not accept findings automatically or perform unauthorized external writes.

## Repeat

After any candidate or review-basis change:

1. rerun affected objective checks;
2. capture the exact updated candidate;
3. create another fresh reviewer;
4. review the complete result, not only the correction.

Do not give the new reviewer previous findings or adjudications. Do not review
an unchanged candidate again. If corrections begin reversing each other under
an unchanged review basis, adjudicate the conflict instead of oscillating.

Finish when the latest reviewer reports `No findings.` or every latest finding
has been rejected with a reason.

Deliver the corrected result and briefly summarize checks, review rounds,
accepted corrections, rejected findings, and unresolved decisions. Say that no
valid unresolved findings remain under the supplied requirements and evidence;
do not claim absolute correctness.