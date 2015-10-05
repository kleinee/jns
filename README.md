# jns
# Jupyter Notebook Server 
# on Raspberry PI 2
## Motivation
Well this cannot be about Big Data, can it? No it is not. This is more about interactive exploration: Sliderules are a thing of the past, decent calculators are hard to find these days and spreadsheets are somewhat cumbersome and at times outright dangerous. Jupyter not only revolutionizes data-heavy research in all domains - it also boosts personal productity for problems on a much smaller scale.

## Requirements

* a Raspberry Pi 2 complete with 5V micro-usb power-supply
* a blank 16 GB micro SD card
* an ethernet cable to connect the Pi to your network
* a static IP address for the Raspberry Pi 
* an internet connection
* a computer to carry out the installation connected to the same network as the Pi
* a fair amout of time - following along to the end will take good part of a day.....

## Target
We set up a Jupyter Notebook Server complete with Python 3.5.0, fully functioning nbconvert and a basic scientific stack after the 'Big Split' i.e. with version 4.0 or later of all components making up the incredibly powerful jupyter interactive computing environment.

## List of Packages
beautifulsoup4 (4.4.1)
Bottleneck (1.0.0)
decorator (4.0.4)
html5lib (0.9999999)
ipykernel (4.0.3)
ipyparallel (4.0.2)
ipython (4.0.0)
ipython-genutils (0.1.0)
ipywidgets (4.0.3)
jdcal (1.0)
Jinja2 (2.8)
jsonschema (2.5.1)
jupyter (1.0.0)
jupyter-client (4.0.0)
jupyter-console (4.0.2)
jupyter-core (4.0.6)
lxml (3.4.4)
MarkupSafe (0.23)
matplotlib (1.4.3)
mistune (0.7.1)
nbconvert (4.0.0)
nbformat (4.0.0)
networkx (1.10)
nose (1.3.7)
notebook (4.0.5)
numexpr (2.4.4)
numpy (1.9.3)
openpyxl (2.2.6)
pandas (0.16.2)
path.py (8.1.1)
patsy (0.4.0)
pexpect (3.3)
pickleshare (0.5)
pip (7.1.2)
ptyprocess (0.5)
Pygments (2.0.2)
pyparsing (2.0.3)
python-dateutil (2.4.2)
pytz (2015.6)
pyzmq (14.7.0)
qtconsole (4.0.1)
readline (6.2.4.1)
requests (2.7.0)
scikit-learn (0.16.1)
scipy (0.16.0)
seaborn (0.7.0.dev0)
setuptools (18.3.2)
simplegeneric (0.8.1)
six (1.9.0)
SQLAlchemy (1.0.8)
statsmodels (0.6.1)
sympy (0.7.6.1)
terminado (0.5)
tornado (4.2.1)
traitlets (4.0.0)
xlrd (0.9.4)
XlsxWriter (0.7.4)
xlwt (1.0.0)


