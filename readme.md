Makefile System Documentation

This project uses a modular Makefile system to automate various development tasks efficiently. It's designed for maintainability and flexibility, with each task defined in its own .mk file within the makefiles directory.
Directory Structure
project/
├── makefiles/
│ ├── backend.mk
│ ├── frontend.mk
│ ├── install.mk
│ └── other_task.mk
├── Makefile
├── README.md

Main Makefile
The central Makefile dynamically includes all .mk files from the makefiles directory and handles common configurations, including:
Declaring .PHONY targets (targets that aren't actual files)
Providing a dynamic help system
Dynamic Inclusion of .mk Files
Here's how the main Makefile incorporates all .mk files:

Makefile

# Main Makefile

# Dynamically include all .mk files

include $(wildcard makefiles/\*.mk)

# Define the .PHONY list

PHONY_TARGETS := $(basename $(notdir $(wildcard makefiles/\*.mk))).PHONY: $(PHONY_TARGETS)

# Print the PHONY_TARGETS

$(info PHONY TARGETS: $(PHONY_TARGETS))

This code achieves the following:
Includes all .mk files using wildcards.
Defines a variable PHONY_TARGETS that lists all target names from .mk files (excluding directories).
Creates a .PHONY rule for each target, ensuring they are always rebuilt, even if no source files have changed.
Prints the list of available targets for information.
Dynamic Help System
The help system automatically generates a list of available targets by scanning comments in .mk files after each target definition.
makefiles/help.mk:

Makefile

# makefiles/help.mk

help: ## Display help message from all makefiles.
@echo "Usage: make <target>"
@echo ""
@echo "Targets:"
@for file in $(wildcard makefiles/*.mk); do \
        grep -E '^[a-zA-Z_-]+: #' $$file | while read -r line; do \
 target=$$(echo $$line | cut -d':' -f1); \
            help=$$(echo $$line | sed 's/^[a-zA-Z_-]\+: # //'); \
            printf "  \033[36m%-15s\033[0m %s\n" $$target "$$help"; \
 done; \
 done

Explanation:
This target reads comments (#) following target definitions in all .mk files.
It parses the comments to extract the target name and its description.
The output is formatted with color codes for better readability (ANSI escape codes).
Adding New Targets
To introduce a new target:
Create a new .mk file within the makefiles directory.
Define the target followed by a comment explaining its purpose.
Example:

Makefile

# makefiles/newtask.mk

newtask: # This is a new task.
@echo "Running new task"

Making Targets Invisible to Help
Certain targets might not be intended for general usage. You can make them invisible to the help command by adding an extra dummy target with a comment prefixed by ## (two hash symbols) after the actual target.
Example of Invisible Target

Makefile

# makefiles/secret.mk

secret: ## Help will not display this task.
@echo "Running secret task"

By including the dummy target with a comment starting with ##, the actual target secret won't be listed in the help output.
Usage
Display Help

Bash

make help

This will print a message similar to:

Usage: make <target>

Targets:
install Create database, install dependencies, and start your containers.
.env Create .env file for docker-compose.yml.
backend Update backend dependencies.
frontend Update frontend dependencies.
stop Stop all containers.
help Display help message from all makefiles.

Running a Task
Use the following command to execute a specific target:

Bash

make <target>

For instance, to run the install target:

Bash

make install

Contributing
We welcome contributions!
