#!/bin/bash
# script name:     inst_julia.sh
# last modified:   2018/01/14
# sudo:            yes

env=/home/pi/.venv/jns
script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

#apt -y install julia

su pi <<EOF
source $env/bin/activate
#julia -e 'Pkg.add("IJulia")'
julia -e 'using IJulia'
julia -e 'Pkg.add("SenseHat")'
julia -e 'using SenseHat'
julia -e 'Pkg.add("PIGPIO")'
julia -e 'using PIGPIO'
EOF
