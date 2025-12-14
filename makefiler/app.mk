# makefiler/app.mk

app-install: # Install application dependencies.
	@echo "Installing dependencies..."
	@echo "npm install && composer install"

app-lint: # Run code linter.
	@echo "Linting code..."
	@echo "npm run lint"

app-test: # Run application tests.
	@echo "Running tests..."
	@echo "npm test"
