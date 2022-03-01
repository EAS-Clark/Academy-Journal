#!/bin/sh -x 

yum install iptables-services -y

# echo "DEVICE=ens192
# BOOTPROTO=static
# HWADDR=00:0c:29:d2:c2:75
# IPADDR=192.168.1.10
# BROADCAST=192.168.1.255
# NETMASK=255.255.255.0
# NETWORK=192.168.1.0
# GATEWAY=192.168.1.1
# DNS1=8.8.8.8
# DNS2=8.8.4.4
# ONBOOT=yes
# TYPE=Ethernet
# USERCTL=no
# IPV6INIT=no
# PEERDNS=yes" > /etc/sysconfig/network-scripts/ifcfg-ens192


# echo "DEVICE=ens160
# BOOTPROTO=static
# HWADDR=00:0c:29:d2:c2:7f
# IPADDR=192.168.10.1
# BROADCAST=192.168.10.255
# NETMASK=255.255.255.0
# NETWORK=192.168.10.0
# GATEWAY=192.168.1.10 
# ONBOOT=yes
# TYPE=Ethernet
# USERCTL=no
# IPV6INIT=no
# PEERDNS=yes" > /etc/sysconfig/network-scripts/ifcfg-ens160

#echo "PEERDNS=yes" >> /etc/sysconfig/network-scripts/ifcfg-ens160

echo "GATEWAY=192.168.3.105" >> /etc/sysconfig/network-scripts/ifcfg-ens160

echo "NETWORKING=yes
HOSTNAME=nat
GATEWAY=192.168.3.105" >> /etc/sysconfig/network

iptables -F

iptables -t nat -F

iptables -t mangle -F

iptables -X

iptables -t nat -X

iptables -t mangle -X

iptables -t nat -A POSTROUTING -o ens192 -j MASQUERADE

iptables -A FORWARD -i ens160 -j ACCEPT

iptables -I INPUT -p tcp --dport 80 -j ACCEPT

echo 1 > /proc/sys/net/ipv4/ip_forward

echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf

service iptables save

service iptables restart

wait

nmcli connection reload

wait

nmcli connection up ens160

wait

ifup ens160

# ifdown ens192 && ifup ens192