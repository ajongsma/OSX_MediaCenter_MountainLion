#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Configuring Trakt.TV for Sickbeard"
echo "#------------------------------------------------------------------------------"

source ../config.sh

source ../config.sh
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

echo "-----------------------------------------------------------"
echo "| Trakt                                   : Enable"
echo "| username                                : $INST_TRAKT_UID"
echo "| password                                : $INST_TRAKT_PW"
echo "| API                                     : $INST_TRAKT_KEY_API"
echo "|----------------"
echo "| Test Trakt"
echo "|----------------"
echo "| Save Changes"
echo "-----------------------------------------------------------"
open http://localhost:8081/config/notifications/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Configuring Trakt.TV for Sickbeard - Complete"
echo "#------------------------------------------------------------------------------"
