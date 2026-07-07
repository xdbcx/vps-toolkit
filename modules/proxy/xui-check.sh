#!/bin/bash
echo "===== Xray / 3X-ui Check ====="
systemctl status x-ui --no-pager 2>/dev/null || echo "x-ui service not found"
echo
ps aux | grep xray | grep -v grep || echo "xray process not found"
echo
ss -lntup 2>/dev/null | grep -Ei "xray|x-ui|:443|:8443|:2053|:2083|:2087|:2096" || ss -lntup 2>/dev/null || true
