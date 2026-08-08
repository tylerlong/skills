.DEFAULT_GOAL := help

.PHONY: help validate test-install test install

help:
	@printf '%s\n' \
		'make validate      Validate Source Skills' \
		'make test-install  Test global installation' \
		'make test          Run all tests' \
		'make install       Update tracked Installed Skills and install sources'

validate:
	ruby test/validate_skills.rb

test-install:
	ruby test/install_skills_test.rb

test: validate test-install

install:
	@test "$$(git branch --show-current)" = main || \
		{ printf '%s\n' 'Installation requires local main.' >&2; exit 1; }
	@test -z "$$(git status --porcelain)" || \
		{ printf '%s\n' 'Installation requires a clean working tree.' >&2; exit 1; }
	@$(MAKE) --no-print-directory validate
	npx --yes skills@latest update --global --yes
	@set -eu; \
	root="$$HOME/.agents/skills"; \
	mkdir -p "$$root"; \
	for source in skills/*; do \
		[ -d "$$source" ] || continue; \
		target="$$root/$${source##*/}"; \
		if [ -L "$$target" ] || { [ -e "$$target" ] && [ ! -d "$$target" ]; }; then \
			rm -f -- "$$target"; \
		fi; \
		mkdir -p "$$target"; \
		rsync -rlpc --delete "$$source/" "$$target/"; \
		raw_difference=$$(rsync -rlpcn --delete --itemize-changes "$$source/" "$$target/"); \
		difference=$$(printf '%s\n' "$$raw_difference" | sed '/^\.f\.\.T\.\.\.\. /d'); \
		if [ -n "$$difference" ]; then \
			printf 'Managed Installed Skill %s still differs:\n%s\n' "$${source##*/}" "$$difference" >&2; \
			exit 1; \
		fi; \
	done
