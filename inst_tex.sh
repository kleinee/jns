#!/bin/bash
# script name:     inst_tex.sh
# last modified:   2018/01/26
# sudo:            yes

script_name=$(basename -- "$0")

if ! [ $(id -u) = 0 ]; then
   echo "usage: sudo ./$script_name"
   exit 1
fi

#------------------------------------------------------
apt install -y texlive
apt install -y texlive-latex-extra
apt install -y dvipng
apt install -y texlive-xetex
apt install -y latexmk
#------------------------------------------------------
