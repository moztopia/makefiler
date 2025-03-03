# makefiler/clear-everything.mk

clear-everything: # Clear all Laravel caches, compiled files, and optimize autoload.
	@php artisan route:clear
	@php artisan config:clear
	@php artisan view:clear
	@php artisan cache:clear
	@php artisan clear-compiled
	@php artisan optimize:clear
	@composer dump-autoload -o