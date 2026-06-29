#!/bin/bash

# Gneol Installer
# Downloads the correct platform archive (tar.gz) containing CLI, brain, and Prisma engine

set -e

REPO="Gneol/Gneol"
VERSION="latest"
INSTALL_DIR="/usr/local/bin"

# Parse flags
while [[ $# -gt 0 ]]; do
  case $1 in
    --version)
      VERSION="$2"
      shift 2
      ;;
    --dir)
      INSTALL_DIR="$2"
      shift 2
      ;;
    *)
      echo "Usage: $0 [--version <tag>] [--dir <path>]"
      exit 1
      ;;
  esac
done

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Normalize arch and set archive name
case "$ARCH" in
  x86_64) ARCH="x64" ;;
  aarch64) ARCH="arm64" ;;
  arm64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

case "$OS" in
  linux) PLATFORM="linux-x64" ;;
  darwin) PLATFORM="darwin-arm64" ;;
  *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

ARCHIVE="gneol-${PLATFORM}.tar.gz"

if [ "$VERSION" = "latest" ]; then
  BASE_URL="https://github.com/$REPO/releases/latest/download"
else
  BASE_URL="https://github.com/$REPO/releases/download/$VERSION"
fi

echo "📦 Downloading Gneol for $PLATFORM..."
echo ""

TMP_ARCHIVE="/tmp/gneol-${PLATFORM}.tar.gz"

# Download archive
ARCHIVE_URL="$BASE_URL/$ARCHIVE"
echo "  → $ARCHIVE"
curl -sSL "$ARCHIVE_URL" -o "$TMP_ARCHIVE"

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Extract archive into install directory
tar -xzf "$TMP_ARCHIVE" -C "$INSTALL_DIR"

# Set permissions
chmod +x "$INSTALL_DIR/gneol"
chmod +x "$INSTALL_DIR/gneol-brain"

# Clean up
rm -f "$TMP_ARCHIVE"

echo ""
echo "✅ Gneol installed!"
echo "   gneol              → $INSTALL_DIR/gneol"
echo "   gneol-brain         → $INSTALL_DIR/gneol-brain"
echo "   Prisma engine      → $INSTALL_DIR/*.dylib.node or *.so.node"
echo ""
echo "Starting Gneol server..."
"$INSTALL_DIR/gneol" server start

echo "Run 'gneol --help' to get started."
