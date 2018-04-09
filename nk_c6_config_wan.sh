#!/bin/bash

echo "此腳本執行完會自動重開機，"
echo "如果過程中輸入錯誤請按 ctrl+c 結束，再重新執行一次。"
echo "網路設定檔再寫入前有先做備份，"
echo "備份檔路徑如下："
echo "/etc/sysconfig/network.bak"
echo "/etc/sysconfig/network-scripts/ifcfg-[網路介面名稱].bak"
echo

# Disable Firewall
chkconfig iptables off

# Disable SELinux.
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

read -p "請輸入外網網路介面的名稱（像 eth0、em1...等）：" wanif
read -p "請輸入這台機器的 Gateway：" gw
read -p "請輸入這台機器的外網 netmask：" nmask
read -p "請輸入這台機器的外網 IP 位址：" wanip

\cp -f /etc/sysconfig/network /etc/sysconfig/network.bak
\mv -f /etc/sysconfig/network-scripts/ifcfg-${wanif} /etc/sysconfig/network-scripts/ifcfg-${wanif}.bak

echo "GATEWAY=${gw}" >> /etc/sysconfig/network

echo "DEVICE=${wanif}" >> /etc/sysconfig/network-scripts/ifcfg-${wanif}
echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-${wanif}
echo "BOOTPROTO=static" >> /etc/sysconfig/network-scripts/ifcfg-${wanif}
echo "IPADDR=${wanip}" >> /etc/sysconfig/network-scripts/ifcfg-${wanif}
echo "NETMASK=${nmask}" >> /etc/sysconfig/network-scripts/ifcfg-${wanif}
echo "DNS1=168.95.1.1" >> /etc/sysconfig/network-scripts/ifcfg-${wanif}

init 6
