#!/usr/bin/env bash
set -e

echo "  CINDER — Sandboxed Terminal Browser"
echo ""

# Detect Termux vs Linux
if command -v pkg &>/dev/null; then
    PM="pkg"
    PREFIX="/data/data/com.termux/files/usr"
elif command -v apt-get &>/dev/null; then
    PM="apt-get"
    PREFIX="/usr/local"
else
    echo "Unsupported package manager. Install manually:"
    echo "  pip install ."
    exit 1
fi

echo "  Installing dependencies via $PM..."
if [ "$PM" = "pkg" ]; then
    $PM update -y 2>/dev/null || true
    $PM install -y python3 links w3m chafa catimg 2>/dev/null || true
else
    sudo $PM update -y 2>/dev/null || true
    sudo $PM install -y python3 links2 w3m chafa catimg 2>/dev/null || true
fi

# Install cinder
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
install -m 755 "$SCRIPT_DIR/cinder" "$PREFIX/bin/cinder"

echo "  Done! Run: cinder new https://example.com"
