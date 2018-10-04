#!/bin/bash
# script name:     conf_service.sh
# last modified:   2018/08/12
# credits:         mt08xx
# sudo:            yes

script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

# create jupyter.sh in /home/pi and make it executable
cat << 'ONE' > /home/pi/jupyter_start.sh && chmod a+x /home/pi/jupyter_start.sh
#!/bin/bash
. /home/pi/.venv/jns/bin/activate
jupyter lab
#jupyter notebook
ONE

cat << 'TWO' | sudo tee /etc/systemd/system/jupyter.service
[Unit]
Description=Jupyter

[Service]
Type=simple
ExecStart=/home/pi/jupyter_start.sh
User=pi
Group=pi
WorkingDirectory=/home/pi/notebooks
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
TWO

# start jupyter
systemctl daemon-reload
systemctl start jupyter
systemctl enable jupyter
