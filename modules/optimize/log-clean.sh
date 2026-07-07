#!/bin/bash
echo "===== Memory / Log Optimize ====="
free -h
journalctl --disk-usage 2>/dev/null || true
journalctl --vacuum-size=100M 2>/dev/null || true
mkdir -p /etc/systemd/journald.conf.d
cat >/etc/systemd/journald.conf.d/vps-toolkit.conf <<EOF
[Journal]
SystemMaxUse=100M
RuntimeMaxUse=50M
MaxRetentionSec=7day
EOF
systemctl restart systemd-journald 2>/dev/null || true
find /var/log -type f -size +100M -exec ls -lh {} \; 2>/dev/null || true
echo "完成"
