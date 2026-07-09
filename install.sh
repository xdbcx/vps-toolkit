#!/bin/bash
set -e

INSTALL_DIR="/opt/vps-toolkit"
REPO="https://github.com/xdbcx/vps-toolkit.git"

echo "Installing VPS Toolkit..."

if ! command -v git >/dev/null 2>&1; then
    apt update
    apt install -y git
fi

rm -rf /tmp/vps-toolkit-install
git clone -q "$REPO" /tmp/vps-toolkit-install

if [ ! -f /tmp/vps-toolkit-install/version ]; then
    echo "ERROR: version file missing"
    exit 1
fi

rm -rf "$INSTALL_DIR"
mv /tmp/vps-toolkit-install "$INSTALL_DIR"

find "$INSTALL_DIR" -name "*.sh" -exec chmod +x {} \;

ln -sf "$INSTALL_DIR/vps.sh" /usr/local/bin/vt
ln -sf "$INSTALL_DIR/vps.sh" /usr/local/bin/vps-toolkit

echo "VPS Toolkit installed"
cat "$INSTALL_DIR/version"
