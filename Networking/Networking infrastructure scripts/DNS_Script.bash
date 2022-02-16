#!/bin/bash
#############
#Clark brooks
############
# Setting DNS infrastructure



# Argument 1 will be first part of the network address ($ipAddrees123)
ipAddrees123="$1"

# Argument 2 will be last part of the network address (3)
ipFourthOctave="3"

# Argument 4 Domain name  (template)
domainName="$2"


dnf install -y bind bind-utils

# 			^	is this how you yes for all?

# test for error install ^



# start the DNS server using the command
systemctl start named
systemctl enable named

systemctl status named




#
rm -f /etc/named.conf

{
	//
	// named.conf
	//
	//Provided by Red Hat bind package to configure the ISC BIND named (8) DNS 
	// server as a caching only nameserver (as a localhost DNS resolver only).
	//
	// See /usr/share/doc/bind#/sample/ for example named configuration files.
	//

	options {
		listen-on port 53 { $ipAddrees123.$ipFourthOctave; }; 
		listen-on-v6 port 53 { ::1; };
		directory		"/var/named";
		dump-file 		"/var/named/data/cache_dump.db";
		statistics-file "zuar/named/data/named stats.txt";
		memstatistics-file "/var/named/data/named_mem stats.txt";
		secroots-file "zuar/named/data/named.secroots";
		recursing-file "/var/named/data/named .recursing"
		allow-query (localhost: $ipAddrees123.0/24; };
		
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
		
		managed-keys-directory "/var/named/dynamic";
		

		pid-file "/run/named/named.pid";
		session-keyf ile "/run/named/session.key";
		
		/* https://fedoraproject.org/wiki/Changes/CryptoPolicy */
		include "/etc/crypto-policies/back-ends/bind.config"
	};

	logging {
		channel default_debug {
			file "data/named.run";
			severity dynamic;
		};
	};

	zone "." IN {
		type hint;
		file "named.ca";
	};

	//foward zone

	zone "$domainName.local" IN {
		type master;
		file "$domainName.local.db";
		allow-update { none; };
		allow-query { any; };
	};

	//back zone

	zone "$ipAddrees123.192.in-addr.arpa" IN {
		type master;
		file "$domainName.local.rev";
		allow-update { none; };
		allow-query { any; };
	};
} >> /etc/named.conf


rm -f /var/named/$domainName.local.db
{
	$TTL 86400
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
	dns-primary IN A $ipAddrees123.$ipFourthOctave

	;A Record for the following Host name

	Gateway   IN   A   $ipAddrees123.1
	DHCP  IN   A   $ipAddrees123.2
	DNS  IN   A   $ipAddrees123.$ipFourthOctave
	app  IN   A   $ipAddrees123.10
	
	;CNAME Record
	ftp  IN   CNAME www.$domainName.local.
}/var/named/$domainName.local.db


rm -f /var/named/$domainName.local.rev
{
	$TTL 86400
	@ IN SOA dns-primary.$domainName. admin.$domainName.local. (
												2020011800 ;Serial
												3600 ;Refresh
												1800 ;Retry
												604800 ;Expire
												86400 ;Minimum TTL
	)
	;Name Server Information
	@ IN NS dns-primary.$domainName.local.
	dns-primary     IN      A       $ipAddrees123.$ipFourthOctave

	;Reverse lookup for Name Server
	35 IN PTR dns-primary.$domainName.local.

	;PTR Record IP address to Hostname
	50      IN      PTR     www.$domainName.local.

}/var/named/$domainName.local.rev


chown named:named /var/named/$domainName.db
chown named:named /var/named/$domainName.rev

named-checkconf
named-checkzone $domainName.local /var/named/$domainName.db
named-checkzone $ipAddrees123.$ipFourthOctave /var/named/$domainName.local.rev


systemctl restart named

firewall-cmd  --add-service=dns --zone=public  --permanent
firewall-cmd --reload

rm -f /etc/sysconfig/network-scripts/ifcfg-ens160

{
	TYPE=Ethernet
	PROXY_METHOD=none
	BROWSER_ONLY=no
	BOOTPROTO=static
	DEFROUTE=yes
	IPV4_FAILURE_FATAL=no
	IPV6 INIT=yes
	IPV6_AUTOCONF=yes
	IPV6_DEFROUTE=yes
	IPV6_FAILURE_FATAL=no
	NAME=ens160
	UUID=32d7c5eb-362e-4764-8ddd-847ab5c94e8e
	DEVICE=ens160
	ONBOOT=yes
	IPADDR=$ipAddrees123.$ipFourthOctave
	NETMASK=255.255.255.0
}/etc/sysconfig/network-scripts/ifcfg-ens160

systemctl restart NetworkManager


