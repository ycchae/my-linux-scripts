#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd -P )"
. ${DIR}/../../configs/_color_codes.sh

set -e

if [ -z $GO_VERSION ];then
    GO_VERSION=1.15.3
fi
echo -e "${Cyan}**Check.**${Color_Off}"
echo -e "GOlang $GO_VERSION version will be installed"
echo -e "if you want to change the version execute the following command"
echo -e "GO_VERSION=xxx ./install_go.sh"
read -p "Continue? [y/n] "
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${BRed}STOPPED${Color_Off}"
    exit 1
fi

sudo wget -P /opt https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz;
sudo tar -C /usr/local -xzf /opt/go$GO_VERSION.linux-amd64.tar.gz;
cat <<EOF | sudo tee /etc/profile.d/golang_bin.sh
export PATH=\$PATH:/usr/local/go/bin
EOF
source /etc/profile.d/golang_bin.sh

echo -e "${Cyan}DONE${Color_Off}"
