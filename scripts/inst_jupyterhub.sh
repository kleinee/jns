#!/bin/bash
# script name:     inst_jupyterhub.sh
# last modified:   2019/09/01
# credits:         EWouters
# sudo:            yes

script_name=$(basename -- "$0")
env="/home/pi/.venv/jns"

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

# apt install -y nodejs
# apt install -y npm
# apt install -y nodejs-legacy

su - pi <<'EOF'
source /home/pi/.venv/jns/bin/activate
pip3 install jupyterhub
EOF

npm install -g configurable-http-proxy # Not sure if this needs to be run as root