#!/bin/bash
#############
#Clark brooks
#############




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




