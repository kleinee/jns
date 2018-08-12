#!/bin/bash
# script name:     inst_jns.sh
# last modified:   2018/08/12
# sudo:            yes

script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

# make necessary preparations
./prep.sh

# install TeX OPTIONAL
./inst_tex.sh

# install support for Pi hardware OPTIONAL
sudo -u pi ./inst_pi_hardware.sh

# install Python packages 
sudo -u pi ./inst_stack.sh

# configure the server OPTIONAL
sudo -u pi ./conf_jupyter.sh

# install Julia and the IJulia kernel OPTIONAL
./inst_julia.sh

# install the SQLite3 kernel OPTIONAL
./inst_sqlite.sh

# set up service to start the server on boot OPTIONAL
./service.sh
