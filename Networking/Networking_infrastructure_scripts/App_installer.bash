#!/bin/bash
#############
#Clark brooks
#############
#Downloads and installs node app with all its dependencys


git clone https://github.com/Enterprise-Automation/trainee-challenge-node-app.git
zip trainee-challenge-node-app.zip trainee-challenge-node-app 


scp trainee-challenge-node-app.zip root@192.168.3.107:/

ssh -t root@192.168.3.107 'scp /trainee-challenge-node-app.zip root@10.0.0.2:/'
ssh -t root@192.168.3.107 'scp /trainee-challenge-node-app.zip root@10.0.0.3:/'

ssh root@192.168.3.107 "mkdir /var/app"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "mkdir /var/app"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "mkdir /var/app"

ssh root@192.168.3.107 "unzip /trainee-challenge-node-app.zip -d /var/app/"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "unzip /trainee-challenge-node-app.zip -d /var/app/"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "unzip /trainee-challenge-node-app.zip -d /var/app/"

ssh root@192.168.3.107 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"

ssh root@192.168.3.107 "npm install node.js"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "npm install node.js"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "npm install node.js"

ssh root@192.168.3.107 "cd /var/app/trainee-challenge-node-app && npm install node.js"
ssh -t root@192.168.3.107 ssh root@10.0.0.2 "cd /var/app/trainee-challenge-node-app && npm install node.js"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "cd /var/app/trainee-challenge-node-app && npm install node.js"


ssh root@192.168.3.107 echo "export TARGET_URL=DHCP
export PORT=80" >> ~/.bashrc

ssh -t root@192.168.3.107 ssh root@10.0.0.2 "echo 'export TARGET_URL=DNS
export PORT=80' >> ~/.bashrc"

ssh -t root@192.168.3.107 ssh root@10.0.0.3 "echo 'export TARGET_URL=Gateway
export PORT=80' >> ~/.bashrc"

ssh -t root@192.168.3.107 ssh root@10.0.0.2 "reboot"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "reboot"
ssh root@192.168.3.107 "reboot"





