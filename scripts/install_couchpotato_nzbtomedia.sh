#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Configuring nzbToMedia for CouchPotato"
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

if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'SABnzbd - nzbToMedia installed\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'SABnzbd - nzbToMedia not installed\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${RED} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi

echo "-----------------------------------------------------------"
echo "| Add the following to [CouchPotato]:"
echo "| host                                    : localhost"
echo "| Port                                    : $INST_COUCHPOTATO_PORT"
echo "| username                                : $INST_COUCHPOTATO_UID"
echo "| password                                : $INST_COUCHPOTATO_PW"
echo "| API                                     : $INST_COUCHPOTATOD_API"
echo "| Delay                                   : 60"
echo "| Destination                             : $INST_FOLDER_MOVIES_COMPLETE"
echo "-----------------------------------------------------------"
subl ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Configuring nzbToMedia for CouchPotato - Complete"
echo "#------------------------------------------------------------------------------"