## Preparation of the Image
### Raspbian Jessie as a Starting Point
We use the [minimal Raspbian unattended netinstaller for Raspberry Pi](https://github.com/debian-pi/raspbian-ua-netinst) maintained on GitHub to prepare a small Raspbian Jessie server image that we can tweak to our needs. The reason is pandoc: 

The official documentation states that nbconvert uses pandoc to convert between various markup languages, so pandoc is a dependency of most nbconvert transforms, excluding Markdown and Python. With pandoc 1.12.2 now recommended for jupyter. Under wheezy the last pando version we can install is 1.11.1. Fortunately the repository of Raspbian jessie contains pandoc 1.12.4.2. Not the latest version either but still recent enough for our purposes.

The installation instructions on the installer repository provide information on how to perform the the installation of the image in accordance with your platform. The basic steps are:

* get the installer image and write it to your micro SD card
* take a look at the card's content: there is a file named cmdline.txt
* create an installer‑config.txt file alongside that file
* edit installer-config.txt for our needs.

### installer-config.txt
```bash
packages=vim,sudo,git,pandoc
release=jessie
```
Further down we install additional packages with apt-get install. Whilst most of them could be added to the list of packges in the file installer_config.txt, I opted to install as needed. This clarifies dependencies and gives you the freedom to customize the process to your needs.

Once installer-config.txt is in place, eject the card, insert it into the Raspberry Pi connect the Pi to your network via ethernet cable and boot. The installer will retrieve and install all packages for the release / flavour  and will enable ssh access for user root with password raspbian. I highly recommend to monitor progress via monitor attached to the Raspberry Pi.

### Configuration Upon First Boot
The system is almost completely configured on first boot. Here are some tasks you most definitely want to do on first boot. The default **root password raspbian**.
```bash
# set new root password
passwd

# set your timezone:
dpkg-reconfigure tzdata
   
# configure your default locale
dpkg-reconfigure locales

# add new user jns (jupyter notebook server) 
# and add this user to groups
adduser jns
usermod -aG sudo,ssh jns
```
I found that configuring the image as suggested by the creators of the net isnatller works fine in our context. All I did is turn their recommendations into a script.

```bash
#!/bin/bash
# configure_disk_image.sh
# purpose: configure disk image
# last modified: 2015/09/30

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

# set up wap partition 
target=/etc/fstab
if ! grep -Fxq /swap $target; then
    dd if=/dev/zero of=/swap bs=1M count=512
    mkswap /swap
    echo '/swap none swap sw 0 0' >> $target
else
    echo swap partition already configured
fi

# speed things up

#------------------------------------------------------
apt-get install -y raspi-copies-and-fills
apt-get install -y rng-tools
#------------------------------------------------------

target=/etc/modules
if ! grep -Fxq bcm2708-rng $target; then
    echo bcm2708-rng >> $target
else
    echo bcm2708-rng already present
fi
```

## Jupyter Notebook Server Installation
Reboot and log in as user jns via ssh. From the terminal run:

```bash
cd /home/jns
git clone https://github.com/kleinee/jns.git
cd jns
chmod +x *.sh
sudo ./install_jns.sh
```
This will create a directory notebooks in the home directory of user jns, clone this repository to get the installtion scripts, make the scripts executable and then run install_jns.sh which does the following:

* install Python
* install jupyter
* (pre)-configure jupyter
* install Tex
* install scientific syack

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

If everything goes to plan you end up with a fully working jupyter notebook server.

### Starting the Server
On the Raspberry Pi as user jns just type:
```bash
jupyter notebook 
```
You can access the server from any browser via the IP address of the Raspberry Pi on port 9090.

## Installation + Configuration Steps
### Python 3.5.0 Installation
Instructions for building Python from source can be found [here](http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html). I adjusted them to suit installtion of Python 3.5.0 and turned the instructions into a script.

```bash
#!/bin/bash
# script name:     install_python.sh
# last modified:   2015/09/30
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#Python 3 version to install
version="3.5.0"

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
# last modified:   2015/09/22
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#------------------------------------------------------
apt-get install -y texlive
apt-get install -y texlive-latex-extra
apt-get install -y dvipng
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
* we set the IP address to the current IP address of the Raspberry Pi assuming it is the satic IP we require
* we set the port for the notbook server to listen on to 9090
* we enable mathjax for rendering math in notebooks
* we set the notebook_dir to ~/notebooks, the directory we created
* we use the password hash for the default server password jns
* We tell jupyter that we installed ipyparallel

To change settings upon installation, just edit ./jupyter/jupyter_notebook_config.py to suit your needs.

```bash
#!/bin/bash
# script name:     configure_jupyter.sh
# last modified:   2015/09/30
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

# get current ip address - we assume it is static
ip=$(echo $(hostname -I))

# set up dictionary of changes for jupyter_config.py
declare -A arr
app='c.NotebookApp' 
arr+=(["$app.open_browser"]="$app.open_browser = False")
arr+=(["$app.ip"]="$app.ip ='$ip'")
arr+=(["$app.port"]="$app.port = 9090")
arr+=(["$app.enable_mathjax"]="$app.enable_mathjax = True")
arr+=(["$app.notebook_dir"]="$app.notebook_dir = '/home/jns/notebooks'")
arr+=(["$app.password"]="$app.password = 'sha1:5815fb7ca805:f09ed218dfcc908acb3e29c3b697079fea37486a'")
arr+=(["$app.server_extensions.append"]="$app.server_extensions.append('ipyparallel.nbextension')")

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

### Scientific Stack
The list of packages istalled here is just a suggestion. Feel free to adjust as needed.

```bash
#!/bin/bash
# script name:     install_stack.sh
# last modified:   2015/09/22
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

#------------------------------------------------------
apt-get -y install libatlas-base-dev gfortran
#------------------------------------------------------

pip install SciPy
pip install statsmodels
pip install -U scikit-learn
pip install git+git://github.com/mwaskom/seaborn.git#egg=seaborn
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
pip list --outdated
sudo pip install xyz --upgrade
```
