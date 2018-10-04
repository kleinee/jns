[![hardware](https://img.shields.io/badge/hardware-Raspberry_Pi-red.svg)](https://www.raspberrypi.org/products/)
[![os](https://img.shields.io/badge/OS-Raspbian_Stretch_Lite-blue.svg)](https://www.raspberrypi.org/downloads/raspbian/)
![python](https://img.shields.io/badge/python-3.5.3-green.svg)
![nodejs](https://img.shields.io/badge/nodejs-v8.11.4-green.svg)
[![jupyter](https://img.shields.io/badge/more_info-jupyter-orange.svg)](http://jupyter.org)
[![jupyter](https://img.shields.io/badge/more_info-piwheels-yellow.svg)](https://www.piwheels.org)

# Jupyter Notebook & Lab Server on Raspberry Pi
## Intro

[Project Jupyter](https://jupyter.org) not only revolutionizes data-heavy research across domains - it also boosts personal productivity for problems on a much smaller scale. Due to openness it is an amazing platform for exploring concepts and learning new things.

I started setting up a Jupyter Notebook Server on a [Raspberry Pi](https://www.raspberrypi.org) following [this blog post](https://arundurvasula.wordpress.com/2014/04/01/remote-ipython-notebook-with-raspberry-pi/) by Arun Durvasula. Convinced of the potential of the platform I followed the development. 

My personal exercise soon taught me a great deal about the underlying architcture. Given Jupyter's complexity, speed of growth and scale, it is remarkable that such a system runs fine on a Raspberry Pi.

This repository isn't really anything genuine: I owe big thanks to many contributors in the Jupyter, Raspberry Pi, Linux, Python, Julia and greater Open Source communities for providing all the beautiful building blocks - small and large.

### What is new?

* Rather than installing the latest version of Python as I did the past, I decided that the new version would use the latest Python 3 version supported in Raspbian - as of this writing Python 3.5.3.
* Whilst this seems to be a step backwards, it is a in fact a giant step forward as you benefit from significant installation speedups made possible by the recently released [piwheels](https://www.piwheels.org) project.
* The scripts work across the entire range of Raspberry Pis - including the early models with just 256MB of memory.
* Python support for GPIO, Sense HAT and PICAMERA is installed without the earlier worries of breaking things on system level.
* All Python modules are pip installed into a virtual environment following advice found online: ***You should never use `sudo pip install` -NEVER***. Well I did this in the past and it certainly had me and users confused. We have to learn certain things the hard way to really appreciate the benefits of doing them right. It is worth reading up on this in [this blogpost](http://jakevdp.github.io/blog/2017/12/05/installing-python-packages-from-jupyter/).
* You now install Python packages into a virtual environment created with `venv` using a `requirements.txt` file. This really achieves a more maintainable setup, opens up more possibilities and hopefully makes this project more useful for the Raspberry Pi and Jupyter communities.
* Python 3, Julia and Bash kernels are installed and configured during installation.
* JupyterLab is installed and ready to use.

## What do you need to follow along?

* a ***Raspberry Pi model of your choice*** complete with micro-usb power-supply - I recommend a Raspberry Pi 3 but the setup should work across the entire range of Pi models, perhaps with the exception of the very early models that featured only 256MB of memory. I tested on a ZeroW, 1, 2 and 3. 
* a (micro) SD card with 16GB capacity or more to suit your Pi model with [Raspbian Stretch Lite](https://www.raspberrypi.org/downloads/raspbian/) installed and configured to permit access via ssh as user ***pi***.
* an ethernet or wifi connection for the Pi
* internet access on the Pi
* a computer to carry out the installation connected to the same network as the Pi
* ***LESS TIME THAN EVER BEFORE*** due to the recent release of [piwheels](https://www.piwheels.org). Users new to this project might argue that the setup is still time-consuming. Believe me: In the past 6 hours+ were not uncommon and installing the system on a Raspberry Pi 1 was not impossible but required quite some patience and time. Note that some packages listed in `requirements.txt` may not yet be available as Python wheels. Such packages are then built from source and this takes some time...  

## Installation

### IMPORTANT NOTE  on fresh installations
* an increasing number of users seem to install on top of images that have 'nodejs' already installed.
* The scripts in this repository were initially designed to work based on ***Raspbian Stretch Lite*** as a starting point with the intention to run the server headless in order to maximise memory available for data analysis.
* One such starting point is the desktop  version of ***Raspbian Stretch*** which comes with`nodejs` (and `git`) pre-installed. `conf_jupyter.sh` explained later now checks for the existence of `node` and only installs it if not yet present on the system.
 
* ***For the scripts to run properly on the desktop version of Raspbian or any other startingpoint with `node` installed, it is necessary that `node` is version 5 or higher !!!***

* If you start with a fresh Raspbian Stretch Desktop image, you can uninstall `node` using `apt purge nodejs` and then execute the scripts.

### First boot with fresh SD card
* ssh into your Raspberry Pi with the the fresh install of Raspbian Stretch Lite as user ***pi***. Then run `sudo raspi-config` and set the memory split to 16MB, expand the file-system and set a new password for the user pi. When done, reboot and log in again via ssh.

* If not yet present,  install `git`:

```bash
sudo apt install -y git
```

* With preparations out of the way clone this repository into the home directory of user ***pi***

```bash
git clone https://github.com/kleinee/jns
```
* Change into the new directory `~/jns/scripts` just created with `git`:

```bash
cd ~/jns/scripts
```

Technically you can now run `sudo ./inst_jns.sh` which is the installer script that combines the steps described below.  If you follow along I assume that you run all scripts from inside the directory `~/jns/scripts`.

You might not want all features on your system. Feel free to edit `inst_jns.sh' to suit your requirements.

## Install required Raspbian packages with apt

```bash
sudo ./prep.sh
```

A couple of packages from the Raspbian repository are required during installation and later for a some Python packages to work properly. The script just fetches these packages and installs them.

```bash
#!/bin/bash
# script name:     prep.sh
# last modified:   2018/09/19
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

# increase SWAP_SIZE
sed -i -e 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/' /etc/dphys-swapfile
/etc/init.d/dphys-swapfile stop
/etc/init.d/dphys-swapfile start

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
```

## Install required Python 3 packages with pip

```bash
./inst_stack.sh
```
* This creates a virtual Python 3 environment '/home/pi/.venv/jns' and activates it temporarily
* It then updates `pip3` to the latest version available from the Python package repository before it processes the `requirements.txt` file line by line. 
* This is a workaround to prevent `pip` from failing if one or more requirements listed fail to install.

```bash
#!/bin/bash
# script name:     inst_stack.sh
# last modified:   2018/09/19
# sudo: no

script_name=$(basename -- "$0")
script_dir=$(pwd)
jns_user='pi'
home_dir="/home/$jns_user"
env="$home_dir/.venv/jns"

if [ $(id -u) = 0 ]
then
   echo "usage: ./$script_name"
   exit 1
fi

if [ ! -d "$env" ]; then
  python3 -m venv $env
fi

# activate virtual environment
source $env/bin/activate

pip3 install pip==9.0.0
pip3 install setuptools
pip3 install -U pip

cat requirements.txt | xargs -n 1 pip install
```

## Configure Jupyter

```bash
./conf_jupyter.sh
```

With this script you generate a jupyter notebook configuration directory and in it a file called `jupyter_notebook_config.py` that holds the configuration settings for your notebook / lab server. You also create a folder notebooks in the home directory of user `pi` as the `notebook_dir` for your server. In the configuration file, you apply the following changes:

* tell jupyter not to sart a browser upon start - we access the server from a remote machine on the same network
* set the IP address to '*' 
* set the port for the notebook server to listen to 8888
* enable `mathjax` for rendering math in notebooks
* set the notebook_dir to `~/notebooks`
* use the password hash for the default server password `jns`

NOTE: This setup still uses password authentication. If you prefer token-based authentication, you have to change settings in the config file `/home/pi/.jupyter/jupyter_notebook_config.py`. Documentation of possible configuration settings can be found [here](https://jupyter-notebook.readthedocs.io/en/stable/index.html).

After the basic configuration the script activates the bash kernel and activates extensions for Jupyter Notebook and JupyterLab. At the JupyterLab end this requires intstallation of `node` followed by installation of the underlying JS infrastructure which is a bit time-consuming but ultimately allows you to use `ipywidgets`, `bqplot` and potentially other extensions.

```bash
#!/bin/bash
# script name:     conf_jupyter.sh
# last modified:   2018/09/20
# sudo:            no

script_name=$(basename -- "$0")
script_dir=$(pwd)
jns_user='pi'
home_dir="/home/$jns_user"
env="$home_dir/.venv/jns"

if [ $(id -u) = 0 ]
then
   echo "usage: ./$script_name"
   exit 1
fi

# activate virtual environment
source $env/bin/activate

# generate config and create notebook directory
# if notebook directory exists, we keep it (-p)
# if configuration file exeists, we overwrite it (-y)

jupyter notebook -y --generate-config
cd $home_dir
mkdir -p notebooks

target=$home_dir/.jupyter/jupyter_notebook_config.py

# set up dictionary of changes for jupyter_config.py
declare -A arr
app='c.NotebookApp'
arr+=(["$app.open_browser"]="$app.open_browser = False")
arr+=(["$app.ip"]="$app.ip ='*'")
arr+=(["$app.port"]="$app.port = 8888")
arr+=(["$app.enable_mathjax"]="$app.enable_mathjax = True")
arr+=(["$app.notebook_dir"]="$app.notebook_dir = '/home/pi/notebooks'")
arr+=(["$app.password"]="$app.password = 'sha1:5815fb7ca805:f09ed218dfcc908acb3e29c3b697079fea37486a'")
arr+=(["$app.allow_remote_access"]="$app.allow_remote_access  = True")
arr+=(["$app.quit_button"]="$app.quit_button  = False")

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

# install bash kernel
python3 -m bash_kernel.install

# install extensions
jupyter serverextension enable --py jupyterlab
jupyter nbextension enable --py widgetsnbextension --sys-prefix
jupyter nbextension enable --py --sys-prefix bqplot

# activate clusters tab in notebook interface
$env/bin/ipcluster nbextension enable --user

# install nodejs and node version manager n
# if node is not yet installed
if which node > /dev/null
    then
        echo "node is installed, skipping..."
    else
        # install nodejs and node version manager n
        cd $home_dir
        curl -L https://git.io/n-install | bash -s -- -y lts
        cd $script_dir 
fi

# install jupyter lab extensions
bash -i $script_dir/inst_lab_ext.sh
```
The script ```inst_lab_ext.sh``` - introduced by @Kevin--R to fix issue#23 has the following content:

```bash
#!/bin/bash
# script name:     inst_lab_ext.sh
# last modified:   2018/09/19
# sudo:            no

script_name=$(basename -- "$0")
script_dir=`dirname $0`
jns_user='pi'
home_dir="/home/$jns_user"
env="$home_dir/.venv/jns"

if [ $(id -u) = 0 ]
then
   echo "usage: ./$script_name"
   exit 1
fi

. $home_dir/.bashrc
. $env/bin/activate
jupyter lab clean
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter labextension install bqplot --no-build
jupyter labextension install jupyterlab_bokeh --no-build
jupyter lab build
```

## Start and access your server

### Activate the virtual environment
Since you used a virtual environment to install Python modules, you need to activate this environment before you can start your server:


```bash
source /home/pi/.venv/jns/bin/activate
```

The prompt will change to indicate successfull activation preceding `pi@hostname:` with the envireonment name - in case pf this setup `(jns)`. With hostname set to `zerow` it looks like this:

```bash
(jns) pi@zerow:~ $
```

### Before you proceed
After installation completes, you will still need to activate the change made to `~\.bashrc` when node was installed before doing anything that requires node.

You can be accomplish this by any of the following:
- reboot
- logout and log back in
- call `. ~/.bashrc` from the command line

That's the reason for this warning during node installation:
```
  IMPORTANT: OPEN A NEW TERMINAL TAB/WINDOW or run `. /home/pi/.bashrc`
             before using n and Node.js.
```
You can see this by running the following commands after your installation completes:
```bash
pi@test-pi:~/jns $ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
pi@test-pi:~/jns $ . ~/.bashrc
pi@test-pi:~/jns $ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/home/pi/n/bin
pi@test-pi:~/jns $ 
```
If you look at your **$PATH** environment variable and see **/home/pi/n/bin** you are ready to use node.

Also note that if you uninstall node with `n-uninstall` **/home/pi/n/bin** will remain in your **$PATH** environment variable until you reboot or logout and log back in.


### Start the server
To start your server just type `jupyter notebook` or `jupyter lab` 

### Access the server
To access your server form a webbrowser on a computer running on the same network as your Raspberry Pi, just open a browser and use the Pi's IP address / port 8888 as the url. 

```bash
xxx.xxx.xxx.xxx:8888
```

Change `xxx.xxx.xxx.xxx' to the IP address of the Raspberry Pi.

### Login
During the configuration the default password for the server was set to `jns`. You can change this by typing:

```bash
(jns) pi@zerow:~ $ jupyter notebook password
Enter password:  ****
Verify password: ****
```

## Install TeX (optional)

```bash
sudo ./inst_tex.sh
```

* [TeX](https://en.wikipedia.org/wiki/TeX) (and [Pandoc](http://pandoc.org)) are used under the hood to convert Jupyter notebooks to other formats including PDF.
* Whilst not strictly necessary if no PDF export is rquired, I still recommend to run this step.

```bash
#!/bin/bash
# script name:     inst_tex.sh
# last modified:   2018/09/19
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

#------------------------------------------------------
apt install -y texlive-xetex
apt install -y latexmk
#------------------------------------------------------
```

## Install Julia and the IJulia kernel (optional)

```bash
sudo ./inst_julia.sh
```

* [Julia](https://julialang.org) is a relatively new high-level, high-performance dynamic programming language for numerical computing trying to combine the ease of Python with the speed of C. Thanks to the efforts of the Raspberry Pi community `Julia 0.6.0` is available in the Raspbian Stretch Repository. It is really worth a try as the language is a rising star in scientific computing.

* [IJulia](https://github.com/JuliaLang/IJulia.jl) is the kernel required for Jupyter Notebook / JupyterLab. Backgroud information on Julia on the Raspberry Pi can be found [here](https://www.raspberrypi.org/blog/julia-language-raspberry-pi/).

```bash
#!/bin/bash
# script name:     inst_julia.sh
# last modified:   2018/09/19
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

apt -y install julia

su pi <<EOF
source $env/bin/activate
julia -e 'Pkg.add("IJulia");'
julia -e 'using IJulia;'
EOF
```
## Install the SQLite kernel (optional)

* I found the [SQLite kernel](https://github.com/brownan/sqlite3-kernel) quite useful in some experiments with SQLite3 databases in Jupyter Notebooks.

```bash
./inst_sqlite.sh
```

```bash
#!/bin/bash
# script name:     inst_sqlite,sh
# last modified:   2018/09/19
# sudo:            no

script_name=$(basename -- "$0")
script_dir=$(pwd)
jns_user='pi'
home_dir="/home/$jns_user"
env="$home_dir/.venv/jns"

if [ $(id -u) = 0 ]
then
   echo "usage: ./$script_name"
   exit 1
fi

# activate virtual environment
source $env/bin/activate

# clone SQLite kernel repository
git clone https://github.com/brownan/sqlite3-kernel.git

# install kernel
cd sqlite3-kernel
python setup.py install
python -m sqlite3_kernel.install
cd $script_dir
rm -rf sqlite3-kernel/
```

## Install Python support for Raspberry Pi hardware (optional)

```bash
./inst_pi_hardware.sh
```

Setting up Python support for GPIO pins, the PICAMERA module and Sense HAT hardware in your virtual environment is almost as simple as you would commonly do without such environment.

```bash
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
```
## Install openCV (optional)

```bash
#!/bin/bash
# script name:     inst_opencv.sh
# last modified:   2018/09/19
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

#------------------------------------------------------
apt install -y libjasper libjasper-dev
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

su - pi <<EOF
source $env/bin/activate
pip install opencv-python-headless
EOF
```

## Start the server at boot with systemd (optional)
Credits for the following solution go to mt08xx:

* create an executable file named 'start_jupyter.sh' in '/home/pi' used to start the server
* create a file named 'jupyter.service' in '/etc/systemd/system'
* start the service

To do this run:

```bash
sudo ./conf_service.sh
```

The file has the following content:

```bash
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
```

* Next time you boot your Pi, the service is stared automatically.
* To stop the service for system updates run:

```bash
sudo systemctl stop jupyter
```

## Put it all together

This script is just convenience - it executes the individual steps described above in the order necessary.
You may want to comment out optional features that you do not need. By default all features are activated.

```bash
#!/bin/bash
# script name:     inst_jns.sh
# last modified:   2018/09/19
# sudo:            yes

script_name=$(basename -- "$0")
script_dir=$(pwd)
log_file="$script_dir/jns.log"
revision=$(cat /proc/cpuinfo | grep Revision)
SECONDS=0

function log_duration(){
printf "%s %s %s %s %s\n" $(date +"%Y-%m-%d %T") ${revision:10} "$1" $SECONDS | tee -a $log_file
SECONDS=0
}

function log_message(){
printf "%s %s %s %s\n" $(date +"%Y-%m-%d %T") ${revision:10} "$1" | tee -a $log_file
}

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

# make necessary preparations
./prep.sh
log_duration "prep.sh"

# install Python packages 
sudo -u pi ./inst_stack.sh
log_duration "inst_stack.sh"

# configure the server
sudo -u pi ./conf_jupyter.sh
log_duration "conf_jupyter.sh"

#-----------------------------------------------

# install TeX OPTIONAL
./inst_tex.sh
log_duration "inst_tex.sh"

# install support for Pi hardware OPTIONAL
sudo -u pi ./inst_pi_hardware.sh
log_duration "inst_pi_hardware.sh"

# install Julia and the IJulia kernel OPTIONAL
./inst_julia.sh
log_duration "inst_julia.sh"

# install the SQLite3 kernel OPTIONAL
sudo -u pi ./inst_sqlite.sh
log_duration "inst_sqlite.sh"

# install opencv OPTIONAL
./inst_opencv.sh
log_duration "inst_opencv.sh"

# set up service to start the server on boot OPTIONAL
./conf_service.sh
log_duration "conf_service.sh"
```

## Keep your installation up to date
### Raspbian operating system

* just run `sudo apt update && sudo apt -y upgrade`

### Python 3 packages

* activate the virtual environment with `source /home/pi/.venv/jns/bin/activate`

* list outdated packages with `pip3 list --outdated`

* Update `package` with `pip3 install -U package` where `package` is the name of package you want to update.

