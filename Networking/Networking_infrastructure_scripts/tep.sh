#!/bin/bash
#############
#Clark brooks
#############




#git clone https://github.com/Enterprise-Automation/trainee-challenge-node-app.git
#zip -r /trainee-challenge-node-app/


#scp trainee-challenge-node-app.zip root@192.168.3.107:/

#ssh -t root@192.168.3.107 'scp /trainee-challenge-node-app.zip root@10.0.0.2:/'
#ssh -t root@192.168.3.107 'scp /trainee-challenge-node-app.zip root@10.0.0.3:/'

#ssh root@192.168.3.107 "mkdir /var/app"
#ssh -t root@192.168.3.107 ssh root@10.0.0.2 "mkdir /var/app"
#ssh -t root@192.168.3.107 ssh root@10.0.0.3 "mkdir /var/app"

#ssh root@192.168.3.107 "unzip /trainee-challenge-node-app.zip -d /var/app/"
#ssh -t root@192.168.3.107 ssh root@10.0.0.2 "unzip /trainee-challenge-node-app.zip -d /var/app/"
#ssh -t root@192.168.3.107 ssh root@10.0.0.3 "unzip /trainee-challenge-node-app.zip -d /var/app/"

ssh root@192.168.3.107 "export TARGET_URL=DNS"
ssh root@192.168.3.107 "export PORT=80"



#ssh root@192.168.3.107 "export TARGET_URL=DHCP && export PORT=80"
#ssh -t root@192.168.3.107 ssh root@10.0.0.2 "export TARGET_URL='DNS' && export PORT='80'"
#ssh -t root@192.168.3.107 ssh root@10.0.0.3 "export TARGET_URL='Gateway' && export PORT='80'"

##ssh root@192.168.3.107 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"
#ssh -t root@192.168.3.107 ssh root@10.0.0.2 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"
#ssh -t root@192.168.3.107 ssh root@10.0.0.3 "firewall-cmd --permanent --add-port=80 && firewall-cmd --reload"







