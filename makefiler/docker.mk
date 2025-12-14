# makefiler/docker.mk

docker-up: # Start Docker containers in detached mode.
	@echo "Starting Docker containers..."
	@echo "docker-compose up -d"

docker-down: # Stop Docker containers.
	@echo "Stopping Docker containers..."
	@echo "docker-compose down"

docker-logs: # View Docker logs (follow).
	@echo "Following Docker logs..."
	@echo "docker-compose logs -f"

docker-build: # Build Docker images.
	@echo "Building Docker images..."
	@echo "docker-compose build"
