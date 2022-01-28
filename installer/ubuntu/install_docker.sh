#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd -P )"
. ${DIR}/../../configs/_color_codes.sh

if [ "$USER" != "root" ];then
    echo -e "${Red}need to run with sudo!${Color_Off}"
fi

sudo apt-get remove -y docker docker-engine docker.io containerd runc;
sudo apt-get update -y;
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y ;
sudo apt-get install -y docker-ce docker-ce-cli containerd.io;

