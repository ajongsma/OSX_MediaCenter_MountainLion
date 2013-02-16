#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install Plex Client"
echo "#------------------------------------------------------------------------------"

source ../config.sh

cd ~/Downloads

if [ ! -e ~/Downloads/PlexMediaServer-* ] ; then
    echo "Plex Server not installed, please install..."
    #open http://www.plexapp.com/download/plex-media-center.php
    while ( [ ! -e ~/Downloads/PlexMediaServer-* ] )
    do
        echo "Waiting for Plex Server to be downloaded..."
        sleep 15
    done
else
    echo "Plex Server download found                           [OK]"
fi

for i in ~/Downloads/PlexMediaServer-*; do
    if [ -f "$i" ]; then
        #echo "Found : $i"
        open $i
        if [ -e /Volumes/PlexMediaServer/Plex\ Media\ Server.app ] ; then
            cp -R /Volumes/PlexMediaServer/Plex\ Media\ Server.app/ /Applications/
        fi
    fi
done

if [ -e /Applications/Plex\ Media\ Server.app ] ; then
    printf 'Plex Server found\n' "$GREEN" $col '[OK]' "$RESET"
    open /Applications/Plex\ Media\ Server.app
else
    printf 'Plex Server not installed, something went wrong\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi


echo "#------------------------------------------------------------------------------"
echo "# Install Plex Client - Complete"
echo "#------------------------------------------------------------------------------"
