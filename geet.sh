#!/bin/bash

echo "install dependecies"
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo "add docker repository to system"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

echo "update system"
sudo apt update -y

echo "install docker engine"
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "run docker without sudo"
sudo usermod -aG docker $(whoami)

echo "install docker compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "create directory for gitlab"
sudo mkdir -p /svr/{gitlab}

echo "remove gitlab"
sudo docker-compose down

echo "deploy gitlab"
sudo docker-compose up -d

echo "upgrade system"
sudo apt upgrade -y

echo "finish..."