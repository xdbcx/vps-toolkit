#!/bin/bash
echo "===== WARP Log / Status Check ====="
systemctl status warp-svc --no-pager 2>/dev/null || echo "warp-svc not found"
echo
ps aux --sort=-%mem | grep warp | grep -v grep || true
echo
du -sh /var/log/cloudflare-warp 2>/dev/null || echo "/var/log/cloudflare-warp not found"
echo
journalctl --disk-usage 2>/dev/null || true
echo
echo "可选清理命令:"
echo "journalctl --vacuum-size=100M"
echo "systemctl restart warp-svc"
