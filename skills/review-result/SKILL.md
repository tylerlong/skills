---
name: review-result
description: Independently review and correct an existing result (spec, plan, code change, analysis, ticket, document, migration, skill output, or other checkable artifact) against its review basis, using a fresh read-only reviewer that reports findings and context gaps, then adjudicate and apply accepted corrections until no valid unresolved findings remain. Use when the user asks to review, verify, double-check, or quality-gate the current result. Prefer a requested artifact-specific review skill when available.
---

# Review Result

Review and correct the current result without redoing the original task's
work. The Primary Agent owns adjudication and correction; Reviewer Agents only
report findings and context gaps.

## Terms and ownership

- **Output boundary**: The Candidate artifact(s) the original task is
  responsible for producing; findings and corrections outside it are out of
  scope.
- **Candidate**: The current result within the original task's output boundary.
- **Review Basis**: The task-relevant original request, settled decisions,
  requirements, constraints, permissions, acceptance criteria, authoritative
  evidence, and supplied artifact-specific criteria. The task-relevant code
  base, available to the Reviewer read-only in the repository, counts as
  authoritative evidence.
- **Review Snapshot**: One exact Candidate version and its Review Basis.
- **Context gap**: Information absent from the Review Basis that is needed to
  determine whether the Candidate meets the Review Basis's requirements,
  including a missing precedence rule for conflicting authoritative inputs.
- **Reviewer Agent**: A read-only subagent that did not produce, edit, or
  previously review the Candidate, including any earlier version of it. It does
  not run the original task's applicable completion checks, contact the user,
  or adjudicate its report.
- **Primary Agent**: The agent that owns Review Snapshot construction,
  Reviewer Agent selection, adjudication, correction, and validation status.

## Primary Agent requirements

1. Admit each Candidate version to review only after it has passed the original
   task's applicable completion checks. If no Candidate is identifiable, ask
   the user what to validate. If a Candidate exists but no Review Basis input
   is identifiable, ask the user what to use as the Review Basis only when the
   user must supply a product decision, evidence, permission, or scope; if none
   is supplied, report validation unavailable.

2. Freeze the current Candidate and its Review Basis as the Review Snapshot.

3. Obtain one valid review of the current Review Snapshot by giving a Reviewer
   Agent the Review Snapshot and all Reviewer Agent requirements, with no other
   task-specific context; the Reviewer may consult the repository read-only for
   authoritative evidence. A review is valid only when that Reviewer Agent
   returns the report required by the Reviewer Agent requirements. Retry an
   invalid review with another Reviewer Agent. The Primary Agent may stop
   retrying when further attempts are unlikely to yield a valid review; if it
   stops before a valid review exists, report validation incomplete.

4. Consolidate duplicates among the findings and Context gaps in the valid
   review, then adjudicate each underlying item. Accept a finding only when it
   is correct, supported by the Review Basis, within the original task's output
   boundary, and not already satisfied by the Candidate; otherwise, reject it
   and record the reason. Accept a reported Context gap only when it meets the
   Context gap definition; otherwise, reject it and record the reason.

5. Resolve an accepted Context gap from sources the Primary Agent is already
   permitted to consult; ask the user otherwise as in requirement 1.

6. Apply the smallest complete correction for every accepted finding within the
   original task's output boundary. After applying a correction, ensure the
   corrected Candidate has passed the original task's applicable completion
   checks, then re-review the Candidate with another Reviewer Agent. If
   corrections conflict or reverse one another under an unchanged Review Basis,
   adjudicate the conflict instead of oscillating.

7. Complete validation only when the valid review of the current Review
   Snapshot reports `No findings.` or every finding in that review has been
   rejected with a reason, with no unresolved accepted Context gap. Otherwise,
   report validation incomplete, unless the sole outstanding condition is an
   unsupplied Review Basis input, in which case report validation unavailable
   per requirement 1.

8. Report, for each valid review of a Review Snapshot, the corrections applied
   for its accepted findings, and separately its rejected findings, rejected
   Context gaps, resolved accepted Context gaps, and unresolved accepted
   Context gaps. On successful completion, state that no valid unresolved
   findings remain under the Review Basis without claiming absolute correctness.

## Reviewer Agent requirements

1. Review the complete Candidate against only the supplied Review Basis. The
   Reviewer may consult the repository read-only for the task-relevant code and
   other authoritative evidence; the supplied Review Basis remains the standard
   for every finding.

2. Report only material problems involving:

   - mismatch with the original request or settled decisions;
   - missing, incorrect, contradictory, or unsupported content;
   - conflict with authoritative evidence;
   - violation of scope, constraints, permissions, or acceptance criteria; or
   - supplied artifact-specific criteria.

3. For every finding, identify the affected content or omission, basis for the
   finding, concrete problem and material impact, and smallest complete
   correction.

4. Report each Context gap, identifying what is missing, why it is required,
   and the source or decision needed.

5. If there are no findings or Context gaps, return exactly `No findings.`
