# Validate result requirements

## Terms and ownership

- **Candidate**: The current result within the original task's output boundary.
- **Review Basis**: The task-relevant original request, settled decisions,
  requirements, constraints, permissions, acceptance criteria, authoritative
  evidence, and supplied artifact-specific criteria.
- **Review Snapshot**: One exact Candidate version and its Review Basis.
- **Context gap**: Information absent from the Review Basis that is needed to
  determine whether the Candidate satisfies the Review Basis, including a
  missing precedence rule for conflicting authoritative inputs.
- **Reviewer Agent**: A fresh, read-only subagent that did not produce, edit, or
  previously review the Candidate. It does not run task-owned completion checks,
  edit the Candidate, contact the user, or adjudicate its report.
- **Primary Agent**: The agent that owns Review Snapshot construction,
  Reviewer Agent selection, adjudication, correction, and validation status.

## Primary Agent requirements

1. Admit each Candidate version to review only after it is complete and has
   passed the original task's applicable completion checks. Those checks remain
   owned by the original task. If no Candidate is identifiable, ask the user
   what to validate and do not begin review. If a Candidate exists but no Review
   Basis input is identifiable, report validation unavailable and stop.

2. Create a Review Snapshot containing the exact current Candidate and every
   identifiable Review Basis input. Give the Reviewer Agent its contents
   directly or through read-only access to an immutable representation
   containing only those contents. Exclude material outside the Candidate and
   Review Basis, including unrelated conversation, producer reasoning,
   suspected findings, previous reviews, and adjudications.

3. Obtain one valid review of the current Review Snapshot by giving a fresh
   Reviewer Agent the Review Snapshot and all Reviewer Agent role and review
   requirements, with no other task-specific context. A review is valid only
   when that Reviewer Agent reviews the complete Candidate within its role
   boundaries and returns the required report. Retry an invalid review with
   another fresh Reviewer Agent, but do not resample a valid review of an
   unchanged Review Snapshot.

4. Consolidate duplicates among the findings and Context gaps in the current
   valid review, then adjudicate each underlying item. Accept a finding only
   when it is correct, supported by the Review Basis, in scope, and not already
   satisfied; otherwise, reject it and record the reason. Accept a reported
   Context gap only when it meets the Context gap definition; otherwise, reject
   it and record the reason. Resolve an accepted Context gap from
   already-authorized sources; ask the user only when resolution requires the
   user to provide a product decision, evidence, permission, or scope.

5. Apply the smallest complete correction for every accepted finding within the
   original task's output boundary. After any Candidate or Review Basis change,
   create a new Review Snapshot and have another fresh Reviewer Agent review the
   complete Candidate. If corrections conflict or reverse one another under an
   unchanged Review Basis, adjudicate the conflict instead of oscillating.

6. Complete validation only when the latest valid review reports `No findings.`
   or every finding in that review has been rejected with a reason, with no
   unresolved accepted Context gap. Otherwise, report validation incomplete.
   Report the review rounds, corrections applied for accepted findings,
   rejected findings, rejected Context gaps, and unresolved accepted Context
   gaps. On successful completion, state that no valid unresolved findings
   remain under the Review Basis without claiming absolute correctness.

## Reviewer Agent requirements

1. Review the complete Candidate independently against only the supplied Review
   Basis.

2. Report only material problems involving:

   - mismatch with the original request or settled decisions;
   - missing, incorrect, contradictory, or unsupported content;
   - conflict with authoritative evidence;
   - violation of scope, constraints, permissions, or acceptance criteria;
   - failure to serve the Candidate's stated purpose; or
   - supplied artifact-specific criteria.

   Do not derive requirements from personal taste, stylistic preference, or
   speculative best practices.

3. For every finding, identify the affected content or omission, basis for the
   finding, concrete problem and material impact, and smallest complete
   correction.

4. Report each Context gap, identifying what is missing, why it is required,
   and the source or decision needed.

5. If there are no findings or Context gaps, return exactly `No findings.`
