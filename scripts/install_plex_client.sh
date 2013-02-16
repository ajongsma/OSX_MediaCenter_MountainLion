#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Plex Media Client"
echo "#------------------------------------------------------------------------------"

source ../config.sh

cd ~/Downloads

if [ ! -e ~/Downloads/Plex.app ] ; then
    echo "Plex Media Client not installed, please install..."
    open http://www.plexapp.com/download/plex-media-center.php
    while ( [ ! -e ~/Downloads/Plex.app ] )
    do
        echo "Waiting for Plex Media Client to be downloaded..."
        sleep 15
    done
else
    echo "Plex Media Client download found                           [OK]"
fi

cp -R ~/Downloads/Plex.app /Applications/

#open /Applications/Plex.app

echo "#------------------------------------------------------------------------------"
echo "# Install Plex Media Client - Complete"
echo "#------------------------------------------------------------------------------"
