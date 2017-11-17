#!/bin/bash
sudo apt-get remove docker docker-engine docker.io -y
sudo apt-get update
sudo apt-get install -y\
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
     
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce -y
sudo groupadd docker
sudo usermod -aG docker $USER
