#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Transmission"
echo "#------------------------------------------------------------------------------"

source ../config.sh

echo "Download latest Transmission from http://www.transmissionbt.com"
open http://www.transmissionbt.com/download

cd ~/Downloads
#curl -O http://sphinxsearch.com/files/sphinx-2.0.6-release.tar
while ( [ ! -e Transmission-2.77.dmg ] )
do
    printf 'Waiting for Transmission to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
    sleep 15
done

hdiutil attach Transmission-2.77.dmg
sudo cp -r /Volumes/Transmission/Transmission.app /Applications
hdiutil detach /Volumes/Transmission/

open /Applications/Transmission.app

echo "#------------------------------------------------------------------------------"
echo "# Install Transmission - Complete"
echo "#------------------------------------------------------------------------------"
