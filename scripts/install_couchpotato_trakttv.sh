#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Configuring Trakt for CouchPotato"
echo "#------------------------------------------------------------------------------"
## https://github.com/clinton-hall/nzbToMedia

## ORG: autoProcessMedia.cfg
#[CouchPotato]
#host = localhost
#port = 5050
#username = 
#password = 
#ssl = 0
#web_root =
#apikey = xxxxxxxx
#delay = 60
#method = renamer
#delete_failed = 0
#category = movies
#destination = /abs/path/to/complete/movies

#Method: Method "renamer" is the default which will cause CouchPotatoserver to move and rename downloaded files as specified 
#        in the CouchPotatoServer renamer settings. This will also add the movie to the manage list and initiate any configured 
#        notifications. 
#        In this case your nzb client must extract the files to the "from" folder as specified in your CouchPotatoServer renamer 
#         settings. Renamer must be enabled but automatic scan can be disabled by setting "Run Every" to "0".

#Method: Method "manage" will make CouchPotatoServer update the list of managed movies if manager is enabled but renamer is not 
#        enabled. In this case your nzb client must extract the files directly to your final movies folder (as configured in
#    	 CouchPotatoServer manage settings) and Manage must be enabled.

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
echo "| API                                     : $INST_TRAKT_KEY_API"
echo "| username                                : $INST_TRAKT_UID"
echo "| password                                : $INST_TRAKT_PW"
echo "-----------------------------------------------------------"
open http://localhost:8082/settings/automation/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Configuring Trakt for CouchPotato - Complete"
echo "#------------------------------------------------------------------------------"
