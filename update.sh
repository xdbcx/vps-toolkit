#!/bin/bash
set -e
APP="/opt/vps-toolkit"
BACKUP="/root/vps-toolkit-backup"
BRANCH="main"

[ "$(id -u)" = "0" ] || { echo "Please run as root"; exit 1; }
[ -d "$APP/.git" ] || { echo "Not a git install, please reinstall."; exit 1; }

mkdir -p "$BACKUP"
cd "$APP"

CURRENT=$(cat version 2>/dev/null || echo unknown)
git fetch origin "$BRANCH" -q
LATEST=$(git show "origin/$BRANCH:version" 2>/dev/null || echo unknown)

echo "Current: $CURRENT"
echo "Latest : $LATEST"

[ "$CURRENT" = "$LATEST" ] && { echo "Already latest"; exit 0; }

tar czf "$BACKUP/toolkit-before-update-$(date +%F-%H%M%S).tar.gz" "$APP" 2>/dev/null || true

TMP_CFG="/tmp/vps-toolkit-config-$(date +%s)"
mkdir -p "$TMP_CFG"
[ -d "$APP/config" ] && cp -a "$APP/config/." "$TMP_CFG/" || true

git reset --hard "origin/$BRANCH" -q

mkdir -p "$APP/config"
cp -a "$TMP_CFG/." "$APP/config/" 2>/dev/null || true
rm -rf "$TMP_CFG"

find "$APP" -name "*.sh" -exec chmod +x {} \;
ln -sf "$APP/vps.sh" /usr/local/bin/vt
ln -sf "$APP/vps.sh" /usr/local/bin/vps-toolkit

echo "Update complete:"
cat "$APP/version"
