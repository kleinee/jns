
# Jupyter Notebook Server on Raspberry Pi 2 and 3

## Intro
Sliderules are a thing of the past, decent calculators are hard to get by these days and spreadsheets are somewhat cumbersome, at times outright dangerous or just not the right tool for many tasks. Project Jupyter not only revolutionizes data-heavy research in all domains - it also boosts personal productivity for problems on a much smaller scale. 

This repository documents my efforts to set up and configure a Jupyter Notebook Server on a Raspberry Pi 2 or 3 complete with Python 3.6.0, fully functioning nbconvert and a basic scientific stack with version 4.0 or later of all components making up the brilliant Jupyter interactive computing environment.

## Requirements
* a Raspberry Pi 2 or 3 complete with 5V micro-usb power-supply
* a blank 16 GB micro SD card
* an ethernet cable to connect the Pi to your network *) 
* an internet connection
* a computer to carry out the installation connected to the same network as the Pi
* a fair amount of time

## Preparing the Raspbian Jessie Lite Image 
Download the official Raspbian Jessie Lite image and transfer it to your SD card. Boot the Pi with the fresh image, log in (root password is raspbian and default user is pi) to  set up timezone and locales and expand the filesystem using the raspi-config utility:

```bash
sudo raspi-config
```

Ensure that your installation is up to date and then use apt-get to install pandoc and git:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y pandoc
sudo apt-get install -y git
```

Set up new user jns (jns stands for ***j***upyter ***n***otebook ***s***erver) and add the new user to the groups sudo and ssh as we are going to use this user to perform the installation and later to start the server.

```bash
sudo adduser jns
sudo usermod -aG sudo,ssh jns
```

## Clone the GitHub Repository

Reboot and log in as user jns via ssh. From the terminal run:

```bash
cd /home/jns
git clone https://github.com/kleinee/jns.git
cd jns
chmod +x *.sh
```

## Server Installation
```bash
sudo ./install_jns.sh
```

This will create a directory notebooks in the home directory of user jns, clone this repository to get the installtion scripts, make the scripts executable and then run install_jns.sh which does the following:

* install Python
* install jupyter
* (pre)-configure the notebook server
* install TeX
* install scientific stack

The script is nothing spectacular - just convenience to save us some typing. The next section briefly describes the individual steps.

```bash
#!/bin/bash
# script name:     install_jns.sh
# last modified:   2015/09/30
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

# run scripts
./install_python.sh
./install_jupyter.sh
sudo -u jns ./configure_jupyter.sh
./install_tex.sh
./install_stack.sh
```

If everything goes to plan you end up with a fully functional Jupyter Notebook server!!! To start the server just run:

```bash
jupyter notebook 
```
You should now be able to access the system from any browser on your network via the IP address of the Raspberry Pi on port 8888. The **notebook server password*** set during installation is ***jns***. This can be changed if requirerd.

## Step by Step Installation + Configuration
If you prefer a setp by step installation, execute the respective shell scripts in the order given below: 

* To install Python 3.6.0 run ``` install_python.sh```
* To install TeX run ```install_tex.sh```
* To install Jupyter run ```install_jupyter.sh```
* To configure Jupyter run ```configure_jupyter.sh```
* To install scientific stack run ```install_stack.sh```

### Python 3.6.0 Installation
Instructions for building Python from source can be found [here](http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html). I adjusted them to suit installation of Python 3.6.0 and turned the instructions into a script:

```bash
#!/bin/bash
# script name:     install_python.sh
# last modified:   2016/12/25
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#Python 3 version to install
version="3.6.0"

#------------------------------------------------------
apt-get install -y build-essential libncursesw5-dev
apt-get install -y libgdbm-dev libc6-dev
apt-get install -y zlib1g-dev libsqlite3-dev tk-dev
apt-get install -y libssl-dev openssl
#------------------------------------------------------

wget "https://www.python.org/ftp/python/$version/Python-$version.tgz"
tar zxvf "Python-$version.tgz"
cd "Python-$version"
./configure
make
make install
pip3 install pip --upgrade

# soft link to make pip3 default

ln -s /usr/local/bin/pip3 /usr/local/bin/pip

# clean up

cd ..

rm -rf "./Python-$version"
rm "./Python-$version.tgz"
```

### TeX Installation
We need TeX for notebook conversion to PDF format with nbconvert / pandoc.

```bash
#!/bin/bash
# script name:     install_tex.sh
# last modified:   2016/12/22
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#------------------------------------------------------
apt-get install -y texlive
apt-get install -y texlive-latex-extra
apt-get install -y dvipng
apt-get install -y texlive-xetex
#------------------------------------------------------
```

### Jupyter Installation
The developers made this step amazingly simple. The only minor issue that I came across was that IPython complained about missing readline upon first start. We adress this here by installing readline. We also install ipyparallel as it is not installed by default.

```bash
#!/bin/bash
# script name:     install_jupyter.sh
# last modified:   2015/09/22
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip install jupyter

