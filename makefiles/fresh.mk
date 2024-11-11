# Define the fresh target
fresh: # Prompt to delete all data and start over fresh
	@echo "This will delete all data and start over fresh. No data will be preserved. Are you sure? (yes/no)"
	@read -r confirmation && if [ "$$confirmation" = "yes" ]; then \
		echo ""
		echo "Stopping all containers..."; \
		docker compose down; \
		echo "Deleting all containers, images, volumes, and logs..."; \
		docker system prune -a --volumes -f; \
		echo "Waiting for 30 seconds..."; \
		sleep 30; \
		echo "Building all containers..."; \
		docker compose build --no-cache; \
		echo "Starting all containers..."; \
		docker compose up --force-recreate -d; \
		echo "Waiting for 30 seconds..."; \
		sleep 30; \
		echo "Running migrations..."; \
		docker compose exec php php artisan migrate; \
		echo "Seeding database..."; \
		docker compose exec php php artisan db:seed; \
	else \
		echo "Operation cancelled."; \
	fi
