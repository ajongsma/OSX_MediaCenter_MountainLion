#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install Maraschino"
echo "#------------------------------------------------------------------------------"

source ../config.sh

cd /Applications
git clone https://github.com/mrkipling/maraschino.git
sudo chown `whoami`:wheel -R /Applications/maraschino

cd maraschino

#sudo python /Applications/maraschino/Maraschino.py
osascript -e 'tell app "Terminal"
    do script "python /Applications/maraschino/Maraschino.py"
end tell'

echo "-----------------------------------------------------------"
echo "| Click hidden gear icon, top left to configure modules"
echo "| --------------------"
echo "| SABnzbd"
echo "| Hostname            : http://localhost"
echo "| Port                : $INST_SABNZBD_PORT"
echo "| API Key             : $INST_SABNZBD_KEY_API"
echo "----------------------"
echo "| Sickbeard"
echo "| API Key             : $INST_SICKBEARD_KEY_API"
echo "| Username            : $INST_SICKBEARD_UID"
echo "| Password            : $INST_SICKBEARD_PW"
echo "| Hostname            : http://localhost"
echo "| Port                : $INST_SABNZBD_PORT"

echo "----------------------"
echo "| Couch Potato"
echo "| API Key             : $INST_COUCHPOTATOD_API"
echo "| Username            : $INST_COUCHPOTATO_UID"
echo "| Password            : $INST_COUCHPOTATO_PW"
echo "| Hostname            : http://localhost"
echo "| Port                : $INST_COUCHPOTATO_PORT"
echo "-----------------------------------------------------------"
open http://localhost:7000
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s


echo "#------------------------------------------------------------------------------"
echo "# Install Maraschino - Complete"
echo "#------------------------------------------------------------------------------"