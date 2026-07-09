#!/bin/bash
install_iperf3(){
 command -v iperf3 >/dev/null 2>&1 || { apt update; apt install -y iperf3; }
}
firewall_check(){
 command -v ufw >/dev/null && echo "检测到ufw，请确认5201端口" || echo "未检测防火墙，跳过"
}
while true; do
clear
echo "===== iperf3 管理 v2.2.3 ====="
echo "1 安装"
echo "2 开启服务端"
echo "3 停止服务端"
echo "4 VPS互测"
echo "5 VPS到本地测速"
echo "6 UDP测速"
echo "7 状态"
echo "0 返回"
read -p "选择:" n
case $n in
1) install_iperf3;;
2) install_iperf3; pkill iperf3 2>/dev/null; iperf3 -s -D; firewall_check;;
3) pkill iperf3;;
4) read -p "IP:" ip; iperf3 -c "$ip" -P4 -t30;;
5) iperf3 -s -D; echo "本地执行: iperf3 -c $(curl -4 -s ip.sb) -P4 -t30"; firewall_check;;
6) read -p "IP:" ip; iperf3 -c "$ip" -u -b 500M -t30;;
7) ps aux|grep iperf3|grep -v grep;;
0) exit;;
esac
read -p "回车继续"
done
