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
echo "
DEVICE=ens160
NAME=ens160
BOOTPROTO=static
HWADDR=00:50:56:b2:26:fe
IPADDR=$ipAddrees123.1
BROADCAST=$ipAddrees123.255
NETMASK=255.255.255.0
NETWORK=nat
NETWORKING=yes
GATEWAY=192.168.3.105       # Enter Ip of eth0 
ONBOOT=yes
TYPE=Ethernet
USERCTL=no
IPV6INIT=no
PEERDNS=yes
" >>/etc/sysconfig/network-scripts/ifcfg-ens160

#nmcli


echo "
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=ens192
UUID=32d7c5eb-362e-4764-8ddd-847ab5c94e8e
DEVICE=ens192
ONBOOT=yes
BROADCAST=192.168.255.255
NETMASK=255.255.255.0
" >>/etc/sysconfig/network-scripts/ifcfg-ens192

systemctl restart NetworkManager

rm -f /etc/hosts
echo "
	127.0.0.1 nat localhost.localdomain localhost
" >>/etc/hosts

rm -f /etc/sysconfig/network
echo "
	# Created by anaconda  Test
	NETWORKING=yes
	HOSTNAME=nat
	GATEWAY=192.168.3.105

" >>/etc/sysconfig/network

rm -f /etc/resolv.conf
echo "
	# Generated by NetworkManager
	search $domainName.com easlab.co.uk
	nameserver 8.8.8.8
" >>/etc/resolv.conf

iptables -F
iptables -t nat -F
iptables -t mangle -F

iptables -X
iptables -t nat -X
iptables -t mangle -X

iptables -t nat -A POSTROUTING -o ens160 -j MASQUERADE

iptables -A FORWARD -i ens192 -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -j ACCEPT

echo 1 >/proc/sys/net/ipv4/ip_forward

rm -f /etc/sysctl.conf
echo "

	net.ipv4.ip_forward=1

" >/etc/sysctl.conf

service iptables save
service iptables restart

systemctl restart NetworkManager
