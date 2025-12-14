# makefiler/git.mk

git-sync: # Pull latest changes with rebase.
	@echo "Syncing with remote..."
	@echo "git pull --rebase"

git-clean: # Clean untracked files (simulation).
	@echo "Cleaning untracked files..."
	@echo "git clean -fd"

git-status: # Show git status.
	@echo "Checking status..."
	@echo "git status"
