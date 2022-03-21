#!/bin/bash
#############
#Clark brooks
############
#Makes ssh key and sends them to vms 

ssh-keygen
ssh-copy-id root@192.168.3.107

#gateway
ssh root@192.168.3.107 "ssh-keygen"
ssh -t root@192.168.3.107 "ssh-copy-id root@10.0.0.2"
ssh -t root@192.168.3.107 "ssh-copy-id root@10.0.0.3"
#ssh -t root@192.168.3.107 "ssh-copy-id root@10.0.0.21"
