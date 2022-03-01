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


echo "GATEWAY=192.168.3.107" >>/etc/sysconfig/network-scripts/ifcfg-ens160

#nmcli


rm -f /etc/hosts
echo "
	127.0.0.1 nat localhost.localdomain localhost
" >>/etc/hosts


echo "
	NETWORKING=yes
	HOSTNAME=nat
	GATEWAY=192.168.3.107

" >>/etc/sysconfig/network

rm -f /etc/resolv.conf
echo "
	# Generated by NetworkManager
	search $domainName.com easlab.co.uk
	nameserver 192.168.1.1
	nameserver 8.8.8.8
" >>/etc/resolv.conf

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

echo "

	net.ipv4.ip_forward=1

" >/etc/sysctl.conf

service iptables save
wait
service iptables restart
wait 
nmcli connection reload 
wait
nmcli connection up ens160
wait
ifup ens160
