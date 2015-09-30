#!/bin/bash
# script name:     install_jupyter.sh
# last modified:   2015/09/22
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip install jupyter

#------------------------------------------------------
apt-get -y install libncurses5-dev
#------------------------------------------------------

pip install readline
pip install ipyparallel
