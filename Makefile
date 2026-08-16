.DEFAULT_GOAL := help

.PHONY: help validate install

help:
	@printf '%s\n' \
		'make validate      Validate Source Skills' \
		'make install       Install Source Skills from GitHub via the Skills CLI'

validate:
	ruby test/validate_skills.rb

install:
	@test "$$(git branch --show-current)" = main || \
		{ printf '%s\n' 'Installation requires local main.' >&2; exit 1; }
	@test -z "$$(git status --porcelain)" || \
		{ printf '%s\n' 'Installation requires a clean working tree.' >&2; exit 1; }
	@$(MAKE) --no-print-directory validate
	npx --yes skills@latest update --global --yes
	npx --yes skills@latest add --global tylerlong/skills -y