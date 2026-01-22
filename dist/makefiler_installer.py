#!/usr/bin/env python3
import os
import sys

# Embedded Files
FILES = {
    "Makefile": "# Main Dynamic Makefile\nVERSION := 0.0.9\n\n\n\nDEBUG := ## Set to any value to include extra debug information in the output. Note, only a blank value will turn off DEBUG.\n\n# Define the directory where the makefiles are located\nMAKEFILES_DIR := makefiler\n\n# Check if Makefile.variables exists and include it if it does\n-include Makefile.variables\n\n# Define PHONY targets dynamically from .mk files\nPHONY_TARGETS := $(basename $(notdir $(wildcard $(MAKEFILES_DIR)/*.mk)))\nPHONY_TARGETS += dump help\n\n.PHONY: $(PHONY_TARGETS)\n\n# Include all .mk files from the makefiles directory\ninclude $(wildcard $(MAKEFILES_DIR)/*.mk)\n\n# Define known targets dynamically\nALL_MK_TARGETS := $(shell grep -h -E '^[a-zA-Z0-9_-]+:' $(MAKEFILES_DIR)/*.mk | cut -d: -f1)\nKNOWN_TARGETS := $(PHONY_TARGETS) $(ALL_MK_TARGETS)\n\n# Empty rule for Makefile.variables to prevent it from being caught by the catch-all\nMakefile.variables:\n\n%:\n\t@if [ -z \"$(filter $(KNOWN_TARGETS),$(MAKECMDGOALS))\" ]; then \\\n\t\techo \"\"; \\\n\t\tprintf \"\\033[31mError: No rule to make target '$@'\\033[0m\\n\"; \\\n\t\techo \"\"; \\\n\t\t$(MAKE) -s help; \\\n\t\texit 1; \\\n\tfi\n\ndump: # Dump the contents of all included makefiles.\n\t@echo \"Dumping included makefiles:\"\n\t@cat $(wildcard $(MAKEFILES_DIR)/*.mk)\n\nhelp: # Display this message.\n\t@echo \"Makefiler v$(VERSION)\"\n\t@echo \"Usage: make <target>\"\n\t@echo \"\"\n\t@echo \"Targets:\"\n\t@echo \"\"\n\t@printf \"  \\033[36m%-20s\\033[0m %s\\n\" help \"     Display this message\"; \\\n\tfor file in $(wildcard $(MAKEFILES_DIR)/*.mk); do \\\n\t\tgrep -E '^[a-zA-Z_-]+: #' \"$$file\" | while read -r line; do \\\n\t\t\ttarget=$$(echo $$line | cut -d':' -f1); \\\n\t\t\thelp=$$(echo $$line | sed 's/^[a-zA-Z_-]\\+: # //'); \\\n\t\t\tif [ \"$$help\" != \"\" ]; then \\\n\t\t\t\tprintf \"  \\033[36m%-20s\\033[0m %s\\n\" $$target \"     $$help\"; \\\n\t\t\tfi; \\\n\t\tdone; \\\n\tdone",
    "makefiler/docker.mk": "# makefiler/docker.mk\n\ndocker-up: # Start Docker containers in detached mode.\n\t@echo \"Starting Docker containers...\"\n\t@echo \"docker-compose up -d\"\n\ndocker-down: # Stop Docker containers.\n\t@echo \"Stopping Docker containers...\"\n\t@echo \"docker-compose down\"\n\ndocker-logs: # View Docker logs (follow).\n\t@echo \"Following Docker logs...\"\n\t@echo \"docker-compose logs -f\"\n\ndocker-build: # Build Docker images.\n\t@echo \"Building Docker images...\"\n\t@echo \"docker-compose build\"\n",
    "makefiler/utils.mk": "# makefiler/utils.mk\n\necho-args: # Echo arguments passed to this target.\n\t@echo \"Arguments received:\"\n\t@for arg in $(filter-out $@,$(MAKECMDGOALS)); do \\\n\t\techo \"- $$arg\"; \\\n\tdone\n\nwait: # Simulate a long running process (sleep 1).\n\t@echo \"Waiting for 1 second...\"\n\t@sleep 1\n\t@echo \"Done waiting.\"\n",
    "makefiler/git.mk": "# makefiler/git.mk\n\ngit-sync: # Pull latest changes with rebase.\n\t@echo \"Syncing with remote...\"\n\t@echo \"git pull --rebase\"\n\ngit-clean: # Clean untracked files (simulation).\n\t@echo \"Cleaning untracked files...\"\n\t@echo \"git clean -fd\"\n\ngit-status: # Show git status.\n\t@echo \"Checking status...\"\n\t@echo \"git status\"\n",
    "makefiler/app.mk": "# makefiler/app.mk\n\napp-install: # Install application dependencies.\n\t@echo \"Installing dependencies...\"\n\t@echo \"npm install && composer install\"\n\napp-lint: # Run code linter.\n\t@echo \"Linting code...\"\n\t@echo \"npm run lint\"\n\napp-test: # Run application tests.\n\t@echo \"Running tests...\"\n\t@echo \"npm test\"\n",
    "makefiler/clear-everything.mk": "# makefiler/clear-everything.mk\n\nclear-everything: # Clear all Laravel caches, compiled files, and optimize autoload.\n\t@php artisan route:clear\n\t@php artisan config:clear\n\t@php artisan view:clear\n\t@php artisan cache:clear\n\t@php artisan clear-compiled\n\t@php artisan optimize:clear\n\t@composer dump-autoload -o",
    "makefiler/sample.mk": "sample: # Execute the php artisan <args> command \n\t@php artisan $(filter-out $@,$(MAKECMDGOALS))\n\n",
    "makefiler/db.mk": "# makefiler/db.mk\n\ndb-migrate: # Run database migrations.\n\t@echo \"Running migrations...\"\n\t@echo \"php artisan migrate\"\n\ndb-seed: # Seed the database.\n\t@echo \"Seeding database...\"\n\t@echo \"php artisan db:seed\"\n\ndb-reset: # Reset, migrate, and seed the database.\n\t@echo \"Resetting database...\"\n\t@echo \"php artisan migrate:refresh --seed\"\n"
}

def install(target_dir):
    if not os.path.exists(target_dir):
        try:
            os.makedirs(target_dir)
        except OSError as e:
            print(f"Error creating directory {{target_dir}}: {{e}}")
            sys.exit(1)

    print(f"Installing Makefiler to {target_dir}...")

    for file_path, content in FILES.items():
        full_path = os.path.join(target_dir, file_path)
        dir_name = os.path.dirname(full_path)
        
        if dir_name and not os.path.exists(dir_name):
            os.makedirs(dir_name)
            
        with open(full_path, "w", encoding="utf-8") as f:
            f.write(content)
        
        print(f"  Created {file_path}")

    print(f"\n✅ Makefiler installed successfully in {target_dir}!")
    print("Run 'make help' to get started.")

if __name__ == "__main__":
    target = "."
    if len(sys.argv) > 1:
        target = sys.argv[1]
    
    abs_target = os.path.abspath(target)
    
    # ANSI colors
    RED = "\033[31m"
    RESET = "\033[0m"
    
    print(f"We are getting ready to install makefiler {RED}{abs_target}{RESET}.")
    response = input("Are you sure? y/N ").strip().lower()
    
    if response != 'y':
        print("Installation aborted.")
        sys.exit(0)
        
    install(target)
