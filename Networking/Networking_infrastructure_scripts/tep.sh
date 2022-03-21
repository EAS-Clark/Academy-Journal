#!/bin/bash
#############
#Clark brooks
#############


#git clone https://github.com/Enterprise-Automation/trainee-challenge-node-app.git
#zip trainee-challenge-node-app.zip trainee-challenge-node-app 

ssh root@192.168.3.107 "chmod 777 /trainee-challenge-node-app.zip"
scp trainee-challenge-node-app.zip root@192.168.3.107:/bin


ssh -t root@192.168.3.107 'scp /trainee-challenge-node-app.zip root@10.0.0.2:/'
ssh -t root@192.168.3.107 "scp /trainee-challenge-node-app.zip root@10.0.0.3:/"

scp App_installer.bash root@192.168.3.107:/bin

ssh root@192.168.3.107 "chmod 777 /bin/App_installer.bash"
ssh -t root@192.168.3.107 'scp /bin/App_installer.bash root@10.0.0.2:/bin'
ssh -t root@192.168.3.107 "scp /bin/App_installer.bash root@10.0.0.3:/bin"


ssh -t root@192.168.3.107 ssh root@10.0.0.2 "/bin/App_installer.bash DNS 80"
ssh -t root@192.168.3.107 ssh root@10.0.0.3 "/bin/App_installer.bash Gateway 80"
ssh root@192.168.3.107 "/bin/App_installer.bash DHCP 80"


