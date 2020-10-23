#!/bin/bash
set -e

yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-engine \
           -y

yum install yum-utils device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce docker-ce-cli containerd.io -y
echo "$(hostname): installing docker done"

systemctl -q is-active docker.service
if [ $? == 0 ]; then
    echo "$(hostname): docker.service is running"
else
    systemctl enable docker
    echo "$(hostname): start docker.service"
    systemctl start docker.service
fi

