---
name: review-result
description: Independently review and correct a completed result against its basis, applying accepted findings.
---

# Review Result

Review and correct the current result without redoing the original task's
work. The Primary Agent owns adjudication and correction; Reviewer Agents only
report findings.

## Terms and ownership

- **Candidate**: The result the original task must produce to deliver a
  correct result, including any supporting change it made for that purpose.
- **Review Basis**: The task-relevant original request, settled decisions,
  requirements, constraints, permissions, acceptance criteria, authoritative
  evidence, and supplied artifact-specific criteria. The task-relevant code
  base, available to the Reviewer read-only in the repository, counts as
  authoritative evidence.
- **Review Snapshot**: One exact Candidate version and its Review Basis.
- **Reviewer Agent**: A read-only subagent that reviews the Candidate and
  reports findings. It does not run the original task's applicable completion
  checks, contact the user, or adjudicate findings.
- **Primary Agent**: The agent that owns Review Snapshot construction, Reviewer
  Agent creation and selection, adjudication, correction, and validation status.

## Primary Agent requirements

1. Admit each Candidate version to review only after it has passed the original
   task's applicable completion checks.

2. Freeze the current Candidate and its Review Basis as the Review Snapshot.

3. Create a fresh Reviewer Agent: a new subagent that did not produce, edit, or
   previously review the Candidate, including any earlier version of it. Run it
   against the frozen Review Snapshot, giving it only the Review Snapshot and
   all Reviewer Agent requirements, with no other task-specific context.

4. A review is valid only when the Reviewer Agent returns the report required by
   the Reviewer Agent requirements. Retry an invalid review with another fresh
   Reviewer Agent. The Primary Agent may stop retrying when further attempts are
   unlikely to yield a valid review; if it stops before a valid review exists,
   report validation incomplete.

5. Consolidate duplicates among the findings in the valid review, then
   adjudicate each. Accept a finding only when it is correct, supported by the
   Review Basis, and not already satisfied by the Candidate; otherwise, reject
   it and record the reason.

6. Apply the smallest complete correction for every accepted finding. After
   applying a correction, ensure the corrected Candidate has passed the original
   task's applicable completion checks, then re-review the Candidate with
   another fresh Reviewer Agent. If corrections conflict or reverse one another
   under an unchanged Review Basis, adjudicate the conflict instead of
   oscillating.

7. Complete validation only when the valid review of the current Review
   Snapshot reports `No findings.` or every finding in that review has been
   rejected with a reason. Otherwise, report validation incomplete.

8. Report, for each valid review of a Review Snapshot, the corrections applied
   for its accepted findings, and separately its rejected findings. On
   successful completion, state that no valid unresolved findings remain under
   the Review Basis without claiming absolute correctness.

## Reviewer Agent requirements

1. Review the complete Candidate against only the supplied Review Basis, the
   standard for every finding.

2. Report only material problems involving:

   - mismatch with the original request or settled decisions;
   - missing, incorrect, contradictory, or unsupported content;
   - conflict with authoritative evidence;
   - violation of scope, constraints, permissions, or acceptance criteria; or
   - supplied artifact-specific criteria.

3. For every finding, identify the affected content or omission, basis for the
   finding, concrete problem and material impact, and smallest complete
   correction.

4. If there are no findings, return exactly `No findings.`
