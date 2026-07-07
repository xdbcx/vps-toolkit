#!/bin/bash

echo "===================="
echo " VPS HEALTH REPORT"
echo "===================="

echo CPU:
top -bn1 | grep Cpu

echo Memory:
free -h

echo Disk:
df -h /

echo Xray:
systemctl is-active x-ui 2>/dev/null || true

echo WireGuard:
wg show 2>/dev/null || echo unavailable

echo WARP:
systemctl is-active warp-svc 2>/dev/null || echo unavailable
