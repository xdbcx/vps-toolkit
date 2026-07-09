#!/bin/bash
BASE="/opt/vps-toolkit"

while true; do
clear
echo "=============================="
echo " VPS Toolkit $(cat $BASE/version 2>/dev/null)"
echo "=============================="
echo "1 系统信息"
echo "2 VPS Lite优化"
echo "3 BBR/TCP优化"
echo "4 内存/日志优化"
echo "5 Xray / 3X-ui检查"
echo "6 WireGuard检查"
echo "7 WARP日志管理"
echo "8 iperf3管理"
echo "9 备份"
echo "10 更新"
echo "11 回滚"
echo "12 一键巡检"
echo "13 IPv6管理"
echo "0 退出"

echo
read -p "选择: " n

case "$n" in
1) bash "$BASE/modules/system/info.sh";;
2) bash "$BASE/modules/optimize/vps-lite.sh";;
3) bash "$BASE/modules/optimize/tcp.sh";;
4) bash "$BASE/modules/optimize/log-clean.sh";;
5) bash "$BASE/modules/proxy/xui-check.sh";;
6) bash "$BASE/modules/wireguard/wg-check.sh";;
7) bash "$BASE/modules/warp/log-check.sh";;
8) bash "$BASE/modules/network/iperf3.sh";;
9) bash "$BASE/modules/backup/backup.sh";;
10) bash "$BASE/update.sh";;
11) bash "$BASE/rollback.sh";;
12) bash "$BASE/modules/monitor/report.sh";;
13) bash "$BASE/modules/security/ipv6.sh";;
0) exit 0;;
*) echo "无效选择";;
esac

echo
read -p "按回车返回菜单..."
done
