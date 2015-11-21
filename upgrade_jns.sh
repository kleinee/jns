#!/bin/bash
# script name:     upgrade_jns.sh
# last modified:   2015/10/22
# sudo:            yes


if [ $(whoami) != 'root' ]; then
        echo "Must be root to run $0"
        exit 1;
fi

# adjust this list of packages you intend to upgrade
list=(openpyxl pandas)

for i in ${list[@]}; do
    pip install ${i} --upgrade
done
