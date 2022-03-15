#!/bin/bash
#############
#Clark brooks
#############

git clone https://github.com/Enterprise-Automation/trainee-challenge-node-app.git
zip -r /trainee-challenge-node-app/
scp trainee-challenge-node-app.zip root@192.168.3.107:/bin

unzip trainee-challenge-node-app.zip
PATH = 
PORT =


#my pc 

ssh-keygen
ssh-copy-id root@192.168.3.107

#gateway
ssh-keygen

ssh-copy-id root@10.0.0.2
ssh-copy-id root@10.0.0.3
ssh-copy-id root@10.0.0.21




