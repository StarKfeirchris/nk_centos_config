#!/bin/bash
  
echo Firewall status:
systemctl status firewalld | grep -B2 "Active:"
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
