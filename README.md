# VPS Toolkit Complete

适用于 Debian 11/12 小内存 VPS。

目标： - 512MB\~1GB RAM - Xray / 3X-ui - WireGuard 中转 - KVM VPS

特点： - 自动检测已有配置 - 已配置自动跳过 - 不覆盖代理核心配置 -
不执行危险优化

目录：

optimize/ - vps-lite.sh - log-clean.sh

network/ - bbr-check.sh - network-check.sh

xui/ - xui-check.sh

wireguard/ - wg-check.sh

security/ - ssh-hardening.sh - fail2ban-install.sh

backup/ - xui-backup.sh - wg-backup.sh

tools/ - system-info.sh

使用：

bash \<(curl -sL
https://raw.githubusercontent.com/USER/REPO/main/optimize/vps-lite.sh)
