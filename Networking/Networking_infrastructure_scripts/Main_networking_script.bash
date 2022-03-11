#!/bin/bash
#############
#Clark brooks
############
# Setting server infrastructure


scp Gateway_Script.bash root@192.168.3.107:/bin
scp DHCP_Script.bash root@192.168.3.107:/bin
scp DNS_Script.bash root@192.168.3.107:/bin

ssh root@192.168.3.107
cd /bin

chmod 777 Gateway_Script.bash
chmod 777 DHCP_Script.bash
chmod 777 DNS_Script.bash

echo "Running Gateway_Script.bash"
Gateway_Script.bash


echo "Running DHCP_Script.bash on 10.0.0.2"
scp DHCP_Script.bash root@10.0.0.2:/bin
ssh root@10.0.0.2 "/bin/DHCP_Script.bash"
echo "sleeping for 30 seconds"
sleep 30s

echo "Running DNS_Script.bash on 10.0.0.3"
scp DNS_Script.bash root@10.0.0.3:/bin
ssh root@10.0.0.2 "/bin/DNS_Script.bash"
echo "sleeping for 30 seconds"
sleep 30s









