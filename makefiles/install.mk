install: # Create database, install dependencies and start your containers.
	@cp $(BACKEND_DIR)/.env.example $(BACKEND_DIR)/.env
	#@echo "copying .env.example to .env"
	#@chmod ugo+rw .docker/mssql/mssqlsystem
	#@chmod ugo+rw .docker/mssql/mssqluser
	@$(MAKE) .env
	@$(MAKE) backend
	@$(MAKE) webapp
	@$(MAKE) start