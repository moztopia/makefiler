# Makefiler
![Test Status](https://github.com/moztopia/makefiler/actions/workflows/test.yml/badge.svg)

> **Note:** Full documentation is available in the [Wiki](https://github.com/moztopia/makefiler/wiki).

**Dynamic, self-documenting Makefile system for modern projects.**
 provides a dynamic Makefile system designed to organize and extend your build processes. Instead of a single monolithic Makefile, **Makefiler** allows you to define targets and logic in separate, modular `.mk` files, making your build system more maintainable and scalable.

## Key Features

- **Dynamic Target Loading:** Automatically discovers and includes targets defined in `.mk` files within the `makefiler/` directory. This modular approach keeps your build logic organized and easy to manage.
- **Help Target (`make help`):** Provides a self-documenting system. Running `make help` will list all available targets and their descriptions, which are extracted directly from your `.mk` files.
- **Target File Dumping (`make dump target=<target>`):** A utility for inspecting the contents of individual `.mk` target files, which is ideal for debugging or understanding the definition of a specific target.
- **Optional Variable Overrides:** Customize variables used in your targets via an optional `Makefile.variables` file. This allows you to tailor the build process without modifying the core target definitions.
- **Debug Mode:** Enable debug output by setting the `DEBUG` variable. This outputs extra debug information during make execution, which aids troubleshooting and helps you understand the Makefile’s behavior.

## Installation

The easiest way to install Makefiler in your project is using the installer script:

```bash
# Install to current directory
curl -sL https://raw.githubusercontent.com/moztopia/makefiler/main/install.sh | bash

# Or install to a specific path
curl -sL https://raw.githubusercontent.com/moztopia/makefiler/main/install.sh | bash -s -- /path/to/project

# Or use the single-file Python installer (no git required)
# Download makefiler_installer.py from Releases and run:
python3 makefiler_installer.py
```

Alternatively, you can clone the repository manually:
** from the Makefiler repository into the root of your project.
   - Copy the **`makefiler/` folder** into your project’s root directory.

   This setup installs the dynamic Makefiler system into your project, setting the stage for modular target definitions.

## Usage

Once installed, follow these steps to use Makefiler in your project:

1. **Define Targets in `.mk` Files:**  
   Create or modify `.mk` files in the `makefiler/` directory. For example, you might have:

   - `makefiler/build.mk`
   - `makefiler/deploy.mk`
   - `makefiler/test.mk`

   In each `.mk` file, define your Makefile targets using the normal syntax. **Be sure to add a comment (starting with `# `) after each target definition to provide a short description** that will be used by the `help` target.

   ```makefile
   # makefiler/build.mk

   build: # Compile the application.
   	@echo "Building application..."
   	# ... your build commands ...

   build-docker: # Build a Docker image.
   	@echo "Building Docker image..."
   	# ... your docker build commands ...
   ```

2. **Run Targets:**  
   From your project’s root directory, execute make followed by the target name:

   ```bash
   make build        # Runs the 'build' target
   make build-docker # Runs the 'build-docker' target
   ```

3. **Get Help (`make help`):**  
   To see a formatted list of all available targets and their descriptions, simply run:

   ```bash
   make help
   ```

   The help system will automatically pick up descriptions from the comments in your `.mk` files.

4. **Dump a Target File (`make dump target=<target>`):**  
   If you need to inspect the contents of a specific `.mk` file (for example, to debug or learn its setup), you can run:

   ```bash
   make dump target=build
   ```

   This command will display the contents of `makefiler/build.mk` in your console.

## Customizing Variables with `Makefile.variables` (Optional)

You can override or customize variables used within your `.mk` files by creating a `Makefile.variables` file in the root directory of your project. This step is optional but provides an extra layer of configuration.

1. **Create `Makefile.variables`:**  
   In the same directory as the main `Makefile`, create a file named `Makefile.variables`.

2. **Define Variables:**  
   Add any variables you want to configure. These variables will be available within your `.mk` files. For example:

   ```makefile
   # Makefile.variables

   BACKEND_BUILD_COMMAND = docker-compose -f docker-compose.backend.yml build
   DEPLOY_SERVER_ADDRESS = my-production-server.example.com
   ```

3. **Usage in `.mk` Files:**  
   Your target definitions can now use these variables. For instance:

   ```makefile
   # makefiler/build.mk

   build-backend: # Build the backend application using the custom command.
   	@echo "Building backend using: $(BACKEND_BUILD_COMMAND)"
   	@$(BACKEND_BUILD_COMMAND)

   deploy-backend: # Deploy backend to the custom server address.
   	@echo "Deploying backend to: $(DEPLOY_SERVER_ADDRESS)"
   	# ... deployment commands using $(DEPLOY_SERVER_ADDRESS) ...
   ```

When `Makefile.variables` exists, its variables are automatically included, allowing you to easily customize and reuse build commands without modifying core target definitions.

## Debug Mode

Enable debug output by setting the `DEBUG` variable to any non-blank value. This can be useful for tracing the execution of your targets or troubleshooting issues.

For example, to enable debug mode when viewing the help output:

```bash
DEBUG=1 make help
```

This will print extra debug information (like discovered phony targets) during execution. You can also add additional `$(if $(DEBUG),$(info ...))` statements in your `.mk` files or the main `Makefile` to output variable values or execution traces.

## Directory Structure

- **`Makefile`**: The main dynamic Makefile (copied into your project's root).
- **`Makefile.variables` (optional)**: File for overriding global user variables (in your project's root).
- **`makefiler/`**: Directory containing `.mk` files that each define a set of related targets (copied into your project's root).

## Contributing

Contributions to improve **Makefiler** are welcome! Please feel free to submit pull requests or open issues for bug reports, feature requests, or suggestions for improvement.
