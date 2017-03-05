#!/bin/bash
# script name:     upgrade_jns.sh
# last modified:   2017/03/05
# sudo:            yes

if [ $(whoami) != 'root' ]; then
        echo "Must be root to run $0"
        exit 1;
fi

START=$SECONDS

# generate list of outdated packages
echo ">>> CHECKING INSTALLATION FOR OUTDATED PACKAGES..."
lst=(`pip3 list --outdated --format='legacy'|grep -o '^\S*'`)

# process list of outdated packages
if [ ${#lst[@]} -eq 0 ]; then
    echo ">>> INSTALLATION UP TO DATE"
    exit 1;
else
    echo ">>> UPGRADING PACKAGES"
    for i in ${lst[@]}; do
        pip3 install ${i} --upgrade
    done
fi

ELAPSED=$(($SECONDS - $START))
echo $ELAPSED
