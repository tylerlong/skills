# Characterize source skills before revising them

Before revising a Source skill, define or update checked-in Skill behavior tests
that invoke the exact Baseline skill through observable agent-output and
authoritative external-state seams. Use deterministic TDD at an honest seam for
deterministic behavior, green Baseline characterization for a
behavior-preserving revision, and specification-first controlled
Baseline/Candidate evaluation for a nondeterministic AI behavior change. A
behavior-changing Baseline may expose the current gap; it must not be forced
green before implementing the intended Candidate behavior.

Record the evaluator conditions and run each affected Baseline and Candidate
scenario once initially. Permit at most one paired diagnostic rerun for
ambiguity and report persistent inconsistency as Unstable. A repair does not
automatically restart the full required suite: rerun every scenario traceably
affected by the change and carry demonstrably disjoint evidence forward with its
original commit and rationale; use broader invalidation whenever impact is
uncertain or cross-cutting.

This applies to every Source skill revision, including behavior changes, fixes,
and simplification. The final exact commit still receives deterministic tests,
full verification, and review. Specifications live outside Source skill folders
so they add no normal invocation cost, while concise execution evidence belongs
in the delivery ticket or pull request instead of a versioned results file. This
accepts bounded AI nondeterminism and execution cost without coupling tests to
instruction wording or hidden reasoning.
