#!/bin/bash
while true; do
clear
echo "iperf3管理"
echo "1 安装"
echo "2 开启服务端"
echo "3 停止服务端"
echo "4 查看状态"
echo "0 返回"

read -p "选择:" n

case $n in
1) apt update && apt install -y iperf3;;
2) iperf3 -s -D;;
3) pkill iperf3;;
4) ps aux | grep iperf3;;
0) exit;;
esac

read -p "回车继续..."
done
