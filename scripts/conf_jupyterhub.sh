#!/bin/bash
# script name:     conf_jupyterhub.sh
# last modified:   2019/09/01
# credits:         EWouters
# sudo:            yes

script_name=$(basename -- "$0")
env="/home/pi/.venv/jns"

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

# if jupyterhub directory exists, we keep it (-p)
# if configuration file exists, we overwrite it (-y)

# Make folder to store config
mkdir -p /etc/jupyterhub
cd /etc/jupyterhub
# Generate Config
$env/bin/jupyterhub -y --generate-config

target=/etc/jupyterhub/jupyterhub_config.py

# set up dictionary of changes for jupyterhub_config.py
declare -A arr
app='c.Spawner'
arr+=(["$app.cmd = "]="$app.cmd = ['$env/bin/jupyterhub-singleuser']")
arr+=(["$app.default_url = "]="$app.default_url = 'lab'")
arr+=(["$app.notebook_dir = "]="$app.notebook_dir = '/home/pi/notebooks'")
arr+=(["c.Authenticator.admin_users = "]="c.Authenticator.admin_users = {'pi'}")

# apply changes to jupyter_notebook_config.py

for key in ${!arr[@]};do
    if grep -qF $key ${target}; then
        # key found -> replace line
        sed -i "/${key}/c ${arr[${key}]}" $target
    else
        # key not found -> append line
        echo "${arr[${key}]}" >> $target
    fi
done