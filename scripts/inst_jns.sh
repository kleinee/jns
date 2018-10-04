#!/bin/bash
# script name:     inst_jns.sh
# last modified:   2018/09/19
# sudo:            yes

script_name=$(basename -- "$0")
script_dir=$(pwd)
log_file="$script_dir/jns.log"
revision=$(cat /proc/cpuinfo | grep Revision)
SECONDS=0

function log_duration(){
printf "%s %s %s %s %s\n" $(date +"%Y-%m-%d %T") ${revision:10} "$1" $SECONDS | tee -a $log_file
SECONDS=0
}

function log_message(){
printf "%s %s %s %s\n" $(date +"%Y-%m-%d %T") ${revision:10} "$1" | tee -a $log_file
}

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

# make necessary preparations
./prep.sh
log_duration "prep.sh"

# install Python packages 
sudo -u pi ./inst_stack.sh
log_duration "inst_stack.sh"

# configure the server
sudo -u pi ./conf_jupyter.sh
log_duration "conf_jupyter.sh"

#-----------------------------------------------

# install TeX OPTIONAL
./inst_tex.sh
log_duration "inst_tex.sh"

# install support for Pi hardware OPTIONAL
sudo -u pi ./inst_pi_hardware.sh
log_duration "inst_pi_hardware.sh"

# install Julia and the IJulia kernel OPTIONAL
./inst_julia.sh
log_duration "inst_julia.sh"

# install the SQLite3 kernel OPTIONAL
sudo -u pi ./inst_sqlite.sh
log_duration "inst_sqlite.sh"

# install opencv OPTIONAL
./inst_opencv.sh
log_duration "inst_opencv.sh"

# set up service to start the server on boot OPTIONAL
./conf_service.sh
log_duration "conf_service.sh"
