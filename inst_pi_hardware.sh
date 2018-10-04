#!/bin/bash
# script name:     inst_pi_hardware.sh
# last modified:   2018/10/04
# sudo: no

script_name=$(basename -- "$0")
env="/home/pi/.venv/jns"

if [ $(id -u) = 0 ]
then
   echo "usage: ./$script_name"
   exit 1
fi

# activate virtual environment
source $env/bin/activate

pip install RTIMULib
pip install sense-hat
pip install picamera
pip install gpiozero
