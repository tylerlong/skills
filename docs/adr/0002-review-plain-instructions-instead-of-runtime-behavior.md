# Review Plain instructions instead of runtime behavior

The `plain` Source skill is an explicit exception to ADR 0001. Revisions freeze
its wording-independent Plain contract specification before reviewing the exact
complete Candidate instructions directly; they do not invoke Plain or add a
runtime or smoke scenario. Only behavior stated in the specification is
required. Omitted legacy rules do not survive implicitly, and unspecified
presentation forms remain matters of normal model judgment.

Once the specification and Candidate are frozen, each supported Reader profile
performs one fresh blind review. The coordinator checks Contract fidelity,
Instruction clarity, and Instruction readability; deterministic packaging and
format checks remain the existing `make validate` gate. A changed specification
or Candidate invalidates earlier review evidence.

Plain changes presentation only. It uses Available task evidence already in
current context, performs no task work, and invokes no tools or commands; the
task or paired skill retains responsibility for the work and response structure.
