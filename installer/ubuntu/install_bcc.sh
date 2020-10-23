#!/bin/bash
. .color_codes

set -e 

if [ "$USER" != "root" ];then
    echo "${Red}need to run with sudo!${Color_Off}"
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
