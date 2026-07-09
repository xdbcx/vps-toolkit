#!/bin/bash
echo "=============================="
echo " IPv6管理"
echo "=============================="
echo "1 关闭IPv6"
echo "2 恢复IPv6"
echo "3 检查IPv6"
read -p "选择: " n

case $n in
1)
cat >/etc/sysctl.d/99-disable-ipv6.conf <<EOF
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
EOF
sysctl --system
echo "IPv6已关闭"
;;
2)
rm -f /etc/sysctl.d/99-disable-ipv6.conf
sysctl --system
echo "IPv6配置已恢复"
;;
3)
ip -6 addr
;;
esac
