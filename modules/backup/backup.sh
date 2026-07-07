#!/bin/bash
BACKUP_DIR="/root/vps-toolkit-backup"
mkdir -p "$BACKUP_DIR"
[ -d /usr/local/x-ui ] || [ -d /etc/x-ui ] && tar czf "$BACKUP_DIR/xui-$(date +%F-%H%M%S).tar.gz" /usr/local/x-ui /etc/x-ui 2>/dev/null || true
[ -d /etc/wireguard ] && tar czf "$BACKUP_DIR/wireguard-$(date +%F-%H%M%S).tar.gz" /etc/wireguard 2>/dev/null || true
echo "Backup dir: $BACKUP_DIR"
ls -lh "$BACKUP_DIR" | tail -20
