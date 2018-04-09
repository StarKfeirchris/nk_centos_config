#!/bin/bash
  
echo Firewall status:
chkconfig | grep iptables
service iptables status
echo

echo Check SELinux:
sestatus | grep "SELinux status:"
sestatus | grep "Current mode:"
echo

echo Check internet:
ip a | grep -E "eth0|eth1|enp|ens|em1|em2"
echo

echo Check DNS:
cat /etc/resolv.conf
echo
