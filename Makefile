# Main Dynamic Makefile

DEBUG := ## Set to any value to include extra debug information in the output. Note, only a blank value will turn off DEBUG.

# If you do not specify a <target> assume you need help.

.DEFAULT_GOAL := help

# Variables - Add any custom variable you want available here.

BACKEND_DIR = backend
FRONTEND_DIR = frontend
CONTAINER_PHP = php

# Dynamically create the .PHONY list

PHONY_TARGETS := $(basename $(notdir $(wildcard makefiles/*.mk)))
PHONY_TARGETS += dump help

$(if $(DEBUG),$(info PHONY TARGETS: $(PHONY_TARGETS))) ## DEBUG PHONY_TARGETS

.PHONY: $(PHONY_TARGETS)

# Include all .mk files from the makefiles/*.mk source folder.

include $(wildcard makefiles/*.mk)

# The targets below are system functions.

help: # Display this message.
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo ""
	@printf "  \033[36m%-15s\033[0m %s\n" help "Display this message"; \
	for file in $(wildcard makefiles/*.mk); do \
		grep -E '^[a-zA-Z_-]+: #' "$$file" | while read -r line; do \
			target=$$(echo $$line | cut -d':' -f1); \
			help=$$(echo $$line | sed 's/^[a-zA-Z_-]\+: # //'); \
			if [ "$$help" != "" ]; then \
				printf "  \033[36m%-15s\033[0m %s\n" $$target "$$help"; \
			fi; \
		done; \
	done
	@echo ""

dump: ## Output an ancillary make file from makefiles/<target>.mk
	@if [ -z "$(target)" ]; then \
		echo ""; \
		echo "Usage: make sys-dump target=<target>"; \
		echo ""; \
		exit 1; \
	fi
	@file="makefiles/$(target).mk"; \
	if [ -f "$$file" ]; then \
		cat "$$file"; \
	else \
		echo ""; \
		echo "Target $$target.mk file not found in makefiles/"; \
		echo ""; \
	fi

