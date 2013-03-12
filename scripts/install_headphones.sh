#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Headphones"
echo "#------------------------------------------------------------------------------"

source ../config.sh

[ -d $INST_FOLDER_MUSIC_COMPLETE ] || mkdir -p $INST_FOLDER_MUSIC_COMPLETE && sudo chown -R `whoami`:wheel $INST_HEADPHONES_PATH
[ -d $INST_HEADPHONES_PATH ] || sudo mkdir -p $INST_HEADPHONES_PATH

#cd $INST_HEADPHONES_PATH
sudo git clone https://github.com/rembo10/headphones.git $INST_HEADPHONES_PATH

cd $INST_HEADPHONES_PATH
osascript -e 'tell app "Terminal"
    do script "cd $INST_HEADPHONES_PATH; python Headphones.py"
end tell'
open http://localhost:8181

echo "-----------------------------------------------------------"
echo "| Click on the Cogwheel top-right and enter the following settings:"
echo "| "
echo "| Web Interface"
echo "| HTTP Port                            : $INST_HEADPHONES_PORT"
echo "| HTTP Username                        : $INST_HEADPHONES_UID"
echo "| HTTP Password                        : $INST_HEADPHONES_PW"
echo "| Lauch Browser                        : Disable"
echo "| Enable API                           : Enable"
echo "|                                      : Generate and add the key to config.sh"
echo "| NZB Search Interval                  : 15"
echo "| Download Scan Intervan               : 15"
echo "| Library Scan Intervan                : 2400"
echo "| -------------------------"
echo "| Save changes"
echo "| -------------------------"
echo "| Download settings"
echo "| SABnzbd Host                         : http://localhost:$INST_SABNZBD_PORT"
echo "| SABnzbd Username                     : $INST_SABNZBD_UID"
echo "| SABnzbd Password                     : $INST_SABNZBD_PW"
echo "| SABnzbd API                          : $INST_SABNZBD_KEY_API"
echo "| SABnzbd Category                     : Music"
echo "| Music Download Directory             : $INST_FOLDER_USENET_COMPLETE/Music"
echo "| Usenet Retention                     : $INST_NEWSSERVER_RETENTION"
echo "| -------------------------"
echo "| Save changes"
echo "| -------------------------"
echo "| Search Providers"
echo "| nzbX                                 : Enable"
echo "| -------------------------"
echo "| Save changes"
echo "| -------------------------"
echo "| Quality and Post Processing"
echo "| Move downloads to destination folder : Enable"
echo "| Rename Files                         : Enable"
echo "| Path to Destionation Folder          : $INST_FOLDER_MUSIC_COMPLETE"
echo "| -------------------------"
echo "| Save changes"
echo "| -------------------------"
echo "| Advanced Settings"
echo "| Re-encode downloads during postproces: Enable"
echo "| Only re-encode lossles files (flac)  : Enable"
echo "| Delete original files after encoding : Enable"
echo "| -------------------------"
echo "| Save changes"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/role-edit.php?action=add
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

INST_FILE_LAUNCHAGENT="com.headphones.headphones.plist"
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
echo "# Installing Headphones - Complete"
echo "#------------------------------------------------------------------------------"
