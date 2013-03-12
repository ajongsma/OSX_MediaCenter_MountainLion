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

INST_FILE_LAUNCHAGENT="com.maraschino.maraschino.plist"
if [ -f $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
    echo "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT"
    cp $DIR/launchctl/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
    if [ "$?" != "0" ]; then
        echo -e "${RED}  ============================================== ${RESET}"
        echo -e "${RED} | ERROR ${RESET}"
        echo -e "${RED} | Copy failed: ${RESET}"
        echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
        echo -e "${RED} | --- press any key to continue --- ${RESET}"
        echo -e "${RED}  ============================================== ${RESET}"
        read -n 1 -s
        exit 1
    fi
else
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | LaunchAgent file not found: ${RESET}"
    echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
    echo -e "${RED} | --- press any key to continue --- ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
    sudo mv /tmp/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
fi
launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT


echo "#------------------------------------------------------------------------------"
echo "# Install Maraschino - Complete"
echo "#------------------------------------------------------------------------------"
