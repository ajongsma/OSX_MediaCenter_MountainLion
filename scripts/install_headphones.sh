#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Headphones"
echo "#------------------------------------------------------------------------------"

source ../config.sh

if [ ! -d $INST_HEADPHONES_PATH ] ; then
    sudo mkdir -p $INST_HEADPHONES_PATH    
fi

#cd $INST_HEADPHONES_PATH
sudo git git clone https://github.com/rembo10/headphones.git $INST_HEADPHONES_PATH
sudo chown `whoami`:wheel $INST_HEADPHONES_PATH

open http://localhost:8181



echo "#------------------------------------------------------------------------------"
echo "# Installing Headphones - Complete"
echo "#------------------------------------------------------------------------------"
