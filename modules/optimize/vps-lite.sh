#!/bin/bash
bash /opt/vps-toolkit/modules/optimize/foxbary-check.sh
echo "BBR:"
sysctl net.ipv4.tcp_congestion_control
echo "Swap:"
swapon --show
echo "Lite optimize finished"
