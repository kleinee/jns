#!/bin/bash
# script name:     install_python.sh
# last modified:   2016/10/13
# sudo:            yes
# 

mkdir $home/R
cd $home/R

$R_version="R-3.3.1"

#------------------------------------------------------
apt-get install 
apt-get libreadline6-dev 
apt-get libjpeg-dev 
apt-get libcairo2-dev
apt-get xvfb
apt-get install libcurl4-openssl-dev
apt-get install liblzma-dev
apt-get install libbz2-dev
apt-get install lbzip2
apt-get install libzmq-dev
#------------------------------------------------------

wget "https://cran.rstudio.com/src/base/R-3/$R_version.tar.gz"
tar "-zxvf $R_version.tar.gz"
cd "$R_version"
./configure --with-cairo --with-jpeglib
make
make install
