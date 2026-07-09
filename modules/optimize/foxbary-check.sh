#!/bin/bash
echo "===== FoxBary smallvps 检测 ====="
FOUND=0
for f in /opt/script /root/smallvps; do
 [ -e "$f" ] && echo "发现: $f" && FOUND=1
done
crontab -l 2>/dev/null | grep -Ei "cleanCache|drop_caches|smallvps|FoxBary" && FOUND=1 || echo "未发现相关cron"
[ "$FOUND" = 1 ] && echo "检测到FoxBary痕迹" || echo "未发现"
