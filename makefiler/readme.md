````markdown
# Makefiler: Dynamic Makefile System

This project provides a dynamic Makefile system designed to organize and extend your build processes. Instead of a single monolithic Makefile, `Makefiler` allows you to define targets and logic in separate, modular `.mk` files, making your build system more maintainable and scalable.

## Key Features

- **Dynamic Target Loading:** Automatically discovers and includes targets defined in `.mk` files within the `makefiler/` directory. This modular approach keeps your build logic organized and easy to manage.
- **Help Target (`make help`):** Provides a self-documenting system. Running `make help` will list all available targets and their descriptions, which are extracted directly from your `.mk` files.
- **Target File Dumping (`make dump target=<target>`):** The `dump` target is a utility for inspecting the contents of individual `.mk` target files. This is useful for debugging or understanding the definition of a specific target.
- **Optional Variable Overrides:** Allows for customization of Makefile variables through an optional `Makefile.variables` file. This lets you tailor the build process without directly modifying the core `Makefile` or target definitions.
- **Debug Mode:** A `DEBUG` variable can be enabled to output extra debug information during `make` execution, aiding in troubleshooting and understanding the Makefile's behavior.

## Usage

1.  **Clone or Copy `Makefiler` into your project.**

2.  **Define Targets in `.mk` Files:**

    - Create new `.mk` files within the `makefiler/` directory (e.g., `makefiler/build.mk`, `makefiler/deploy.mk`, `makefiler/test.mk`).
    - Inside each `.mk` file, define your `make` targets as you normally would.
    - **Crucially, add a comment after each target definition starting with `# ` (hash followed by a space) to provide a description for the `help` target.**

    ```makefile
    # makefiler/build.mk

    build: # Compile the application.
    	@echo "Building application..."
    	# ... your build commands ...

    build-docker: # Build a Docker image.
    	@echo "Building Docker image..."
    	# ... your docker build commands ...
    ```

3.  **Run `make <target>`:** From your project's root directory, execute `make` followed by the name of the target you want to run.

    ```bash
    make build        # Runs the 'build' target (if defined in a .mk file)
    make build-docker # Runs the 'build-docker' target
    ```

4.  **Get Help (`make help`):** To see a list of all available targets and their descriptions, run:

    ```bash
    make help
    ```

    This will output a formatted list of targets and their descriptions extracted from your `.mk` files.

5.  **Dump Target File (`make dump target=<target>`):** To view the contents of a specific `.mk` file (e.g., `makefiler/build.mk`), run:

    ```bash
    make dump target=build
    ```

    This will print the content of `makefiler/build.mk` to your console.

## Customizing Variables with `Makefile.variables` (Optional)

You can customize certain variables used in the `Makefile` system without directly modifying the main `Makefile`.

1.  **Create `Makefile.variables`:** In the same directory as the main `Makefile`, create a file named `Makefile.variables`.

2.  **Define Variables:** Inside `Makefile.variables`, define any variables you want to override. For example:

    ```makefile
    # Makefile.variables

    BACKEND_DIR = custom_backend_path
    CONTAINER_PHP = docker-compose exec app php
    ```

    These variables defined in `Makefile.variables` will take precedence over any default variables defined in the main `Makefile`.

3.  **Run `make`:** The `Makefile` will automatically include `Makefile.variables` if it exists, applying your custom variable settings. If `Makefile.variables` does not exist, the default variables in the main `Makefile` will be used.

## Debug Mode

To enable debug output, set the `DEBUG` variable to any non-blank value. This can be done in your environment or directly in the `Makefile` (though environment variables are generally preferred for debug flags).

For example, to enable debug mode when running `make help`:

```bash
DEBUG=1 make help
```
````

Currently, debug mode outputs information about the discovered phony targets. You can extend the debug output by adding `$(if $(DEBUG),$(info ...))` statements in your `.mk` files or the main `Makefile` to trace variable values or execution flow.

## Directory Structure

- **`Makefile`**: The main dynamic Makefile.
- **`Makefile.variables` (optional)**: File for overriding default variables.
- **`makefiler/`**: Directory containing `.mk` files, each defining a set of related targets.

## Contributing

Contributions to improve `Makefiler` are welcome! Please feel free to submit pull requests or open issues for bug reports, feature requests, or suggestions for improvement.

---

This `README.md` provides a comprehensive overview of the `Makefiler` system, making it easier for users to understand, use, and extend its functionality for their projects.

```

```
