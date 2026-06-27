#!/bin/bash

# Gneol Installer
# Downloads the correct binaries for your OS and architecture

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

# Normalize arch
case "$ARCH" in
  x86_64) ARCH="x64" ;;
  aarch64) ARCH="arm64" ;;
  arm64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Select download URLs
if [ "$OS" = "linux" ]; then
  CLI_BINARY="gneol-linux"
  BRAIN_BINARY="gneol-brain-linux"
elif [ "$OS" = "darwin" ]; then
  CLI_BINARY="gneol-darwin"
  BRAIN_BINARY="gneol-brain-darwin"
else
  echo "Unsupported OS: $OS"
  exit 1
fi

if [ "$VERSION" = "latest" ]; then
  BASE_URL="https://github.com/$REPO/releases/latest/download"
else
  BASE_URL="https://github.com/$REPO/releases/download/$VERSION"
fi

echo "📦 Downloading Gneol binaries for $OS-$ARCH..."
echo ""

# Download CLI
CLI_URL="$BASE_URL/$CLI_BINARY"
echo "  → $CLI_BINARY"
curl -sSL "$CLI_URL" -o "$INSTALL_DIR/gneol"
chmod +x "$INSTALL_DIR/gneol"

# Download Brain
BRAIN_URL="$BASE_URL/$BRAIN_BINARY"
echo "  → $BRAIN_BINARY"
curl -sSL "$BRAIN_URL" -o "$INSTALL_DIR/gneol-brain"
chmod +x "$INSTALL_DIR/gneol-brain"

echo ""
echo "✅ Gneol installed!"
echo "   gneol      → $INSTALL_DIR/gneol"
echo "   gneol-brain → $INSTALL_DIR/gneol-brain"
echo ""
echo "Run 'gneol --help' to get started."
