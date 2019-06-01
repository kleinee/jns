#!/bin/bash
# script name:     inst_julia-1.1.0.sh
# last modified:   2019/05/26
# sudo:            yes

SCRIPT_NAME=$(basename -- "$0")
JNS_USER='pi'
HOME_DIR="/home/$JNS_USER"
ENV="$HOME_DIR/.venv/jns"

JULIA_HOME=$HOME_DIR/julia/

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$SCRIPT_NAME"
   exit 1
fi

#
# apt install dependencies
#
apt install -y build-essential 
apt install -y libatomic1
apt install -y gfortran 
apt install -y perl 
apt install -y wget
apt install -y m4
apt install -y cmake 
apt install -y pkg-config
apt install -y libopenblas-base libopenblas-dev
apt install -y libatlas3-base libatlas-base-dev
apt install -y liblapack-dev
apt install -y libmpfr-dev libgmp3-dev
apt install -y libgfortran3

#
# download and install julia based on architecture
#
su pi <<ONE
    cd $HOME_DIR
    . $ENV/bin/activate
    ./dnld_julia-1.1.0-arm32bit.py
    unzip ./julia-1.1.0-arm32bit.zip
    
    ARCHITECTURE=$(python -c 'import os; print(str(os.uname()[4]));')
    if (("$ARCHITECTURE" == "armv7l"))
    then
        mv ./julia1.1.0-arm32bit/rpi3/julia-1.1.0.zip $HOME_DIR
    else
        mv ./julia1.1.0-arm32bit/rpizero/julia-1.1.0.zip $HOME_DIR
    fi

    unzip julia-1.1.0.zip
    mv julia-1.1.0 julia
    rm -rf julia1.1.0-arm32bit
    rm ./julia-1.1.0-arm32bit.zip
    rm ./julia-1.1.0.zip
    rm -rf __MACOSX/
ONE

#
# add symbolic link for julia executable
#

ln -s $JULIA_HOME/bin/julia /usr/local/bin/julia

#
#  install IJulia kernel
#

su pi <<TWO
    julia -e 'using Pkg; Pkg.add("IJulia");'
    julia -e 'using IJulia;'
TWO
