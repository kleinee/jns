#!/bin/bash
# script name:     inst_tex.sh
# last modified:   2018/09/19
# sudo:            yes

script_name=$(basename -- "$0")
script_dir=$(pwd)
jns_user='pi'
home_dir="/home/$jns_user"
env="$home_dir/.venv/jns"

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

#------------------------------------------------------
apt install -y texlive-xetex
apt install -y latexmk
#------------------------------------------------------
