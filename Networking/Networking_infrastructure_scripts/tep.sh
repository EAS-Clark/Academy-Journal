#!/bin/bash
#############
#Clark brooks
############
# Setting DNS infrastructure

echo "DNS=10.0.0.3
FallbackDNS=8.8.8.8
Domains=easlab.local" >> /etc/resolv.conf

echo "DNS1=8.8.8.8
DNS2=8.8.4.4
DOMAIN=localdomain" >> /etc/sysconfig/network-scripts/ifcfg-ens160

dnf install bind bind-utils -y

systemctl enable named

systemctl status named

service named start

echo "OPTIONS=\"-4\"" >> /etc/sysconfig/named

service named restart

echo "@  IN  SOA    dns-primary.easlab.local. root.easlab.local. (
1001    ;Serial
3H      ;Refresh
15M     ;Retry
1W      ;Expire
1D      ;Minimum TTL
)
;Name Server Information
@ IN  NS      dns-primary.easlab.local.
;Reverse lookup for Name Server
100 IN PTR dns-primary.easlab.local.
;PTR Record IP address to HostName
$ipAddress123.1 IN PTR Gateway
$ipAddress123.2 IN PTR DHCP
$ipAddress123.$ipFourthOctave IN PTR DNS 
$ipAddress123.10 IN PTR App"  > /var/named/192.168.0.db

echo "@   IN  SOA     dns-primary.easlab.local. root.easlab.local. (
1001    ;Serial
3H      ;Refresh
15M     ;Retry
1W      ;Expire
1D      ;Minimum TTL
)
;Name Server Information
@      IN  NS      dns-primary.easlab.local.
;IP address of Name Server
dns-primary IN  A       10.0.0.3
;A - Record HostName To IP Address
Gateway   IN   A   $ipAddress123.1
DHCP  IN   A   $ipAddress123.2
DNS  IN   A   $ipAddress123.$ipFourthOctave
app  IN   A   $ipAddress123.10
;CNAME record
ftp     IN CNAME        www.easlab.local." > /var/named/easlab.local.db

# touch /etc/named.conf

echo "options {
        directory     \"/var/named\";
        dump-file      \"/var/named/data/cache_dump.db\";
        statistics-file \"/var/named/data/named_stats.txt\";
        memstatistics-file  \"/var/named/data/named_mem_stats.txt\";
        secroots-file    \"/var/named/data/named.secroots\";
        recursing-file \"/var/named/data/named.recursing\";
        allow-query {localhost;10.0.0.0/24;};
        /*
        - If you are building an AUTHORATIVE DNS server, do NOT enable recursion.
        - If you are building a RECURSIVE (caching) DNS server, you need to enable recursion.
        - If your recursive DNS server has a public IP address, you MUST enable access control to limit queries to your legitimate users. Failing to do so will cause your server to become part of large scale DNS amplification attacks. Implementing BCP38 within your network would greatly reduce such attack surface
        */
        recursion yes;
        dnssec-enable yes;
        dnssec-validation yes;
        
        managed-keys-directory \"/var/named/dynamic\";
        pid-file \"/run/named/named.pid\";
        session-keyfile \"/run/named/session.key\";
        
        /* https://fedoraproject.org/wiki/Changes/CryptoPolicy */
        include \"/etc/crypto-policies/back-ends/bind.config\" ;
};
logging {
        channel default_debug {
            file \"data/named.run\";
            severity dynamic;
        };
};
zone \"easlab.local\" IN {
        type master;
        file \"/var/named/easlab.local.db\";
        allow-update { none; };
};
zone \"0.0.10.in-addr.arpa\" IN {
        type master;
        file \"/var/named/192.168.0.db\";
        allow-update { none; };
};
include \"/etc/named.rfc1912.zones\";
include \"/etc/named.root.key\";" > /etc/named.conf

ifdown ens160 && ifup ens160

nmcli connection reload

systemctl restart named 

firewall-cmd --add-service=dns --permanent

firewall-cmd --reload