#!/bin/bash
me=`basename "$0"`
pipdeptree -f --warn silence | grep -P '^[\w0-9\-=.]+' >requirements.txt
#pipdeptree | grep -P '^\w+' >requirements.txt
sed -i '/sqlite/d' ./requirements.txt
