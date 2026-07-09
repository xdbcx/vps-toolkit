#!/bin/bash
echo "iperf3 v2.2.3"
echo "1 安装"
echo "2 开启服务"
echo "3 停止服务"
echo "4 VPS测速"
read -p "选择:" n
case $n in
1) apt update && apt install -y iperf3;;
2) iperf3 -s -D;;
3) pkill iperf3;;
4) read -p "IP:" ip; iperf3 -c $ip -P4 -t30;;
esac
