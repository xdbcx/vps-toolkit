#!/bin/bash

BASE=/opt/vps-toolkit

case "$1" in
check)
 bash $BASE/modules/monitor/report.sh
;;
update)
 bash $BASE/update.sh
;;
rollback)
 bash $BASE/rollback.sh
;;
version)
 cat $BASE/version
;;
speedtest)
 bash $BASE/modules/network/iperf3.sh
;;
*)
clear
echo "=============================="
echo " VPS Toolkit v2.2.1"
echo "=============================="
echo "1 系统信息"
echo "2 健康巡检"
echo "3 BBR检查"
echo "4 TCP优化"
echo "5 Xray检查"
echo "6 WireGuard检查"
echo "7 WARP检查"
echo "8 iperf3测速"
echo "9 备份"
echo "10 更新"
echo "11 回滚"
echo "0 退出"

read -p "选择: " n

case $n in
1) bash $BASE/modules/system/info.sh;;
2) bash $BASE/modules/monitor/report.sh;;
3) bash $BASE/modules/optimize/bbr.sh;;
4) bash $BASE/modules/optimize/tcp.sh;;
5) bash $BASE/modules/proxy/xray-check.sh;;
6) bash $BASE/modules/wireguard/status.sh;;
7) bash $BASE/modules/warp/status.sh;;
8) bash $BASE/modules/network/iperf3.sh;;
9) bash $BASE/modules/backup/backup.sh;;
10) bash $BASE/update.sh;;
11) bash $BASE/rollback.sh;;
esac
;;
esac
