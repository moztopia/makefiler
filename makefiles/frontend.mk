frontend: # Update frontend dependencies
	@echo "updating all npm dependencies..."
	@cd $(FRONTEND_DIR) && \
		npm install