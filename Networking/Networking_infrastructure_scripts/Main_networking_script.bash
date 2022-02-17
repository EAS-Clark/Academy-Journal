#!/bin/bash
#############
#Clark brooks
############
# Setting server infrastructure


scp Gateway.bash root@192.168.3.17:/test

dos2unix Gateway.bash

Gateway.bash

scp DHCP_Script.bash root@192.168.3.17:/test
scp DNS_Script.bash root@192.168.3.17:/test

cd /test
dos2unix DHCP_Script.bash
dos2unix DNS_Script.bash


scp DNS_Script.bash root@10.0.0.3:/dev

# some how run

scp DHCP_Script.bash root@10.0.0.3:/dev
# some how run







https://www.linuxtechi.com/setup-bind-server-centos-8-rhel-8/

https://www.tecmint.com/install-dhcp-server-client-on-centos-ubuntu/

http://howto-madkour.blogspot.com/2013/08/linuxcentos-gateway-server.html?m=1




