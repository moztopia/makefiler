sample: # Execute the php artisan <args> command 
	@php artisan $(filter-out $@,$(MAKECMDGOALS))

# Catch-all target to handle arguments
%:
	@:
