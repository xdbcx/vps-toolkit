#!/bin/bash
echo "FoxBary检测"
for x in /opt/script /root/smallvps; do
[ -e "$x" ] && echo "发现:$x"
done
crontab -l 2>/dev/null | grep -Ei "cleanCache|drop_caches|smallvps|FoxBary" || true
