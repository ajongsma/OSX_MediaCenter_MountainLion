#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Auto-Sub"
echo "#------------------------------------------------------------------------------"
#AutoSub.py  ExamplePostProcess.py  README.txt  autosub changelog.xml  cherrypy  init.ubuntu  interface  library

source ../config.sh

brew install hg

#echo "Download latest Auto-Sub from http://code.google.com/p/auto-sub/"
#open http://code.google.com/p/auto-sub/downloads/list
#
#while ( [ ! -e ~/Downloads/auto-sub ] )
#do
#    printf 'Waiting for Auto-Sub to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
#    sleep 15
#done
#sleep 3
#sudo mv ~/Downloads/auto-sub /Applications/

cd /Applications
hg clone https://code.google.com/p/auto-sub/
sudo chown `whoami`:wheel -R /Applications/auto-sub

echo "-----------------------------------------------------------"
echo "| Click main menu item Config (niet sub-menu item(s)), General:"
echo "| Rootpath            : /Users/Andries/Media/Series"
echo "| Launchbrowser       : Disabled"
echo "| Fallback to English : Disabled"
echo "| Subtitle English    : nl"
echo "| Notify English      : Disabled"
echo "| Notify Dutch        : Disabled"
echo "-----------------------"
echo "| Save"
echo "-----------------------------------------------------------"

cd /Applications/auto-sub
osascript -e 'tell app "Terminal"
    do script "python /Applications/auto-sub/AutoSub.py"
end tell'
#sudo python /Applications/auto-sub/AutoSub.py
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

INST_FILE_LAUNCHAGENT="com.autosub.autosub.plist"
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
echo "# Install Auto-Sub - Complete"
echo "#------------------------------------------------------------------------------"
