#!/bin/bash
#############
#Clark brooks
############
# Setting Gateway infrastructure

# Argument 1 will be first part of the network address ($ipAddrees123)
ipAddrees123="10.0.0"

# Argument 4 Domain name  (template)
domainName="clark"

yum install -y iptables-services

rm -f /etc/sysconfig/network-scripts/ifcfg-ens160
echo "TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
IPADDR=10.0.0.1
DEFROUTE=no
IPV4_FAILURE_FATAL=no
IPV6INIT=no
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=no
IPV6_FAILURE_FATAL=yes
NAME=ens160
UUID=32d7c5eb-362e-4764-8ddd-847ab5c94e8e
DEVICE=ens160
ONBOOT=yes
BROADCAST=10.0.0.255
NETMASK=255.255.255.0
GATEWAY=192.168.3.107
USERCTL=no" >> /etc/sysconfig/network-scripts/ifcfg-ens160

#nmcli


rm -f /etc/hosts
echo "127.0.0.1 nat localhost.localdomain localhost" >>/etc/hosts


echo "NETWORKING=yes
HOSTNAME=nat
GATEWAY=192.168.3.107" >>/etc/sysconfig/network

rm -f /etc/resolv.conf
echo "# Generated by clark
search $domainName.com easlab.co.uk
nameserver 10.0.0.3
nameserver 192.168.1.1
nameserver 8.8.8.8" >>/etc/resolv.conf

ifdown ens160 && ifup ens160

systemctl restart NetworkManager
wait

iptables -F
iptables -t nat -F
iptables -t mangle -F

iptables -X
iptables -t nat -X
iptables -t mangle -X

iptables -t nat -A POSTROUTING -o ens192 -j MASQUERADE

iptables -A FORWARD -i ens160 -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -j ACCEPT

echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward=1" >/etc/sysctl.conf

service iptables save
wait
service iptables restart
wait 
nmcli connection reload 
wait
systemctl restart NetworkManager

echo "job done!"
