#!/bin/bash
# script name:     inst_R-3.6.0.sh
# last modified:   2019/05/19
# sudo:            yes

SCRIPT_NAME=$(basename -- "$0")
JNS_USER='pi'
HOME_DIR="/home/$JNS_USER"
ENV="$HOME_DIR/.venv/jns"

R_VERSION="R-3.6.0"
R_DOWNLOAD_URL="http://mirrors.psu.ac.th/pub/cran/src/base/R-3/$R_VERSION.tar.gz"
R_EXEC=$(which R)
R_HOME="$HOME_DIR/R"

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$SCRIPT_NAME"
   exit 1
fi

cd $HOME_DIR

#
#  apt install additional packages
#
apt install -y libreadline-dev
apt install -y libbz2-dev

#
#  download R source and compile
#  if R is not yet present  
#
su pi <<ONE
    if [ -z ${R_EXEC} ]; then
        if [-z ${R_HOME}]; then
            mkdir $R_HOME
        fi
        wget $R_DOWNLOAD_URL
        tar -xvf "$R_VERSION.tar.gz"
        rm "$R_VERSION.tar.gz"
        cd ./$R_VERSION 
        ./configure --with-x=no --disable-java --prefix=$R_HOME
        make && make install
        cd $HOME_DIR
        rm -rf $R_VERSION
    fi
ONE

#
#  create soft link in /usr/local/bin
#
ln -s $R_HOME/bin/R /usr/local/bin/R
ln -s $R_HOME/bin/Rscript /usr/local/bin/Rscript

su pi <<TWO
    . $ENV/bin/activate
    echo "install.packages('IRkernel', repos='http://cran.rstudio.com/')" | R --no-save
    echo "IRkernel::installspec()" | R --no-save
TWO
