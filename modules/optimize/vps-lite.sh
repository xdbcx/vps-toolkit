#!/bin/bash
set -e
echo "===== VPS Lite Optimize ====="
[ "$(id -u)" = "0" ] || { echo "Please run as root"; exit 1; }

echo "[1] 清理 smallvps drop_caches 任务"
if [ -f /opt/script/cron/cleanCache.sh ] || crontab -l 2>/dev/null | grep -q cleanCache; then
    crontab -l 2>/dev/null | grep -v cleanCache | crontab - || true
    rm -rf /opt/script
    echo "已清理"
else
    echo "未发现，跳过"
fi

echo "[2] 基础工具"
if ! command -v curl >/dev/null || ! command -v wget >/dev/null; then
    apt update
    apt install -y curl wget vim htop cron unzip
else
    echo "已存在，跳过"
fi

echo "[3] BBR检测"
CC=$(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null || true)
if [ "$CC" = "bbr" ]; then
    echo "BBR已启用，跳过"
else
    if sysctl -n net.ipv4.tcp_allowed_congestion_control 2>/dev/null | grep -qw bbr; then
        cat >/etc/sysctl.d/99-vps-toolkit-bbr.conf <<EOF
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF
    else
        echo "内核不支持BBR，跳过"
    fi
fi

echo "[4] TCP优化"
cat >/etc/sysctl.d/99-vps-toolkit-network.conf <<EOF
net.core.somaxconn=4096
net.ipv4.tcp_max_syn_backlog=4096
net.ipv4.tcp_fin_timeout=15
net.ipv4.tcp_fastopen=3
EOF

echo "[5] 内存策略"
cat >/etc/sysctl.d/99-vps-toolkit-memory.conf <<EOF
vm.swappiness=10
vm.vfs_cache_pressure=50
EOF

sysctl --system >/dev/null || true

echo "[6] Swap检测"
if swapon --show | grep -q swap; then
    echo "已有swap，跳过"
else
    RAM=$(free -m | awk '/Mem:/ {print $2}')
    if [ "$RAM" -le 1024 ]; then
        fallocate -l 1G /swapfile 2>/dev/null || dd if=/dev/zero of=/swapfile bs=1M count=1024
        chmod 600 /swapfile
        mkswap /swapfile >/dev/null
        swapon /swapfile
        grep -q "/swapfile" /etc/fstab || echo "/swapfile none swap sw 0 0" >> /etc/fstab
    else
        echo "内存大于1G，跳过"
    fi
fi

echo "[7] journald限制"
mkdir -p /etc/systemd/journald.conf.d
cat >/etc/systemd/journald.conf.d/vps-toolkit.conf <<EOF
[Journal]
SystemMaxUse=100M
RuntimeMaxUse=50M
MaxRetentionSec=7day
EOF
systemctl restart systemd-journald 2>/dev/null || true

apt clean || true
echo "完成"
free -h
