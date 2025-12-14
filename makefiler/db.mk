# makefiler/db.mk

db-migrate: # Run database migrations.
	@echo "Running migrations..."
	@echo "php artisan migrate"

db-seed: # Seed the database.
	@echo "Seeding database..."
	@echo "php artisan db:seed"

db-reset: # Reset, migrate, and seed the database.
	@echo "Resetting database..."
	@echo "php artisan migrate:refresh --seed"
