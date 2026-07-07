#!/bin/bash
echo "=============================="
echo " VPS HEALTH REPORT"
echo "=============================="
hostname
uname -r
echo
free -h
echo
df -h /
echo
ps aux --sort=-%mem | head -10
echo
echo "[x-ui]"
systemctl is-active x-ui 2>/dev/null || echo "unavailable"
echo
echo "[xray]"
ps aux | grep xray | grep -v grep || true
echo
echo "[WireGuard]"
wg show 2>/dev/null || echo "unavailable"
echo
echo "[WARP]"
systemctl is-active warp-svc 2>/dev/null || echo "unavailable"
echo
journalctl --disk-usage 2>/dev/null || true
