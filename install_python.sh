#!/bin/bash
# script name:     install_python.sh
# last modified:   2017/10/13
# sudo:            yes
#
# credit goes to the creator of sowingseasons.com

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#Python 3 version to install
version="3.6.3"

#------------------------------------------------------
apt-get install -y build-essential libncursesw5-dev
apt-get install -y libgdbm-dev libc6-dev
apt-get install -y zlib1g-dev libsqlite3-dev tk-dev
apt-get install -y libssl-dev openssl
apt-get install -y libreadline-dev libbz2-dev
#------------------------------------------------------

wget "https://www.python.org/ftp/python/$version/Python-$version.tgz"
tar zxvf "Python-$version.tgz"
cd "Python-$version"
./configure
make
make install
pip3 install pip --upgrade

# clean up

cd ..

rm -rf "./Python-$version"
rm "./Python-$version.tgz"
