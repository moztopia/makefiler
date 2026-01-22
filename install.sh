#!/bin/bash
set -e

REPO_URL="https://github.com/moztopia/makefiler.git"
TARGET_DIR="${1:-.}"
TEMP_DIR=$(mktemp -d)

echo "Installing Makefiler to $TARGET_DIR..."

# Clone to temp dir
git clone --depth 1 "$REPO_URL" "$TEMP_DIR" > /dev/null 2>&1

# Copy files
cp "$TEMP_DIR/Makefile" "$TARGET_DIR/"
mkdir -p "$TARGET_DIR/makefiler"
cp -r "$TEMP_DIR/makefiler/"* "$TARGET_DIR/makefiler/"

# Cleanup
rm -rf "$TEMP_DIR"

echo "✅ Makefiler installed successfully!"
echo "Run 'make help' to get started."
