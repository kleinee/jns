# jns
# Jupyter Notebook Server on Raspberry Pi 

## Target
We set up a jupyter notebook server complete with Python 3.4.3, IPython, fully functioning jupyter nbconvert and the basic scientific stack after the 'Big Split' i.e. with version 4.0 or later of all components making up the incredible jupyter interactive computing environment.

There is certainly room for imrovement. This is the very reason I share this document on GitHub. 

## nbconvert Challenge

Other people 
***From the official documentation:*** nbconvert uses pandoc to convert between various markup languages, so pandoc is a dependency of most nbconvert transforms, excluding Markdown and Python. 

Technically a basic jupyter installation is as simple as:

    pip install jupyter
    jupyter notebook --generate-config
    
followed by some configuration. This can even be done under Raspbian wheezy but may provide limited nbconvert functionality because the last version of pandoc that can be built under Raspbian wheezy is 1.11.1. With pandoc 1.12.2 recommended for the latest jupyter stack we are out of luck with wheezy.

Fortunately the repository of Raspbian jessie contains pandoc 1.12.4.2. Not the latest version but still recent enough for our purposes.

## Requirements
* a Raspberry Pi 2 complete with 5V micro-usb power-supply
* a blank 16GB micro SD card
* an ethernet cable to connect the Pi to your network
* a static IP address for the Pi
* an internet connection
* a computer to carry out the installtion
* a fair bit of time

Notes: 
* I found that having nmap installed on the computer used for installtion is rather helpful when it comes to identifying the ip address of the Pi (or any other machine on the network). I frequently use:

    sudo namp -sP 192.168.1.1-254
    
to identify clients. Needless to say that the address range needs to be adjusted to suit your environment.

* A smaller micro SD card would propbaly work since a zip file created for the final image has a size of around 2.75GB. I made all efforts not to install components that we do no not really need. 

