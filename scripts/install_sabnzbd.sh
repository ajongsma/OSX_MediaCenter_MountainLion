#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install SabNZBD"
echo "#------------------------------------------------------------------------------"
## http://www.newznabforums.com

source ../config.sh

mkdir -p ~/Downloads/Usenet/Incomplete
mkdir -p ~/Downloads/Usenet/Complete
mkdir -p ~/Downloads/Usenet/Watch

if [ ! -e /Applications/SABnzbd.app ] ; then
    echo "SABnzbd not installed, please install..."
    open http://sabnzbd.org/
    while ( [ ! -e /Applications/SABnzbd.app ] )
    do
        echo "Waiting for SABnzbd to be installed..."
        sleep 15
    done
else
    echo "SABnzbd found                               [OK]"
fi

echo "-----------------------------------------------------------"
echo "| News Server Setup:"
echo "| Server            : $INST_NEWSSERVER_SERVER"
echo "| Port              : $INST_NEWSSERVER_SERVER_PORT_SSL"
echo "| User Name         : $INST_NEWSSERVER_SERVER_UID"
echo "| Password          : $INST_NEWSSERVER_SERVER_PW"
echo "| SSL               : Enable"
echo "-----------------------------------------------------------"
echo "| Step 2"
echo "| Access            : I want SABnzbd to be viewable by any pc on my network."
echo "| Password protect access to SABnzbd : Enable"
echo "| User Name         : $INST_SABNZBD_UID"
echo "| Password          : $INST_SABNZBD_PW"
echo "| HTTPS             : Disable"
echo "| Launch            : Disable"
echo "-----------------------------------------------------------"
open /Applications/SABnzbd.app 
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s

mkdir /Users/Andries/Library/Application\ Support/scripts
echo "-----------------------------------------------------------"
echo "| Folders:"
echo "| Temporary Download Folder : ~/Downloads/Usenet/Incomplete"
echo "| Minimum Free Space        : 1G"
echo "| Completed Download Folder : ~/Downloads/Usenet/Complete"
echo "| Watched Folder            : ~/Downloads/Usenet/Watch"
echo "| Watched Folder Scan Speed : 300"
echo "| Post Processing Folder    : ~/Library/Application Support/SABnzbd/scripts"
echo "-----------------------------------------------------------"
http://localhost:8080/sabnzbd/config/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| Switches"
echo "| Queue:"
echo "| Abort jobs that cannot be completed     : Enable"
echo "| Check before download                   : Enable"
echo "| Pause Downloading durig post-processing : Enable"
echo "| Post processing:"
echo "| Ignore Samples                          : Delete"
echo "-----------------------------------------------------------"
open http://localhost:8080/config/switches/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| Create the following categories:"
echo "| anime, Default, Default, Default"
echo "| apps, Default, Default, Default"
echo "| books, Default, Default, Default"
echo "| consoles, Default, Default, Default"
echo "| games, Default, Default, Default"
echo "| movies, Default, Default, Default"
echo "| music, Default, Default, Default"
echo "| pda, Default, Default, Default"
echo "| tv, Default, Default, Default"
echo "-----------------------------------------------------------"
open http://localhost:8080/sabnzbd/config/categories/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "Creating Lauch Agent file:"
cat >> /tmp/com.sabnzbd.SABnzbd.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.sabnzbd.SABnzbd</string>
  <key>ProgramArguments</key>
  <array>
     <string>/usr/bin/open</string>
     <string>-a</string>
      <string>/Applications/SABnzbd.app</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF

mv /tmp/com.sabnzbd.SABnzbd.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.sabnzbd.SABnzbd.plist

source ../config.sh
#if [[ $INST_SABNZBD_KEY_API == "" ]] || [[ $INST_SABNZBD_KEY_NZB == "" ]]; then
if [[ -z $INST_SABNZBD_KEY_API ]] || [[ -z $INST_SABNZBD_KEY_NZB ]]; then
    echo "-----------------------------------------------------------"
    echo "| Main Site Settings, API:"
    echo "| Please add the SabNZBD API key and NZB key to config.sh"
    echo "-----------------------------------------------------------"
    open http://localhost/newznab/admin/site-edit.php
    subl ../config.sh

    while ( [[ $INST_SABNZBD_KEY_API == "" ]] && [[ $INST_SABNZBD_KEY_NZB == "" ]])
    do
        printf 'Waiting for NewzNAB API and NZB key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
        source ../config.sh
    done
fi

#if [[ $INST_SABNZBD_KEY_API == "" ]]; then
#    echo "-----------------------------------------------------------"
#    echo "| Main Site Settings, API:"
#    echo "| Please add the SabNZBD API key and NZB key to config.sh"
#    echo "-----------------------------------------------------------"
#    open http://localhost/newznab/admin/site-edit.php
#    subl ../config.sh
#    while ( [[ $INST_SABNZBD_KEY_API == "" ]] )
#    do
#        printf 'Waiting for NewzNAB API key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
#        sleep 15
#        source ../config.sh
#    done
#fi
#
#if [[ $INST_SABNZBD_KEY_NZB == "" ]]; then
#    echo "-----------------------------------------------------------"
#    echo "| Main Site Settings, API:"
#    echo "| Please add the SabNZBD NZB key to config.sh"
#    echo "-----------------------------------------------------------"
#    open http://localhost/newznab/admin/site-edit.php
#    subl ../config.sh
#    while ( [[ $INST_SABNZBD_KEY_NZB == "" ]] )
#    do
#        printf 'Waiting for NewzNAB NZB key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
#        sleep 15
#        source ../config.sh
#    done
#fi


## SabNZBD - AFTER SabNZBD INSTALL
echo "-----------------------------------------------------------"
echo "| Add SabNZBD support to NewzNAB:
echo "|*Integration Type              : Site Wide"
echo "| SABnzbd Url                   : http://localhost:8080/sabnzbd/"
echo "| SABnzbd Api Key               : (http://localhost:8080/config/general/)"
echo "| Api Key Type (full)           : $INST_SABNZBD_KEY_API"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/site-edit.php
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s


echo "#------------------------------------------------------------------------------"
echo "# Installation SabNZBD Complete"
echo "#------------------------------------------------------------------------------"
