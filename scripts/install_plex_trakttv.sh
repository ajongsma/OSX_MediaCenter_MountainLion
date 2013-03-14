#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Trakt.TV for Plex"
echo "#------------------------------------------------------------------------------"

source ../config.sh

cd ~/Github
git clone https://github.com/tester22/Plex-Trakt-Scrobbler
cp -r Plex-Trakt-Scrobbler/Trakttv.bundle/ ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/

if [[ -z $INST_TRAKT_KEY_API ]] || [[ $INST_TRAKT_PW == "" ]] || [[ $INST_TRAKT_KEY_API == "" ]]; then
    echo "-----------------------------------------------------------"
    echo "| Log on TraktTV "
    echo "| - Go to Settings, "
    echo "| - Select API"
    echo "| INST_TRAKT_KEY_UID : Username"
    echo "| INST_TRAKT_KEY_PW  : Password"
    echo "| INST_TRAKT_KEY_API : <copy/paste the shown API KEY>"
    echo "-----------------------------------------------------------"
    open http://trakt.tv/settings/api
    subl ../config.sh

    while ( [[ $INST_TRAKT_UID == "" ]] || [[ $INST_TRAKT_PW == "" ]] || [[ $INST_TRAKT_KEY_API == "" ]] )
    do
      printf 'Waiting for the Trakt information to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
	    sleep 3
	    source ../config.sh
    done
fi

echo " -----------------------------------------------------------"
echo "| Installed  Trakttv.bundle to:"
echo "|   ~/Library/Application Support/Plex Media Server/Plug-ins"
echo "| "
echo "| Next steps:"
echo "| * Restart Plex Media Server (if needed)"
echo "| * Open the Plex/Web client."
echo "| * Navigate to Channels » Trakt.tv Scrobbler » Preferences"
echo "|   and enter your username and password"
echo "| *  Turn on scrobbling and any other settings you want to"
echo "| "
echo "| Set logging level in Plex Media Server"
echo "| In order for the scrobbler to detect what you are playing, you"
echo "| will need to set the logging level in the Plex Media Server (PMS)."
echo "| "
echo "| Go to Plex / Web (PMS icon in the menu bar, then select Media Manager (http://localhost:32400/web)"
echo "| Click on Settings (screwdriver / wrench logo)"
echo "| Click Show advanced settings"
echo "| Check the box for Plex Media Server verbose logging"
echo "| Click Save"
echo "| "
echo "| Now everything should be ready for you to start scrobbling your Movies and TV Shows to Trakt!"
echo " -----------------------------------------------------------"


#echo "-----------------------------------------------------------"
#echo "| [Trakt]"
#echo "| username                                : $INST_TRAKT_UID"
#echo "| password                                : $INST_TRAKT_PW"
#echo "|"
#echo "| [Optional]"
#echo "| plexlog_path                            : /var/log/PlexMediaServer.log"
#echo "-----------------------------------------------------------"
#subl config.ini

echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Install Trakt.TV for Plex - Complete"
echo "#------------------------------------------------------------------------------"
