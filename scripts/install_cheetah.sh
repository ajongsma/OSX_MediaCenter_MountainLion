#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Cheeta"
echo "#------------------------------------------------------------------------------"

source ../config.sh

echo "Download latest Cheetah from http://www.cheetahtemplate.org/download"
open http://www.cheetahtemplate.org/download

cd ~/Downloads
#curl -O http://sphinxsearch.com/files/sphinx-2.0.6-release.tar
while ( [ ! -e Cheetah-2.4.4.tar ] )
do
    printf 'Waiting for Cheetah to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
    sleep 15
done

tar xvzf Cheetah-2.4.4.tar
cd Cheetah-2.4.4
sudo python setup.py install

echo "#------------------------------------------------------------------------------"
echo "# Install Cheeta - Complete"
echo "#------------------------------------------------------------------------------"
