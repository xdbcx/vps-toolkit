#!/bin/bash

mkdir -p /root/vps-toolkit-backup

tar czf /root/vps-toolkit-backup/xui-$(date +%F).tar.gz /etc/x-ui /usr/local/x-ui 2>/dev/null || true
tar czf /root/vps-toolkit-backup/wg-$(date +%F).tar.gz /etc/wireguard 2>/dev/null || true

echo Backup completed
