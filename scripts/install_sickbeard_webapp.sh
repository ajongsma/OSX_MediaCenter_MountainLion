#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Apache webapp for Sick-Beard"
echo "#------------------------------------------------------------------------------"

source ../config.sh

if [ -d /Library/Server/Web/Config/apache2/webapps ] ; then
    printf 'Apache WebApp directory found. Copying Sick-Beard webapp config file...\n' "YELLOW" $col '[WAIT]' "$RESET"
    sudo cp -iv conf/webapps/org.sickbeard.plist /Library/Server/Web/Config/apache2/webapps/
    if [ ! -f /Library/Server/Web/Config/apache2/webapps/org.sickbeard.plist ] ; then
        printf 'Sick-Beard webapp config file found. Enabling...\n' "YELLOW" $col '[WAIT]' "$RESET"
        cd Library/Server/Web/Config/apache2/webapps/
        sudo webappctl start org.sickbeard

        open http://localhost/sickbeard
    else
    	printf 'Sick-Beard webapp config file not found. Failed!\n' "RED" $col '[ERR]' "$RESET"
        echo -e "${BLUE} --- press any key to continue --- ${RESET}"
        read -n 1 -s
    fi
fi

echo "#------------------------------------------------------------------------------"
echo "# Install Apache webapp for Sick-Beard - Complete"
echo "#------------------------------------------------------------------------------"
