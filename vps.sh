#!/bin/bash
BASE="/opt/vps-toolkit"
pause(){ echo; read -p "按回车返回菜单..."; }
run(){ [ -f "$1" ] && bash "$1" || echo "模块不存在: $1"; }

case "$1" in
check) bash "$BASE/modules/monitor/report.sh"; exit;;
update) bash "$BASE/update.sh"; exit;;
rollback) bash "$BASE/rollback.sh"; exit;;
version) cat "$BASE/version"; exit;;
esac

while true; do
clear
echo "=============================="
echo " VPS Toolkit v$(cat $BASE/version 2>/dev/null)"
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
echo "0 退出"
echo
read -p "选择: " n
case "$n" in
1) run "$BASE/modules/system/info.sh"; pause;;
2) run "$BASE/modules/optimize/vps-lite.sh"; pause;;
3) run "$BASE/modules/optimize/tcp.sh"; pause;;
4) run "$BASE/modules/optimize/log-clean.sh"; pause;;
5) run "$BASE/modules/proxy/xui-check.sh"; pause;;
6) run "$BASE/modules/wireguard/wg-check.sh"; pause;;
7) run "$BASE/modules/warp/log-check.sh"; pause;;
8) run "$BASE/modules/network/iperf3.sh";;
9) run "$BASE/modules/backup/backup.sh"; pause;;
10) bash "$BASE/update.sh"; pause;;
11) bash "$BASE/rollback.sh"; pause;;
12) run "$BASE/modules/monitor/report.sh"; pause;;
0) exit 0;;
*) echo "无效选择"; pause;;
esac
done
