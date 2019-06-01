#!/bin/bash
# script name:     inst_julia-0.6.0.sh
# last modified:   2018/05/23
# sudo:            yes

env=/home/pi/.venv/jns
script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

apt -y install julia

su pi <<EOF
source $env/bin/activate
julia -e 'Pkg.add("IJulia");'
julia -e 'using IJulia;'
EOF
