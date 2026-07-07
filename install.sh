#!/bin/bash
set -e
INSTALL_DIR="/opt/vps-toolkit"
REPO="https://github.com/xdbcx/vps-toolkit.git"
BRANCH="main"

[ "$(id -u)" = "0" ] || { echo "Please run as root"; exit 1; }

echo "=== VPS Toolkit Installer ==="

if ! command -v git >/dev/null 2>&1; then
    apt update
    apt install -y git
fi

if [ -d "$INSTALL_DIR" ]; then
    BACKUP="/root/vps-toolkit-backup/install-$(date +%F-%H%M%S)"
    mkdir -p "$BACKUP"
    cp -a "$INSTALL_DIR" "$BACKUP/" || true
    echo "Old backup: $BACKUP"
fi

rm -rf /tmp/vps-toolkit-install
git clone -q -b "$BRANCH" "$REPO" /tmp/vps-toolkit-install

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
cp -a /tmp/vps-toolkit-install/. "$INSTALL_DIR/"

find "$INSTALL_DIR" -name "*.sh" -exec chmod +x {} \;
ln -sf "$INSTALL_DIR/vps.sh" /usr/local/bin/vt
ln -sf "$INSTALL_DIR/vps.sh" /usr/local/bin/vps-toolkit

echo "Checking modules..."
for f in \
"$INSTALL_DIR/modules/optimize/vps-lite.sh" \
"$INSTALL_DIR/modules/optimize/tcp.sh" \
"$INSTALL_DIR/modules/optimize/log-clean.sh" \
"$INSTALL_DIR/modules/network/iperf3.sh" \
"$INSTALL_DIR/modules/warp/log-check.sh" \
"$INSTALL_DIR/modules/proxy/xui-check.sh" \
"$INSTALL_DIR/modules/wireguard/wg-check.sh"
do
    [ -f "$f" ] && echo "OK: $f" || echo "MISSING: $f"
done

echo
echo "Installed version:"
cat "$INSTALL_DIR/version" 2>/dev/null || true
echo "Run: vt"
