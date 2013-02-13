#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Cheeta"
echo "#------------------------------------------------------------------------------"

source ../config.sh

echo "Download latest Cheetah:"
open http://www.cheetahtemplate.org/download

tar xvzf Cheetah-2.4.4.tar
cd Cheetah-2.4.4.tar
sudo python setup.py install

echo "#------------------------------------------------------------------------------"
echo "# Installing Cheeta complete"
echo "#------------------------------------------------------------------------------"
