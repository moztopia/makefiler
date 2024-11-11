backend: # Update backend dependencies
	@cd $(BACKEND_DIR) && \
		composer install && \
		php artisan key:generate