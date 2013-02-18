#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Headphones"
echo "#------------------------------------------------------------------------------"

source ../config.sh

[ -d $INST_FOLDER_MUSIC_COMPLETE ] || mkdir -p $INST_FOLDER_MUSIC_COMPLETE
[ -d $INST_HEADPHONES_PATH ] || sudo mkdir -p $INST_HEADPHONES_PATH

#cd $INST_HEADPHONES_PATH
sudo git clone https://github.com/rembo10/headphones.git $INST_HEADPHONES_PATH
sudo chown -R `whoami`:wheel $INST_HEADPHONES_PATH

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
echo "| Download Scan Intervan               : 15"
echo "| Library Scan Intervan                : 2400"
echo "| -------------------------"
echo "| Save changes"
echo "| -------------------------"
echo "| Download settings"
echo "| SABnzbd Host                         : http://localhost/$INST_SABNZBD_PORT"
echo "| SABnzbd Username                     : $INST_SABNZBD_UID"
echo "| SABnzbd Password                     : $INST_SABNZBD_PW"
echo "| SABnzbd API                          : $INST_SABNZBD_KEY_API"
echo "| SABnzbd Category                     : Music"
echo "| Music Download Directory             : $INST_FOLDER_USENET_INCOMPLETE"
echo "| Usenet Retention                     : $INST_NEWSSERVER_RETENTION"
echo "| -------------------------"
echo "| Save changes"
echo "| -------------------------"
echo "| Search Providers"
echo "| nzbX                                 : Enable"
echo "| -------------------------"
echo "| Save changes"
echo "| -------------------------"
echo "| Download settings"
echo "| Move downloads to destination folder : Enable"
echo "| Rename Files                         : Enable"
echo "| Path to Destionation Folder          : $INST_FOLDER_MUSIC_COMPLETE"
echo "| -------------------------"
echo "| Save changes"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/role-edit.php?action=add
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Installing Headphones - Complete"
echo "#------------------------------------------------------------------------------"
