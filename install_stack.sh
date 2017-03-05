#!/bin/bash
# script name:     install_stack.sh
# last modified:   2017/03/05
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip3 install numpy
pip3 --no-cache-dir install matplotlib
pip3 install sympy
pip3 install cython
pip3 install pandas
pip3 install numexpr
pip3 install bottleneck
pip3 install SQLAlchemy
pip3 install openpyxl
pip3 install xlrd
pip3 install xlwt
pip3 install XlsxWriter
pip3 install beautifulsoup4
pip3 install html5lib

#------------------------------------------------------
apt-get -y install libxml2-dev libxslt-dev
#------------------------------------------------------

pip3 install lxml
pip3 install requests
pip3 install networkx
pip3 install plotly

#-----------------------------------------------------
apt-get -y install libblas-dev liblapack-dev
apt-get -y install libatlas-base-dev gfortran
#-----------------------------------------------------

pip3 install scipy
