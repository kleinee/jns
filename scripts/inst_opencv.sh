#!/bin/bash
# script name:     inst_opencv.sh
# last modified:   2018/09/09
# sudo:            yes

script_name=$(basename -- "$0")
env="/home/pi/.venv/jns"

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

#------------------------------------------------------
apt install -y libjasper1 libjasper-dev
apt install -y libjpeg-dev libtiff5-dev libpng12-dev
apt install -y libilmbase12
apt install -y libopenexr22
apt install -y libgstreamer1.0-0
apt install -y libavcodec-extra57
apt install -y libavformat-dev
apt install -y libilmbase12
apt onstall -y libavcodec-dev
apt install -y libswscale-dev 
apt install -y libv4l-dev
apt install -y libgtk2.0-dev 
apt install -y libgtk-3-dev
apt install -y libxvidcore-dev 
apt install -y libx264-dev
#------------------------------------------------------

su - pi <<'EOF'
source /home/pi/.venv/jns/bin/activate
pip install opencv-python-headless
EOF

