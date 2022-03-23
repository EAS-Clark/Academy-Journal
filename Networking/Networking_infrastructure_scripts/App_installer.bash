#!/bin/bash
#############
#Clark brooks
#############
#Downloads and installs node app with all its dependencys


#echo "export TARGET_URL=HTTP://$1.clark.local" >> ~/.bashrc
#echo "export PORT=$2" >> ~/.bashrc

mkdir /var/app

unzip /trainee-challenge-node-app.zip -d /var/app/

firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload

npm install --prefix /var/app/trainee-challenge-node-app/ node
npm install --prefix /var/app/trainee-challenge-node-app/

TARGET_URL=HTTP://$1.clark.local PORT=$2 npm start --prefix /var/app/trainee-challenge-node-app/


#reboot
