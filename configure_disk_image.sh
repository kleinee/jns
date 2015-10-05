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
