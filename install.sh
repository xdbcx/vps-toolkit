#!/bin/bash
set -e

INSTALL_DIR="/opt/vps-toolkit"
REPO="https://github.com/xdbcx/vps-toolkit.git"

if [ "$(id -u)" != "0" ]; then
    echo "Please run as root"
    exit 1
fi

echo "================================"
echo " VPS Toolkit Installer"
echo "================================"

# Install git if missing
if ! command -v git >/dev/null 2>&1; then
    echo "Installing git..."
    apt update
    apt install -y git
fi

# Backup old installation
if [ -d "$INSTALL_DIR" ]; then
    echo "Existing installation detected"

    BACKUP="/root/vps-toolkit-backup/install-$(date +%F-%H%M%S)"
    mkdir -p "$BACKUP"
    cp -a "$INSTALL_DIR" "$BACKUP/" || true

    echo "Backup saved:"
    echo "$BACKUP"
fi

# Download latest source
rm -rf /tmp/vps-toolkit-install

echo "Downloading repository..."

git clone -q "$REPO" /tmp/vps-toolkit-install

# Install
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

cp -a /tmp/vps-toolkit-install/. "$INSTALL_DIR/"

# Permission
find "$INSTALL_DIR" -name "*.sh" -exec chmod +x {} \;

# Command shortcut
ln -sf "$INSTALL_DIR/vps-toolkit.sh" /usr/local/bin/vps-toolkit

echo
echo "================================"
echo " VPS Toolkit Installed"
echo "================================"

if [ -f "$INSTALL_DIR/version" ]; then
    echo "Version:"
    cat "$INSTALL_DIR/version"
fi

echo
echo "Run:"
echo "vps-toolkit"
