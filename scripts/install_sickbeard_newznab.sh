#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Configuring NewzNAB as provider for Sickbeard"
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
echo "| Name                                    : $INST_SICKBEARD_UID"
echo "| Email                                   : $INST_SICKBEARD_UID@localhost.local"
echo "| Password                                : $INST_SICKBEARD_PW"
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
if [[ -z $INST_SICKBEARD_KEY_API_NEWZNAB ]]; then
    echo "-----------------------------------------------------------"
    echo "| SABnzbd Web Server:"
    echo "| Please add the Sickbeard NewzNAB API key to config.sh"
    echo "| API Key                              : INST_SICKBEARD_KEY_API_NEWZNAB=<paste value> "
    echo "-----------------------------------------------------------"
    #open http://localhost/newznab/admin/site-edit.php
    http://localhost/newznab/profile?id=2
    subl ../config.sh

    while ( [[ $INST_SICKBEARD_KEY_API_NEWZNAB == "" ]] )
    do
        printf 'Waiting for Sickbeard NewzNAB API be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 2
        source ../config.sh
    done
fi

echo "-----------------------------------------------------------"
echo "| Menu, Config, Search Providers:"
echo "| "
echo "| Configure Custom Newznab Providers:"
echo "| Provider Name                           : NewzNAB"
echo "| Site URL                                : http://localhost/newznab/"
echo "| API Key                                 : $INST_SICKBEARD_KEY_API_NEWZNAB"
echo "-----------------------------------------------------------"
open http://localhost:8081/config/providers/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Configuring NewzNAB as provider for Sickbeard - Complete"
echo "#------------------------------------------------------------------------------"
