#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd -P )"
. ${DIR}/../../configs/_color_codes.sh

set -e 

if [ "$USER" != "root" ];then
    echo -e "${Red}need to run with sudo!${Color_Off}"
fi

apt install bison build-essential cmake flex git libedit-dev libllvm7 llvm-7-dev libclang-7-dev python zlib1g-dev libelf-dev python3-pip -y
git clone https://github.com/iovisor/bcc.git /opt/bcc
mkdir /opt/bcc/build

cd /opt/bcc/build
cmake ..
make
make install
cmake -DPYTHON_CMD=python3 .. 
pushd src/python/
make
sudo make install
popd
