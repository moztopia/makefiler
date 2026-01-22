# Changelog

All notable changes to this project will be documented in this file.

## [0.0.9] - 2025-12-14


### Added
- **Smart Argument Handling:** Global catch-all target that intelligently differentiates between valid arguments and typos.
- **Dynamic Help System:** `make help` now parses comments from all loaded `.mk` files.
- **Example Makefiles:** `docker.mk`, `git.mk`, `db.mk`, `app.mk` included in `makefiler/` directory.
- **Installer:** `install.sh` script for easy setup.
- **GitHub Actions:** Automated test suite on push/PR.
- **Comprehensive Documentation:** Moved documentation to a comprehensive Wiki structure.

### Changed
- **Directory Structure:** All logic moved to `makefiler/` with a main entry point `Makefile`.
- **Versioning:** Bumped to v1.0.0 suitable for production use.
