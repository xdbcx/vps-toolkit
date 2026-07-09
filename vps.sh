#!/bin/bash
B=/opt/vps-toolkit
while true; do
clear
echo "=============================="
echo " VPS Toolkit $(cat $B/version)"
echo "=============================="
echo "1 系统信息"
echo "2 VPS Lite优化"
echo "3 BBR/TCP优化"
echo "4 内存日志优化"
echo "5 Xray检查"
echo "6 WireGuard检查"
echo "7 WARP日志检查"
echo "8 iperf3管理"
echo "9 备份"
echo "10 IPv6管理"
echo "0 退出"
read -p "选择:" n
case $n in
1) bash $B/modules/system/info.sh;;
2) bash $B/modules/optimize/vps-lite.sh;;
3) bash $B/modules/optimize/tcp.sh;;
4) bash $B/modules/optimize/log-clean.sh;;
5) bash $B/modules/proxy/xui-check.sh;;
6) bash $B/modules/wireguard/wg-check.sh;;
7) bash $B/modules/warp/log-check.sh;;
8) bash $B/modules/network/iperf3.sh;;
9) bash $B/modules/backup/backup.sh;;
10) bash $B/modules/security/ipv6.sh;;
0) exit;;
esac
read -p "回车返回..."
done