#------------------------------------------------------
apt-get -y install libncurses5-dev
#------------------------------------------------------

pip install readline
pip install ipyparallel
```

### Jupyter Configuration
We generate a jupyter notebook configuration directory and in it a file called jupyter_notebook_config.py that holds the configuration settings for our notebook server. We also create a folder notebooks in the home directory of user jns as the notebook_dir for our server. In the notebook configuration file, we apply the following changes:

* we tell jupyter not to sart a browser upon start - we access the server from a remote machine
* we set the IP address to '*' 
* we set the port for the notbook server to listen on to 8888 which seems to be the defaut used by most installtions
* we enable mathjax for rendering math in notebooks
* we set the notebook_dir to ~/notebooks, the directory we created
* we use the password hash for the default server password jns

To change settings upon installation, just edit ./jupyter/jupyter_notebook_config.py to suit your needs.

```bash
#!/bin/bash
# script name:     configure_jupyter.sh
# last modified:   2016/12/25
# sudo:            no

if [ $(id -u) = 0 ]
then
   echo "to be run as jns"
   exit 1
fi

# generate config and create notebook directory
jupyter notebook --generate-config
cd $home
mkdir notebooks  

target=~/.jupyter/jupyter_notebook_config.py

# set up dictionary of changes for jupyter_config.py
declare -A arr
app='c.NotebookApp' 
arr+=(["$app.open_browser"]="$app.open_browser = False")
arr+=(["$app.ip"]="$app.ip ='*'")
arr+=(["$app.port"]="$app.port = 8888")
arr+=(["$app.enable_mathjax"]="$app.enable_mathjax = True")
arr+=(["$app.notebook_dir"]="$app.notebook_dir = '/home/jns/notebooks'")
arr+=(["$app.password"]="$app.password =\
'sha1:5815fb7ca805:f09ed218dfcc908acb3e29c3b697079fea37486a'")

# apply changes to jupyter_notebook_config.py

# change or append
for key in ${!arr[@]};do
    if grep -qF $key ${target}; then
        # key found -> replace line
        sed -i "/${key}/c ${arr[${key}]}" $target
    else
        # key not found -> append line
        echo "${arr[${key}]}" >> $target
    fi
done
```
To enable the clusters tab in the notebook interface run:

```bash
sudo ipcluster nbextension enable
```

### Installation of Scientific Stack
The list of packages istalled here is just a suggestion. Feel free to adjust as needed.

```bash
#!/bin/bash
# script name:     install_stack.sh
# last modified:   2015/11/21
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip install numpy
pip install matplotlib
pip install sympy
pip install pandas
pip install numexpr
pip install bottleneck
pip install SQLAlchemy
pip install openpyxl
pip install xlrd
pip install xlwt
pip install XlsxWriter
pip install beautifulsoup4
pip install html5lib

#------------------------------------------------------
apt-get -y install libxml2-dev libxslt-dev
#------------------------------------------------------

pip install lxml
pip install requests
pip install networkx
pip install plotly

#-----------------------------------------------------
apt-get -y install libblas-dev liblapack-dev
apt-get -y install libatlas-base-dev gfortran
#-----------------------------------------------------

pip install scipy
```

## Keeping Your Installation up-to-date
Occasionally you may want to check for software updates for both the operating system and the python python packages we installed.

### Operating System
```bash
sudo apt-get update
sudo apt-get upgrade
```

### Python Packages
List outdated packages and if there are any, update them individually. Here we assume that package xyz is to be updated after the check:
```bash
pip list --outdated --format='legacy'
sudo pip install xyz --upgrade
```

The script below automates the process: It genereates a list of outdated (pip installed) packages and subsequently processes the list to conduct upgrades.

```bash
#!/bin/bash
# script name:     upgrade_jns.sh
# last modified:   2015/11/22
# sudo:            yes

if [ $(whoami) != 'root' ]; then
        echo "Must be root to run $0"
        exit 1;
fi

# generate list of outdated packages
echo ">>> CHECKING INSTALLATION FOR OUTDATED PACKAGES..."
lst=(`pip list --outdated |grep -o '^\S*'`)

# process list of outdated packages
if [ ${#lst[@]} -eq 0 ]; then
    echo ">>> INSTALLATION UP TO DATE"
    exit 1;
else
    echo ">>> UPGRADING PACKAGES"
    for i in ${lst[@]}; do
        pip install ${i} --upgrade
    done
fi
```

###  OpenSSH Host Keys
To regenerate host keys, delete the old keys and reconfigure openssh-server. It is safe to run the commands over remote ssh based session. Your existing session shouldn't be interrupted:

```bash
sudo rm /etc/ssh/ssh_host*
sudo dpkg-reconfigure openssh-server
```
