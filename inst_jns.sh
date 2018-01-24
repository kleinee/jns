#!/bin/bash
# script name:     inst_jns.sh
# last modified:   2018/01/14
# sudo:            yes

script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

./prep.sh
./inst_tex.sh
./inst_pi_hardware.sh

sudo -u pi ./inst_stack.sh
sudo -u pi ./conf_jupyter.sh
./inst_julia.sh
