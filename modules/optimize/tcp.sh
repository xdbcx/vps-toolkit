#!/bin/bash
echo "===== BBR / TCP Optimize ====="
CC=$(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null || true)
echo "当前拥塞算法: $CC"
if [ "$CC" != "bbr" ] && sysctl -n net.ipv4.tcp_allowed_congestion_control 2>/dev/null | grep -qw bbr; then
cat >/etc/sysctl.d/99-vps-toolkit-bbr.conf <<EOF
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF
fi
cat >/etc/sysctl.d/99-vps-toolkit-network.conf <<EOF
net.core.somaxconn=4096
net.ipv4.tcp_max_syn_backlog=4096
net.ipv4.tcp_fin_timeout=15
net.ipv4.tcp_fastopen=3
EOF
sysctl --system >/dev/null || true
sysctl net.ipv4.tcp_congestion_control
sysctl net.core.somaxconn
sysctl net.ipv4.tcp_max_syn_backlog
