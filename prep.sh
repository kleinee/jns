#!/bin/bash
# script name:     prep.sh
# last modified:   2018/08/12
# sudo:            yes

script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

apt update && apt -y upgrade
apt -y install pandoc
apt -y install libxml2-dev libxslt-dev
apt -y install libblas-dev liblapack-dev
apt -y install libatlas-base-dev gfortran
apt -y install libtiff5-dev libjpeg62-turbo-dev
apt -y install zlib1g-dev libfreetype6-dev liblcms2-dev
apt -y install libwebp-dev tcl8.5-dev tk8.5-dev
apt -y install libharfbuzz-dev libfribidi-dev
apt -y install libhdf5-dev
apt -y install libnetcdf-dev
apt -y install python3-pip
apt -y install python3-venv
apt -y install libzmq3-dev
apt -y install sqlite3 

# dependencies for python-opencv-headless
#------------------------------------------------------
apt -y install libjasper-dev
apt -y install libjpeg-dev libtiff5-dev libpng-dev
apt -y install libilmbase12
apt -y install libopenexr22
apt -y install libgstreamer1.0-0
apt -y install libavcodec-extra57
apt -y install libavformat-dev
apt -y install libilmbase12
apt -y install libavcodec-dev
apt -y install libswscale-dev
apt -y install libv4l-dev
apt -y install libgtk2.0-dev
apt -y install libgtk-3-dev
apt -y install libxvidcore-dev
apt -y install libx264-dev
#------------------------------------------------------
