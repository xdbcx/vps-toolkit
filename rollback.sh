#!/bin/bash
set -e
APP="/opt/vps-toolkit"
BACKUP_DIR="/root/vps-toolkit-backup"
LAST=$(ls -t "$BACKUP_DIR"/toolkit-before-update-*.tar.gz 2>/dev/null | head -1)
[ -n "$LAST" ] || { echo "No update backup found"; exit 1; }
rm -rf "$APP"
tar xzf "$LAST" -C /
find "$APP" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
ln -sf "$APP/vps.sh" /usr/local/bin/vt
ln -sf "$APP/vps.sh" /usr/local/bin/vps-toolkit
echo "Rollback complete"
cat "$APP/version" 2>/dev/null || true
