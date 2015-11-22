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
