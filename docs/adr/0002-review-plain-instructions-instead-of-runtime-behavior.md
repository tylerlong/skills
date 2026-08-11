# Review Plain instructions instead of runtime behavior

The `plain` source skill is an explicit exception to ADR 0001: revisions use a Skill contract review against a frozen Plain contract specification instead of runtime behavior scenarios, including smoke cases. This accepts the loss of runtime-compliance evidence because a model's failure to follow a complete, unambiguous contract is outside the skill's scope, while deterministic format and packaging checks remain.
