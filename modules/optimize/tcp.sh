#!/bin/bash
cat >/etc/sysctl.d/99-vps-toolkit.conf <<EOF
net.core.somaxconn=4096
net.ipv4.tcp_max_syn_backlog=4096
net.ipv4.tcp_fin_timeout=15
EOF
sysctl --system
