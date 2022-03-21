#!/bin/bash
#############
#Clark brooks
############
# Setting server infrastructure

git clone git@github.com:Enterprise-Automation/trainee-challenge-node-app.git

scp Gateway_Script.bash DHCP_Script.bash DNS_Script.bash root@192.168.3.107:/bin

ssh root@192.168.3.107 "chmod 777 /bin/Gateway_Script.bash /bin/DHCP_Script.bash /bin/DNS_Script.bash"

ssh -t root@192.168.3.107 'scp /bin/DHCP_Script.bash root@10.0.0.2:/bin'
ssh -t root@192.168.3.107 'scp /bin/DNS_Script.bash root@10.0.0.3:/bin && exit'


echo "Running Gateway_Script.bash"
ssh root@192.168.3.107 "/bin/Gateway_Script.bash && exit"


echo "Running DHCP_Script.bash on 10.0.0.2"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "/bin/DHCP_Script.bash && exit"


echo "Running DNS_Script.bash on 10.0.0.3"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "/bin/DNS_Script.bash && exit"

echo "Network is full network restart"
#full network restart
ssh root@192.168.3.107 "ifdown ens160 && ifup ens160"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "ifdown ens160 && ifup ens160"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "ifdown ens160 && ifup ens160"


ssh root@192.168.3.107 "systemctl restart NetworkManager"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "systemctl restart NetworkManager"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "systemctl restart NetworkManager"


echo "All serversse have been installed. Enjoy your new network"

echo "Setting up apps now"


git clone https://github.com/Enterprise-Automation/trainee-challenge-node-app.git
zip trainee-challenge-node-app.zip trainee-challenge-node-app 

scp App_installer.bash root@192.168.3.107:/bin

ssh root@192.168.3.107 "chmod 777 /bin/App_installer.bash"
ssh -t root@192.168.3.107 "scp /bin/App_installer.bash root@10.0.0.2:/"
ssh -t root@192.168.3.107 "scp /bin/App_installer.bash root@10.0.0.3:/"

ssh root@192.168.3.107 "/bin/App_installer.bash DHCP 80"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "/bin/App_installer.bash DNS 80"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "/bin/App_installer.bash Gateway 80"


