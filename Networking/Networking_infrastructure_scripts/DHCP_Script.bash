#!/bin/bash
#############
#Clark brooks
############
# Setting DHCP infrastructure


# Argument 1 will be first part of the network address ($ipAddress123)
ipAddress123="$1"

# Argument 4 Domain name  (template)
domainName="$2"

yum install -y dhcp

rm -f /etc/sysconfig/network-scripts/ifcfg-ens160

echo "TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6 DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=ens160
UUID=3207c5eb-362e-4764-8ddd-847ab5c94e8e
DEVICE=ens160
ONBOOT=yes
IPADDR=$ipAddress123.2
NETMASK:255.255.255.0
GATEWAY=$ipAddress123.1
DNS=$ipAddress123.3
PREFIX=24" >> /etc/sysconfig/network-scripts/ifcfg-ens160

firewall-cmd --zone=public --permanent --add-service=dhcp
firewall-cmd --reload 


rm -f /etc/dhcp/dhcpd.conf

echo "default-lease-time	86400; 
max-lease-time		172800;

option domain name "$domainName.com";
option doma in-name-servers $ipAddress123.3;

ddns-update-style none;

authoritative;

subnet $ipAddress123.0 netmask 255.255.255.0 {
	range $ipAddress123.10 $ipAddress123.20; 
	option broadcast-address $ipAddress123.255;
	option routers $ipAddress123.1;
}" >> /etc/dhcp/dhcpd.conf



systemctl restart NetworkManager
