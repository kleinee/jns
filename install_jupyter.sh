#!/bin/bash
# script name:     install_jupyter.sh
# last modified:   2017/02/06
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip3 install jupyter

#------------------------------------------------------
apt-get -y install libncurses5-dev
apt-get -y install python-dev
#------------------------------------------------------

pip3 install readline
pip3 install ipyparallel
