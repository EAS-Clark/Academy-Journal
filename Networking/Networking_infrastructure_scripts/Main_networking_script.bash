#!/bin/bash
#############
#Clark brooks
############
# Setting server infrastructure


scp Gateway_Script.bash root@192.168.3.17:/test
scp DHCP_Script.bash root@192.168.3.17:/test
scp DNS_Script.bash root@192.168.3.17:/test

dos2unix Gateway_Script.bash
dos2unix DHCP_Script.bash
dos2unix DNS_Script.bash

chmod 777 Gateway_Script.bash
chmod 777 DHCP_Script.bash
chmod 777 DNS_Script.bashs

bash /test/Gateway_Script.bash

cd /test

scp DHCP_Script.bash root@10.0.0.2:/bin
# some how run

scp DNS_Script.bash root@10.0.0.3:/bin
# some how run









https://www.linuxtechi.com/setup-bind-server-centos-8-rhel-8/

https://www.tecmint.com/install-dhcp-server-client-on-centos-ubuntu/

http://howto-madkour.blogspot.com/2013/08/linuxcentos-gateway-server.html?m=1




