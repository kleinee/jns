#!/bin/bash
# script name:     conf_service_jupyterhub.sh
# last modified:   2019/09/01
# credits:         mt08xx, EWouters
# sudo:            yes

script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

cat << 'ONE' | sudo tee /etc/systemd/system/jupyterhub.service
[Unit]
Description=JupyterHub

[Service]
Type=simple
ExecStart=/home/pi/.venv/jns/bin/jupyterhub -f /etc/jupyterhub/jupyterhub_config.py
User=root
Group=root
WorkingDirectory=/etc/jupyterhub
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
ONE

# start jupyterhub
systemctl daemon-reload
systemctl start jupyterhub
systemctl enable jupyterhub
