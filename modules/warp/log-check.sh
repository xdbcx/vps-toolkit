#!/bin/bash
systemctl status warp-svc --no-pager
du -sh /var/log/cloudflare-warp 2>/dev/null
