#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Configuring NewzNAB as provider for CouchPotato"
echo "#------------------------------------------------------------------------------"

source ../config.sh

echo "-----------------------------------------------------------"
echo "| Name                                    : API"
echo "| Api Requests                            : 1000"
echo "| Download Requests                       : 200"
echo "| Invites                                 : 0"
echo "| Can Preview                             : No"
echo "| Can Pre                                 : No"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/role-edit.php?action=add
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| Name                                    : $INST_COUCHPOTATO_UID"
echo "| Email                                   : $INST_COUCHPOTATO_UID@localhost.local"
echo "| Password                                : $INST_COUCHPOTATO_PW"
echo "| Movie View                              : Enabled"
echo "| Music View                              : Enabled"
echo "| Console View                            : Enabled"
echo "| Book View                               : Enabled"
echo "| Role                                    : API"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/user-edit.php?action=add
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

source ../config.sh
if [[ -z $INST_NEWZNAB_KEY_API_COUCHPOTATO ]]; then
    echo "-----------------------------------------------------------"
    echo "| SABnzbd Web Server:"
    echo "| Please add the Sickbeard NewzNAB API key to config.sh"
    echo "| API Key                              : INST_NEWZNAB_KEY_API_COUCHPOTATO=<paste value> "
    echo "-----------------------------------------------------------"
    #open http://localhost/newznab/admin/site-edit.php
    http://localhost/newznab/profile?id=3
    subl ../config.sh

    while ( [[ $INST_NEWZNAB_KEY_API_COUCHPOTATO == "" ]] )
    do
        printf 'Waiting for CouchPotato NewzNAB API be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 2
        source ../config.sh
    done
fi

echo "-----------------------------------------------------------"
echo "| Settings, Providers:"
echo "| "
echo "| NewzNAB                                 : Enable"
echo "| Provider Name                           : NewzNAB"
echo "| Site URL                                : http://localhost/newznab"
echo "| API Key                                 : $INST_NEWZNAB_KEY_API_COUCHPOTATO"
echo "-----------------------------------------------------------"
http://localhost:8082/settings/searcher/providers/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Configuring NewzNAB as provider for CouchPotato - Complete"
echo "#------------------------------------------------------------------------------"
