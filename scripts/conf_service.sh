#!/bin/bash
# script name:     conf_service.sh
# last modified:   2018/09/19
# credits:         mt08xx
# sudo:            yes

script_name=$(basename -- "$0")
script_dir=$(pwd)
jns_user='pi'
home_dir="/home/$jns_user"
env="$home_dir/.venv/jns"

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

# create jupyter.sh in $home_directory and make it executable
cat << ONE > $home_dir/jupyter_start.sh && chmod a+x $home_dir/jupyter_start.sh
#!/bin/bash
. $env/bin/activate
jupyter lab
#jupyter notebook
ONE

cat << TWO | sudo tee /etc/systemd/system/jupyter.service
[Unit]
Description=Jupyter
[Service]
Type=simple
ExecStart=$home_dir/jupyter_start.sh
User=pi
Group=pi
WorkingDirectory=$home_dir/notebooks
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
TWO

# start jupyter
systemctl daemon-reload
systemctl start jupyter
systemctl enable jupyter
