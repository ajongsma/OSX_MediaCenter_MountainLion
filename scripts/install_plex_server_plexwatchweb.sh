#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install plexWebWatch for Plex Media Server"
echo "#------------------------------------------------------------------------------"
# https://github.com/ecleese/plexWatchWeb

source ../config.sh

if [ -e /Applications/Plex\ Media\ Server.app ] ; then
    printf 'Plex Server found\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'Plex Server not installed, something went wrong\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi

if [ -d /Users/PlexWatch/plexWatch ] ; then
    printf 'PlexWatch found\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'PlexWatch not installed, something went wrong\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi

[ -d /Users/PlexWatch/Sites/plexWatchWeb ] || mkdir -p /Users/PlexWatch/Sites/plexWatchWeb
sudo chown `whoami` /Users/PlexWatch/Sites/plexWatchWeb
sudo ln -s /Users/PlexWatch/Sites/plexWatchWeb /Library/Server/Web/Data/Sites/Default/plexwatch

cd /Users/PlexWatch/Sites/plexWatchWeb
git clone https://github.com/ecleese/plexWatchWeb

# PlexWatch
sudo cpan install Time::Duration
sudo cpan install Time::ParseDate
sudo cpan install Net::Twitter::Lite::WithAPIv1_1
sudo cpan install Net::OAuth
sudo cpan install Mozilla::CA
sudo cpan install JSON


echo "#------------------------------------------------------------------------------"
echo "# Install plexWebWatch for Plex Media Server - Complete"
echo "#------------------------------------------------------------------------------"
