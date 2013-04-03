#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install SabNZBD"
echo "#------------------------------------------------------------------------------"
## http://www.newznabforums.com

source ../config.sh

mkdir -p $INST_FOLDER_USENET_INCOMPLETE
mkdir -p $INST_FOLDER_USENET_COMPLETE
mkdir -p $INST_FOLDER_USENET_WATCH

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
echo "| Server                                  : $INST_NEWSSERVER_SERVER"
echo "| Port                                    : $INST_NEWSSERVER_SERVER_PORT_SSL"
echo "| User Name                               : $INST_NEWSSERVER_SERVER_UID"
echo "| Password                                : $INST_NEWSSERVER_SERVER_PW"
echo "| SSL                                     : Enable"
echo "-----------------------------------------------------------"
echo "| Step 2"
echo "| Access                                  : I want SABnzbd to be viewable by any pc on my network."
echo "| Password protect access to SABnzbd      : Enable"
echo "| User Name                               : $INST_SABNZBD_UID"
echo "| Password                                : $INST_SABNZBD_PW"
echo "| HTTPS                                   : Disable"
echo "| Launch                                  : Disable"
echo "-----------------------------------------------------------"
open /Applications/SABnzbd.app 
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s

mkdir /Users/Andries/Library/Application\ Support/scripts
echo "-----------------------------------------------------------"
echo "| Folders:"
echo "| Temporary Download Folder               : $INST_FOLDER_USENET_INCOMPLETE"
echo "| Minimum Free Space                      : 1G"
echo "| Completed Download Folder               : $INST_FOLDER_USENET_COMPLETE"
echo "| Watched Folder                          : $INST_FOLDER_USENET_WATCH"
echo "| Watched Folder Scan Speed               : 300"
echo "| Post Processing Folder                  : ~/Library/Application Support/SABnzbd/scripts"
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
echo "|"
echo "| Post processing:"
echo "| Ignore Samples                          : Delete"
echo "| Post-Process Only Verified Jobs         : Disable"
echo "|"
echo "| Special:"
echo "| Empty_postproc                          : Enable"
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

source ../config.sh
#if [[ $INST_SABNZBD_KEY_API == "" ]] || [[ $INST_SABNZBD_KEY_NZB == "" ]]; then
if [[ -z $INST_SABNZBD_KEY_API ]] || [[ -z $INST_SABNZBD_KEY_NZB ]]; then
    echo "-----------------------------------------------------------"
    echo "| SABnzbd Web Server:"
    echo "| Please add the SABnzbd Web Server API key and NZB key to config.sh"
    echo "| API Key                              : INST_SABNZBD_KEY_API=<paste value> "
    echo "| NZB Key                              : INST_SABNZBD_KEY_NZB=<paste value>"
    echo "-----------------------------------------------------------"
    #open http://localhost/newznab/admin/site-edit.php
    open http://localhost:8080/config/general/
    subl ../config.sh

    while ( [[ $INST_SABNZBD_KEY_API == "" ]] || [[ $INST_SABNZBD_KEY_NZB == "" ]])
    do
        printf 'Waiting for SabNZBD API and NZB key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 2
        source ../config.sh
    done
fi

echo "-----------------------------------------------------------"
echo "| Add SabNZBD support to NewzNAB:"
echo "|*Integration Type              : User"
echo "| SABnzbd Url                   : http://localhost:8080/sabnzbd/"
echo "| SABnzbd Api Key               : $INST_SABNZBD_KEY_API"
echo "| Api Key Type (full)           : Full"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/site-edit.php
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

INST_FILE_LAUNCHAGENT="com.sabnzbd.SABnzbd.plist"
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
echo "# Installation SabNZBD Complete"
echo "#------------------------------------------------------------------------------"
