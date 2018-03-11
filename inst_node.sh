#!/bin/bash
# script name:     conf_jupyter.sh
# last modified:   2018/03/11
# sudo:            no

script_name=$(basename -- "$0")
env="/home/pi/.venv/jns"

if [ $(id -u) = 0 ]
then
   echo "usage: ./$script_name"
   exit 1
fi


# install nodejs and node version manager n
curl -L https://git.io/n-install | bash -s -- -y
