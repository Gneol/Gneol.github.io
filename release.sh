#!/bin/bash

# Gneol Release Script
# Builds, tags, and uploads binaries to GitHub Releases
# Requires: gh (GitHub CLI) authenticated

set -e

VERSION="$1"
NOTES="$2"

if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version-tag> [release-notes]"
  echo "Example: $0 v0.2.5 'Bug fixes and performance improvements'"
  exit 1
fi

# Ensure gh is installed
if ! command -v gh &> /dev/null; then
  echo "❌ GitHub CLI (gh) not found. Install it first:"
  echo "   brew install gh"
  exit 1
fi

# Ensure authenticated
if ! gh auth status &> /dev/null; then
  echo "❌ Not authenticated with GitHub. Run 'gh auth login' first."
  exit 1
fi

# Ensure this repo is set up
git rev-parse --git-dir &> /dev/null || {
  echo "❌ Not a git repository. Run 'git init && git remote add origin <url>' first."
  exit 1
}

BIN_DIR="./bin"
if [ ! -d "$BIN_DIR" ]; then
  echo "❌ Binaries directory ($BIN_DIR) not found. Run copy-binaries.sh first."
  exit 1
fi

echo "🏷️  Tagging release $VERSION..."
git tag -f "$VERSION"
git push origin "$VERSION" --force

echo "🚀 Creating GitHub Release..."
if [ -z "$NOTES" ]; then
  gh release create "$VERSION" \
    "$BIN_DIR/gneol-darwin" \
    "$BIN_DIR/gneol-brain-darwin" \
    "$BIN_DIR/gneol-linux" \
    "$BIN_DIR/gneol-brain-linux" \
    --title "$VERSION" \
    --generate-notes
else
  gh release create "$VERSION" \
    "$BIN_DIR/gneol-darwin" \
    "$BIN_DIR/gneol-brain-darwin" \
    "$BIN_DIR/gneol-linux" \
    "$BIN_DIR/gneol-brain-linux" \
    --title "$VERSION" \
    --notes "$NOTES"
fi

echo "✅ Release $VERSION created and uploaded!"
echo "   https://github.com/Gneol/Gneol/releases/tag/$VERSION"
