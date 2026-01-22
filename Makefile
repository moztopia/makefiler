# Main Dynamic Makefile
VERSION := 0.0.9



DEBUG := ## Set to any value to include extra debug information in the output. Note, only a blank value will turn off DEBUG.

# Define the directory where the makefiles are located
MAKEFILES_DIR := makefiler

# Check if Makefile.variables exists and include it if it does
-include Makefile.variables

# Define PHONY targets dynamically from .mk files
PHONY_TARGETS := $(basename $(notdir $(wildcard $(MAKEFILES_DIR)/*.mk)))
PHONY_TARGETS += dump help

.PHONY: $(PHONY_TARGETS)

# Include all .mk files from the makefiles directory
include $(wildcard $(MAKEFILES_DIR)/*.mk)

# Define known targets dynamically
ALL_MK_TARGETS := $(shell grep -h -E '^[a-zA-Z0-9_-]+:' $(MAKEFILES_DIR)/*.mk | cut -d: -f1)
KNOWN_TARGETS := $(PHONY_TARGETS) $(ALL_MK_TARGETS)

# Empty rule for Makefile.variables to prevent it from being caught by the catch-all
Makefile.variables:

%:
	@if [ -z "$(filter $(KNOWN_TARGETS),$(MAKECMDGOALS))" ]; then \
		echo ""; \
		printf "\033[31mError: No rule to make target '$@'\033[0m\n"; \
		echo ""; \
		$(MAKE) -s help; \
		exit 1; \
	fi

dump: # Dump the contents of all included makefiles.
	@echo "Dumping included makefiles:"
	@cat $(wildcard $(MAKEFILES_DIR)/*.mk)

help: # Display this message.
	@echo "Makefiler v$(VERSION)"
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo ""
	@printf "  \033[36m%-20s\033[0m %s\n" help "     Display this message"; \
	for file in $(wildcard $(MAKEFILES_DIR)/*.mk); do \
		grep -E '^[a-zA-Z_-]+: #' "$$file" | while read -r line; do \
			target=$$(echo $$line | cut -d':' -f1); \
			help=$$(echo $$line | sed 's/^[a-zA-Z_-]\+: # //'); \
			if [ "$$help" != "" ]; then \
				printf "  \033[36m%-20s\033[0m %s\n" $$target "     $$help"; \
			fi; \
		done; \
	done