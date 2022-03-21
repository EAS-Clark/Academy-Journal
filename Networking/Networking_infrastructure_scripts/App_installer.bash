#!/bin/bash
#############
#Clark brooks
#############
#Downloads and installs node app with all its dependencys


echo "export TARGET_URL=$1" >> ~/.bashrc
echo "export PORT=$2" >> ~/.bashrc

mkdir /var/app

unzip /trainee-challenge-node-app.zip -d /var/app/

firewall-cmd --permanent --add-port=80 
firewall-cmd --reload

npm install node.js

npm i --prefix /var/app/trainee-challenge-node-app
reboot
