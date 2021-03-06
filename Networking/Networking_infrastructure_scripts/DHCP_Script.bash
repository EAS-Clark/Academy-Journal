#!/bin/bash
#############
#Clark brooks
############
# Setting DHCP infrastructure


# Argument 1 will be first part of the network address ($ipAddress123)
ipAddress123="10.0.0"

# Argument 4 Domain name  (template)
domainName="clark"

dnf makecache

dnf install dhcp-server -y

rm -f /etc/sysconfig/network-scripts/ifcfg-ens160

echo "TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=ens160
UUID=32d7c5eb-362e-4764-8ddd-847ab5c94e8e
DEVICE=ens160
ONBOOT=yes
IPADDR=$ipAddress123.2
NETMASK:255.255.255.0
GATEWAY=$ipAddress123.1
DNS1=$ipAddress123.3
DOMAIN=$domainName" >> /etc/sysconfig/network-scripts/ifcfg-ens160

echo "DHCPDARGS=ens160" >> /etc/sysconfig/dhcpd



mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.init

echo "option domain-name \"$domainName.local\";

default-lease-time	86400;
max-lease-time          172800;

ddns-update-style none;

authoritative;

subnet $ipAddress123.0 netmask 255.255.255.0 {
        range $ipAddress123.10 $ipAddress123.50;
        option subnet-mask 255.255.255.0;
        option routers $ipAddress123.1;
        option domain-name \"$domainName.local\";
        option domain-search \"$domainName.local\";
        option domain-name-servers $ipAddress123.3, 8.8.8.8, 8.8.4.4;
}


host gateway-node {
        hardware ethernet 00:50:56:b2:e8:01;
        fixed-address $ipAddress123.1;

}

host DNS-node {
        hardware ethernet 00:50:56:b2:23:bd;
        fixed-address $ipAddress123.3;

}" >> /etc/dhcp/dhcpd.conf

firewall-cmd --zone=public --permanent --add-service=dhcp
firewall-cmd --reload 

ifup ens160

nmcli connection reload

systemctl start dhcpd

