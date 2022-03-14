#!/bin/bash
#############
#Clark brooks
############
# Setting server infrastructure

scp Gateway_Script.bash DHCP_Script.bash DNS_Script.bash root@192.168.3.107:/bin

ssh root@192.168.3.107 "chmod 777 /bin/Gateway_Script.bash /bin/DHCP_Script.bash /bin/DNS_Script.bash"

scp DHCP_Script.bash root@10.0.0.2:/bin
scp DNS_Script.bash root@10.0.0.3:/bin


echo "Running Gateway_Script.bash"
ssh root@192.168.3.107 "Gateway_Script.bash"
echo "sleeping for 30 seconds" 
sleep 30s
exit

echo "Running DHCP_Script.bash on 10.0.0.2"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 
/bin/DHCP_Script.bash
echo "sleeping for 30 seconds"
sleep 30s
exit

echo "Running DNS_Script.bash on 10.0.0.3"
ssh -t root@192.168.3.107 ssh root@10.0.0.3
/bin/DNS_Script.bash
echo "sleeping for 30 seconds" 
sleep 30s
exit


echo "All serversse have been installed. Enjoy your new netowrk"






