#!/bin/bash
#############
#Clark brooks
############
# Setting DNS infrastructure

# Argument 1 will be first part of the network address ($ipAddress123)
ipAddress123="10.0.0"

# Argument 2 will be last part of the network address (3)
ipFourthOctave="3"

# Argument 4 Domain name  (template)
domainName="clark"


dnf install -y bind bind-utils

systemctl enable named
service named start
service named restart

# start the DNS server using the command



echo "//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//

options {
//	listen-on port 53 { 127.0.0.1; };
//	listen-on-v6 port 53 { ::1; };
        directory       \"/var/named\";
        dump-file       \"/var/named/data/cache_dump.db\";
        statistics-file \"/var/named/data/named_stats.txt\";
        memstatistics-file \"/var/named/data/named_mem_stats.txt\";
        secroots-file   \"/var/named/data/named.secroots\";
        recursing-file  \"/var/named/data/named.recursing\";
        allow-query     { localhost; 10.0.0.0/24; };


        /*
         - If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
         - If you are building a RECURSIVE (caching) DNS server, you need to enable
           recursion.
         - If your recursive DNS server has a public IP address, you MUST enable access
           control to limit queries to your legitimate users. Failing to do so will
           cause your server to become part of large scale DNS amplification
           attacks. Implementing BCP38 within your network would greatly
           reduce such attack surface
        */
	recursion yes;

        dnssec-enable yes;
        dnssec-validation yes;

        managed-keys-directory \"/var/named/dynamic\";

        pid-file \"/run/named/named.pid\";
        session-keyfile \"/run/named/session.key\";

        /* https://fedoraproject.org/wiki/Changes/CryptoPolicy */
        include \"/etc/crypto-policies/back-ends/bind.config\";
};

logging {
	channel default_debug {
                file \"data/named.run\";
                severity dynamic;
        };
};

zone \".\" IN {
	type hint;
        file \"named.ca\";
};

include \"/etc/named.rfc1912.zones\";
include \"/etc/named.root.key\";

//foward zone

zone \"$domainName.local\" IN {
        type master;
        file \"$domainName.local.db\";
        allow-update { none; };
        allow-query { any; };
};


//back zone

zone \"0.0.10.in-addr.arpa\" IN {
        type master;
        file \"$domainName.local.rev\";
        allow-update { none; };
        allow-query { any; };
};" > /etc/named.conf 


echo "\$TTL 86400
@ IN SOA dns-primary.$domainName.local. admin.$domainName.local. (
							2020011800 ;Serial
							3600 ;Refresh
							1800 ;Retry
							604800 ;Expire
							86400 ;Minimum TTL
)

;Name Server Information
@ IN NS dns-primary.$domainName.local.

;IP Address for Name Server
dns-primary IN A $ipAddress123.$ipFourthOctave

;A Record for the following Host name
www  IN   A   $ipAddress123.21
Gateway   IN   A   $ipAddress123.1
DHCP  IN   A   $ipAddress123.2
DNS  IN   A   $ipAddress123.$ipFourthOctave

	
;CNAME Record
ftp  IN   CNAME www.$domainName.local." >> /var/named/$domainName.local.db



echo "\$TTL 86400
@ IN SOA dns-primary.$domainName. admin.$domainName.local. (
							2020011800 ;Serial
							3600 ;Refresh
							1800 ;Retry
							604800 ;Expire
							86400 ;Minimum TTL
)
;Name Server Information
@ IN NS dns-primary.$domainName.local.
dns-primary IN A $ipAddress123.$ipFourthOctave

;Reverse lookup for Name Server
3 IN PTR dns-primary.$domainName.local.

;PTR Record IP address to Hostname
21      IN      PTR     www.clark.local
3       IN      PTR     DNS.clark.local.
2       IN      PTR     DHCP.clark.local.
1       IN      PTR	Gateway.clark.local.
" >> /var/named/$domainName.local.rev


chown named:named /var/named/$domainName.local.db
chown named:named /var/named/$domainName.local.rev

named-checkconf
named-checkzone $domainName.local /var/named/$domainName.local.db
named-checkzone $ipAddress123.$ipFourthOctave /var/named/$domainName.local.rev

systemctl restart named

firewall-cmd  --add-service=dns --zone=public  --permanent
firewall-cmd --reload

echo "DNS1=10.0.0.3" >> /etc/sysconfig/network-scripts/ifcfg-ens160

systemctl restart NetworkManager
