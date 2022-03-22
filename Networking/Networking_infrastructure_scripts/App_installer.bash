#!/bin/bash
#############
#Clark brooks
#############
#Downloads and installs node app with all its dependencys


echo "export TARGET_URL=$1" >> ~/.bashrc
echo "export PORT=$2" >> ~/.bashrc

mkdir /var/app

unzip /trainee-challenge-node-app.zip -d /var/app/

firewall-cmd --zone=public --add-service=http
firewall-cmd --reload

npm install --prefix /var/app/trainee-challenge-node-app/ node
npm install --prefix /var/app/trainee-challenge-node-app/

reboot
