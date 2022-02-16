#!/bin/bash
#############
#Clark brooks
############
# Setting DHCP infrastructure


# Argument 1 will be first part of the network address ($ipAddrees123)
ipAddrees123="$1"

# Argument 4 Domain name  (template)
domainName="$2"



yum install -y dhcp

rm -f /etc/sysconfig/network-scripts/ifcfg-ens160

{

	TYPE=Ethernet
	PROXY_METHOD=none
	BROWSER_ONLY=no
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
	IPADDR=$ipAddrees123.2
	NETMASK:255.255.255.0
	GATEWAY=$ipAddrees123.1
	DNS=$ipAddrees123.3
	PREFIX=24

}/etc/sysconfig/network-scripts/ifcfg-ens160

firewall-cmd --zone=public --permanent --add-service=dhcp
firewall-cmd --reload 


rm -f /etc/dhcp/dhcpd.conf

{
	default-lease-time	86400; 
	max-lease-time		172800;

	option domain name "$domainName.com";
	option doma in-name-servers $ipAddrees123.3;

	ddns-update-style none;

	authoritative;

	subnet $ipAddrees123.0 netmask 255.255.255.0 {
		range $ipAddrees123.10 $ipAddrees123.20; 
		option broadcast-address $ipAddrees123.255;
		option routers $ipAddrees123.1;
	}

}/etc/dhcp/dhcpd.conf



systemctl restart networking
