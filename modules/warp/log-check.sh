#!/bin/bash
echo WARP状态:
systemctl status warp-svc --no-pager || true

echo
echo WARP日志:
du -sh /var/log/cloudflare-warp 2>/dev/null || true

echo
echo journald:
journalctl --disk-usage
