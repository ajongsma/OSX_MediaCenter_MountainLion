#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Logitech Harmony"
echo "#------------------------------------------------------------------------------"
## http://miniharmony.blogspot.nl/2010/06/episode-2-preparing-harmony-one-to-be.html
## http://www.fieg.nl/plex-mac-mini-harmony-remote-and-how-they-roll-together

source ../config.sh

echo "-----------------------------------------------------------"
echo "| Login to Logitech My Harmony (http://myharmony.com)"
echo "-----------------------------------------------------------"
open http://myharmony.com


#if [ -f $DIR/Blabla ] ; then
    echo "File BlaBla not found"

    while ( [ ! -e ~/Downloads/LogitechHarmonySoftware.dmg ] )
    do
        printf 'Waiting for Logitech Harmony Software to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
    printf 'Logitech Harmony install found. Installing…\n' "YELLOW" $col '[WAIT]' "$RESET"

    hdiutil attach LogitechHarmonySoftware.dmg
    cd /Volumes/LogitechHarmonySoftware.pkg/
    #installer -pkg LogitechHarmonySoftware.pkg -target "/"
    open LogitechHarmonySoftware.pkg
    hdiutil detach /Volumes/LogitechHarmonySoftware.pkg/

#else
#    echo "Blabla found"
#fi

echo "-----------------------------------------------------------"
echo "| On MyHarmony.com, select Add device:"
echo "| Manufacturer                         : Plex"
echo "| Model number                         : Plex Player"
echo "| "
echo "| Add an activity for Plex"
echo "| -------------------------"
echo "| Synchronize changes"
echo "-----------------------------------------------------------"


echo "#------------------------------------------------------------------------------"
echo "# Install Logitech Harmony - Complete"
echo "#------------------------------------------------------------------------------"
