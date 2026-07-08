#!/bin/bash
echo "================================"
echo " FoxBary smallvps 检测"
echo "================================"

found=0

for f in /opt/script /root/smallvps; do
    if [ -e "$f" ]; then
        echo "发现文件: $f"
        found=1
    fi
done

echo
echo "Cron检测:"
if crontab -l 2>/dev/null | grep -Ei "cleanCache|drop_caches|smallvps|FoxBary"; then
    found=1
else
    echo "未发现相关cron"
fi

echo
if [ "$found" = "1" ]; then
    echo "检测到 FoxBary smallvps 痕迹"
else
    echo "未发现 FoxBary smallvps 痕迹"
fi
