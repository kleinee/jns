#!/bin/bash
# script name:     inst_pi_hardware.sh
# last modified:   2018/01/14
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

git clone https://github.com/RPi-Distro/RTIMULib

cd ./RTIMULib/Linux/python/

python3 setup.py build
python3 setup.py install

cd /home/pi/jns

rm -rf RTIMULib

pip3 install sense-hat
pip3 install picamera
pip3 install gpiozero
