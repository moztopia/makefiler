Dynamic Makefile System
This project uses a dynamic Makefile system to organize and automate various tasks. The Makefile system is structured to be maintainable and modular, with each task defined in its own separate .mk file located in the makefiles directory.

Overview
The main Makefile dynamically includes all .mk files from the makefiles directory. This allows you to easily manage different tasks without cluttering the main Makefile.

Custom Variables
The Makefile includes custom variables that the end user can set based on their project's needs. These variables typically include paths and container names such as:

BACKEND_DIR: Specifies the directory where the backend code is located.

FRONTEND_DIR: Specifies the directory where the frontend code is located.

CONTAINER_PHP: Specifies the name of the PHP container.

Debugging
The DEBUG variable is used to control the inclusion of debug information in the output. Setting this variable to any value will enable debug messages, while leaving it blank will turn off debug messages.

Dynamic .PHONY List
The Makefile dynamically generates a list of .PHONY targets. .PHONY targets are special targets in Makefiles that are not associated with actual files. This dynamic list includes all targets from the .mk files as well as some system functions such as dump and help.

System Functions
Help

The help target displays a list of all available targets along with their descriptions. It scans all .mk files in the makefiles directory, extracts the targets, and prints them out in a formatted way.

Dump

The dump target outputs the content of a specified target's .mk file from the makefiles directory. This is useful for viewing the specific make commands associated with a particular target.

Usage
Display Help: To display the help message with available targets, use the command make help.

Dump a Target File: To dump the content of a specific target's .mk file, use make dump target=<target_name>. Replace <target_name> with the actual name of the target whose .mk file you want to view.

Conclusion
This dynamic Makefile system is designed to be modular and maintainable, making it easier to manage and extend for complex projects. By separating each task into its own .mk file, you can keep your build and automation scripts organized and easy to understand.
