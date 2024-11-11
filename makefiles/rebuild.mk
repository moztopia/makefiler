rebuild: # Delete all containers and build them again.
	@docker compose down
	@docker compose build --no-cache
