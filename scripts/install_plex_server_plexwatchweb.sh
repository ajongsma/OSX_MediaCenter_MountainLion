#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install plexWebWatch for Plex Media Server"
echo "#------------------------------------------------------------------------------"
# https://github.com/ecleese/plexWatchWeb

source ../config.sh

if [ -e /Applications/Plex\ Media\ Server.app ] ; then
    printf 'Plex Server found\n' "$GREEN" $col '[OK]' "$RESET"

    [ -d /Users/PlexWatch/Sites/plexwatch ] || mkdir -p /Users/PlexWatch/Sites/plexwatch
    sudo chown `whoami` /Users/PlexWatch/Sites/plexwatch
    sudo ln -s /Users/PlexWatch/Sites/plexwatch /Library/Server/Web/Data/Sites/Default/plexwatch

    cd /Users/PlexWatch/Sites/plexwatch
    git clone https://github.com/ecleese/plexWatchWeb


else
    printf 'Plex Server not installed, something went wrong\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi

echo "#------------------------------------------------------------------------------"
echo "# Install plexWebWatch for Plex Media Server - Complete"
echo "#------------------------------------------------------------------------------"