## Installation of the Server Image
We use the unattendend net installer maintained on [GitHub](https://github.com/debian-pi/raspbian-ua-netinst) to prepare a small Raspbian jessie server image that we can tweak to our needs.I to study the installation instructions on the repository and then perform the following steps in accordance with your environment.

* get the installer image and write it to SD card
* When you've written the installer to a SD card, you'll see a file named cmdline.txt 
* Create an installer‑config.txt file alongside that file.
* add the following lines to the file and save it to the card:
        
        packges=vim,sudo,git
        release=jessie
        
* ***NOTE:*** Further down we install additional packages with apt. Whilst most of them could be added to the list of packges above, I decided to install as needed in the process. This clarifies dependencies and gives you the freedom to customize the process to your needs.

* eject the SD card, insert it into the Raspberry Pi connect the Pi to your network via
ethernet and boot.

The installer will retrieve and install all packages for the release / flavour and will enable ssh access for user root with password raspbian. When I first tried this I was on a relatively slow internet connection and had no monitor attached to the Pi. I highly recommend to monitor progress via monitor or or serial console cable.

## First Boot
Once the installer has complted the basic installation, ssh into the Pi as root to perform the following commands:

    # change the root password:
    passwd

    # set the timezone:
    dpkg-reconfigure tzdata
   
    # adjust locales as required
    dpkg-reconfigure locales

    # add new user jns (jupyter notebook server) 
    # and add this user to groups
    adduser jns
    usermod -aG sudo,ssh jns
    
    # improve memory management performance (optional)
    apt-get install raspi-copies-and-fills
    
    # improve performance of various server applications needing
    # random numbers (optional):
    apt-get install rng-tools
    add bcm2708-rng to /etc/modules

## Installation of Python 3.4.3
Because our SD card image has no Python interpreter installed, we build Python 3.4.3. We upgrade pip to the latest version once Python is installed. Commands below can easily be turened into a shell script for unattended installation.

    apt-get install -y build-essential libncusesw5-dev
    apt-get install -y libgdbm-dev libc6-dev
    apt-get install -y zlib1g-dev libsqlite3-dev tk-dev
    apt-get install -y libssl-dev openssl
    wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz\
    tar zxvf Python-3.4.3.tgz
    cd Python*
    ./configure
    make
    make install
    pip3 install pip --upgrade

## Installation of TeX and LaTeX
Since the sole purpose of installing TeX / LaTex in this context is pdf conversion of notebooks. Installation of the required packages takes quite some time even on a Raspberry Pi 2. Hence commands below (to be exceuted as root or as jns using sudo) should better be turned into a script for unattended istallation. Because we use packages from the Raspbian repository the packages could also be included in the list of packages for the installer. As root execute the following commands:

    apt-get install -y texlive
    apt-get install -y texlive-generic-extra
    apt-get install -y texlive-latex-extra
    apt-get install -Y dvipng

## Readline
When you start IPython right after installation you get the following warning:

    WARNING: Readline services not available or not loaded.
    WARNING: The auto-indent feature requires the readline library
    
To fix this we run (as root):

    apt-get install libncurses5-dev
    pip intall readline

## Installation of Jupyter
The developer team of project jupyter made the rest really easy:

* log in as user jns
* in the home directorty create a directory named notebooks that we can use to store jupyter noteooks.
* use pip to install jupyter
    
    sudo pip install jupyter
    jupyter notebook --generate-config

The last command genertes directory .jupyter in the home directory of user jns and in this directory a file named jupyter-notebook-config.py. Inside this file, we need to configure a couple of class attributes.

## Password Hash
Logged in as user jns start IPython and at the prompt type:

    In [1]: from notebook.auth import passwd
    In [2]: passwd()

You will be asked to enter a password and to verify it. We will use this password as the password for our notebook server. Once verified, passwd() prints out a password hash. Note down the hash as we will use it in the server configuration.

## Parallel Computing
I installed ipyparrallel for completeness but have not used it yet. Take a look at the project's GitHub repository at https://github.com/ipython/ipyparallel.

    pip install ipyparallel

Note that we still have to activate the functionality in the server configuration.

## Basic Server Configuration
Open /home/jns/.jupyter/jupyter-notebook-config.py in an editor and uncomment / edit the following attributes:

    c.NotebookApp.open_browser = False
    c.NotebookApp.ip = '192.168.1.112'
    c.NotebookApp.port = 9090
    c.NotebookApp.enable_mathjax = True
    c.NotebookApp.notebook_dir = '/home/jns/notebooks/'
    c.NotebookApp.password 'sha1:....'
    c.NotebookApp.open_browser = False
    c.NotebookApp.server_extensions.append('ipyparallel.nbextension')
    
Replace the ip address to the address of the Raspberry pi and use the full hash generated earlier. Save the file.

Congratulations if you made it this far: You can now start your server with:

    jupyter notebook
    
Open a browser on your computer and key in:

    192.168.1.112:9090

and will be greeted by the login page of your server. Note that ip addrees and port need to adjusted to your environment.

# Basic Scientific Stack
Insalling the basic scientific stack is easy using pip as root:
    
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
    apt-get -y install libxml2-dev libxslt-dev
    pip install lxml
    
Installation of SciPy and statsmodels requires some additional packages from the repository. Seaborn is last as the libray is built on top of matplotlib and tightly integrated with the PyData stack, including support for numpy and pandas data structures and statistical routines from scipy and statsmodels.

    apt-get -y install libatlas-base-dev gfortran
    pip install SciPy
    pip install statsmodels
    
Scikit Learn is more of a proof of concept. It runs but lacks speed.

    pip install -U scikit-learn
    pip install git+git://github.com/mwaskom/seaborn.git#egg=seaborn

## Pip List

pip list provides an overview of the packages we have installed so far. 
Install location is: /usr/local/lib/python3.4/site-packages

beautifulsoup4 (4.4.0)
Bottleneck (1.0.0)
decorator (4.0.2)
html5lib (0.999999)
ipykernel (4.0.3)
ipyparallel (4.0.2)
ipython (4.0.0)
ipython-genutils (0.1.0)
ipywidgets (4.0.2)
jdcal (1.0)
Jinja2 (2.8)
jsonschema (2.5.1)
jupyter (1.0.0)
jupyter-client (4.0.0)
jupyter-console (4.0.2)
jupyter-core (4.0.4)
lxml (3.4.4)
MarkupSafe (0.23)
matplotlib (1.4.3)
mistune (0.7.1)
nbconvert (4.0.0)
nbformat (4.0.0)
nose (1.3.7)
notebook (4.0.4)
numexpr (2.4.3)
numpy (1.9.2)
openpyxl (2.2.5)
pandas (0.16.2)
path.py (8.1)
patsy (0.4.0)
pexpect (3.3)
pickleshare (0.5)
pip (7.1.2)
ptyprocess (0.5)
Pygments (2.0.2)
pyparsing (2.0.3)
python-dateutil (2.4.2)
pytz (2015.4)
pyzmq (14.7.0)
qtconsole (4.0.1)
readline (6.2.4.1)
scikit-learn (0.16.1)
scipy (0.16.0)
seaborn (0.7.0.dev0)
setuptools (12.0.5)
simplegeneric (0.8.1)
six (1.9.0)
SQLAlchemy (1.0.8)
statsmodels (0.6.1)
sympy (0.7.6.1)
terminado (0.5)
tornado (4.2.1)
traitlets (4.0.0)
xlrd (0.9.4)
XlsxWriter (0.7.3)
xlwt (1.0.0)

## Links
[project jupyter](https://jupyter.org)
[project jupyter on GitHub](https://github.com/jupyter)
[rapberry pi foundation](https://www.raspberrypi.org)
[raspbian](https://www.raspbian.org)
[net installer](https://github.com/debian-pi/raspbian-ua-netinst)
[scikit learn](http://scikit-learn.org/stable/)
[numpy](http://www.numpy.org)
[pandas](http://pandas.pydata.org)
[seaborn](http://stanford.edu/~mwaskom/software/seaborn/introduction.html)
[matplotlib](http://matplotlib.org)
[sympy](http://www.sympy.org/en/index.html)
[scipy](http://www.scipy.org)
[pandoc](http://pandoc.org)
[beautifulsoup](https://pypi.python.org/pypi/beautifulsoup4)

Perhaps also interesting to share a few links I came across in the whole process as I am not the first to be tempted to set up an IPython Notebook server on a Raspberry  Pi:

[Remote IPython Notebook with Raspberry Pi  Arun Durvasula](https://arundurvasula.wordpress.com/2014/04/01/remote-ipython-notebook-with-raspberry-pi/)
[Anaconda on the Raspberry Pi |  Ilan Schnell](http://continuum.io/blog/raspberry)
