#!/bin/bash
# script name:     inst_jns.sh
# last modified:   2019/05/26
# sudo:            yes

script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

#-----------------------------------------------
# MANDATORY
#-----------------------------------------------

# make necessary preparations
./prep.sh

# install Python packages 
sudo -u pi ./inst_stack.sh

# configure server
sudo -u pi ./conf_jupyter.sh


#-----------------------------------------------
# OPTIONAL, RECOMMENDED
#-----------------------------------------------

# install TeX
./inst_tex.sh

# install support for Pi hardware
sudo -u pi ./inst_pi_hardware.sh

# set up service to start the server on boot
./conf_service.sh


#-----------------------------------------------
# OPTIONAL, DISABLED BY DEFAULT
#-----------------------------------------------

# install Julia 0.6.0 and the IJulia kernel NOT RECOMMENDED
# ./inst_julia-0.6.0.sh

# install Julia 1.1.0 and the IJulia kernel
# ./inst_julia-1.1.0.sh

# install R 3.6.0 and the IRkernel
# ./inst_R-3.0.6.sh

# install the SQLite3 kernel
# sudo -u pi ./inst_sqlite.sh

# install opencv
# ./inst_opencv.sh
