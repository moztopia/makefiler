# makefiler/utils.mk

echo-args: # Echo arguments passed to this target.
	@echo "Arguments received:"
	@for arg in $(filter-out $@,$(MAKECMDGOALS)); do \
		echo "- $$arg"; \
	done

wait: # Simulate a long running process (sleep 1).
	@echo "Waiting for 1 second..."
	@sleep 1
	@echo "Done waiting."
