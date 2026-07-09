#!/bin/bash
echo "===== System Info ====="
hostname
uname -r
cat /etc/os-release 2>/dev/null | grep PRETTY_NAME || true
uptime
free -h
df -h /
ps aux --sort=-%mem | head -10
