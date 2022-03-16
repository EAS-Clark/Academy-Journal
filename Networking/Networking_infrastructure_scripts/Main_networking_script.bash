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

echo "All serversse have been installed. Enjoy your new netowrk"




git clone https://github.com/Enterprise-Automation/trainee-challenge-node-app.git
zip -r /trainee-challenge-node-app/

scp trainee-challenge-node-app.zip root@192.168.3.107:/

ssh -t root@192.168.3.107 'scp /trainee-challenge-node-app.zip root@10.0.0.2:/bin'
ssh -t root@192.168.3.107 'scp /trainee-challenge-node-app.zip root@10.0.0.3:/bin'


ssh root@192.168.3.107 "unzip /trainee-challenge-node-app.zip /var/app/"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "unzip /trainee-challenge-node-app.zip /var/app/"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "unzip /trainee-challenge-node-app.zip /var/app/"

ssh root@192.168.3.107 "TARGET_URL = DHCP && PORT = 80"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "TARGET_URL = DNS && PORT = 80"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "TARGET_URL Gateway = && PORT = 80"

ssh root@192.168.3.107 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"

ssh root@192.168.3.107 "ifdown ens160 && ifup ens160"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "ifdown ens160 && ifup ens160"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "ifdown ens160 && ifup ens160"

