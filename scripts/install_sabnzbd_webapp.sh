#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Apache webapp for SABnzbd"
echo "#------------------------------------------------------------------------------"

source ../config.sh

if [ -d /Library/Server/Web/Config/apache2/webapps ] ; then
    printf 'Apache WebApp directory found. Copying SABnzbd webapp config file...\n' "YELLOW" $col '[WAIT]' "$RESET"
    sudo cp conf/webapps/org.sabnzbd.plist /Library/Server/Web/Config/apache2/webapps/
    if [ ! -f /Library/Server/Web/Config/apache2/webapps/org.sabnzbd.plist ] ; then
        printf 'SABnzbd webapp config file found. Enabling...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sudo webappctl start /Library/Server/Web/Config/apache2/webapps/org.sabnzbd.plist
    else
    	printf 'SABnzbd webapp config file not found. Failed!\n' "RED" $col '[ERR]' "$RESET"
        echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    fi
fi

echo "#------------------------------------------------------------------------------"
echo "# Install Apache webapp for SABnzbd - Complete"
echo "#------------------------------------------------------------------------------"
