#!/bin/bash
install_iperf3(){ command -v iperf3 >/dev/null 2>&1 || { apt update; apt install -y iperf3; }; }
while true; do
clear
echo "=============================="
echo " iperf3 管理"
echo "=============================="
echo "1 安装iperf3"
echo "2 开启服务端"
echo "3 停止服务端"
echo "4 查看服务端状态"
echo "5 TCP测速"
echo "6 UDP测速"
echo "0 返回主菜单"
read -p "选择: " n
case "$n" in
1) install_iperf3;;
2) install_iperf3; pgrep -x iperf3 >/dev/null && echo "已运行" || { iperf3 -s -D; echo "已开启5201"; };;
3) pkill iperf3 2>/dev/null || true; echo "已停止";;
4) ps aux | grep iperf3 | grep -v grep || echo "未运行"; ss -lntup 2>/dev/null | grep 5201 || true;;
5) read -p "服务端IP: " IP; [ -n "$IP" ] && iperf3 -c "$IP" -P 4 -t 30;;
6) read -p "服务端IP: " IP; read -p "UDP带宽(默认500M): " BW; [ -z "$BW" ] && BW=500M; [ -n "$IP" ] && iperf3 -c "$IP" -u -b "$BW" -t 30;;
0) exit 0;;
*) echo "无效选择";;
esac
read -p "按回车继续..."
done
