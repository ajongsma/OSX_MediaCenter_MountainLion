#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing CouchPotato"
echo "#------------------------------------------------------------------------------"
## http://christopher-williams.net/2011/02/automating-your-movie-downloads-with-sabnzbd-and-couchpotato/

source ../config.sh

[ -d $INST_FOLDER_MOVIES_COMPLETE ] || mkdir -p $INST_FOLDER_MOVIES_COMPLETE

echo "Download the latest CouchPotato from http://couchpotatoapp.com"
open http://couchpotatoapp.com
#open https://couchpota.to/updates/latest/osx/
#http://www.downloadbestsoft.com/download/CouchPotato-2.0.6.1.macosx-10_6-intel.zip

#cd ~/Downloads
while ( [ ! -e ~/Downloads/CouchPotato.app ] )
do
    printf 'Waiting for CouchPotato to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
    sleep 15
done
sleep 3
sudo mv ~/Downloads/CouchPotato.app /Applications

open /Applications/CouchPotato.app

#osascript -e 'tell app "Terminal"
#    do script "open /Applications/CouchPotato.app"
#end tell'

#??
# python ~/Downloads/CouchPotato.app/CouchPotato.py -d
#??

echo "-----------------------------------------------------------"
echo "| Enter the following settings:"
echo "| "
echo "| Basics:"
echo "| username          : $INST_COUCHPOTATO_UID"
echo "| password          : $INST_COUCHPOTATO_PW"
echo "| port              : $INST_COUCHPOTATO_PORT"
echo "| Lauch Browser     : Uncheck"
echo "-----------------------------------------------------------"
echo "| Download Apps:"
echo "| "
echo "| Black Hole        : Disable"
echo "| SABNnzbd          : Enable"
echo "| SABnzbd URL       : localhost:$INST_SABNZBD_PORT"
echo "| SABnzbd API Key   : INST_SABNZBD_KEY_API=<paste value>"
echo "| SABnzbd Category  : movies"
echo "| Delete Failed     : Disable (Sabnzbd only)"
echo "-----------------------------------------------------------"
echo "| Registered at sites:"
echo "| "
echo "| Torrent related   : Disable all"
echo "-----------------------------------------------------------"
echo "| Move and rename the movies:"
echo "| "
echo "| => Enable: Show Advanced Settings"
echo "| "
echo "| Rename downloaded movies : Enable"
echo "| From              : $INST_FOLDER_USENET_COMPLETE"
echo "| To                : $INST_FOLDER_MOVIES_COMPLETE"
echo "| Cleanup           : Enable"
echo "| "
echo "| Run Every         : 1440 (e.g. 24 hours)"
echo "| Force Every       : 24 (e.g. 24 hours)"
echo "| Next On_failed    : Disable"

echo "| Download Subtitles: Enable"
echo "| Language          : nl"
echo "-----------------------------------------------------------"
echo "| Save settings"
echo "-----------------------------------------------------------"
echo ""
echo "-----------------------------------------------------------"
echo "| Settings (Click top-right gear icon)"
echo "-----------------------------------------------------------"
echo "| Searcher :"
echo "| Preferredd Words   : dutch"
echo "| Ignored Words      : <remove dutch>"
echo "| First search       : Usenet"
echo "| Retention          : $INST_NEWSSERVER_RETENTION"
echo "-----------------------------------------------------------"
#open http://localhost:5050/settings/
#open http://localhost:8082
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

source ../config.sh
#if [[ $INST_COUCHPOTATOD_API == "" ]]; then
if [[ -z $INST_COUCHPOTATOD_API ]] ; then
    echo "-----------------------------------------------------------"
    echo "| Main Site Settings, API:"
    echo "| Click Show Advanced settings"
    echo "| Add the CouchPotato API key to config.sh"
    echo "| INST_COUCHPOTATOD_API : <copy/paste the shown API KEY>"
    echo "-----------------------------------------------------------"
    open http://localhost:5050/settings/general
    subl ../config.sh

    while ( [[ $INST_COUCHPOTATOD_API == "" ]] )
    do
        printf 'Waiting for the CouchPotato API key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
        source ../config.sh
    done
fi

if [ -f $DIR/conf/launchctl/com.couchpotato.couchpotato.plist ] ; then
    echo "Copying Lauch Agent file:"
    cp $DIR/launchctl/com.couchpotato.couchpotato.plist ~/Library/LaunchAgents/
else
    echo "Creating Lauch Agent file:"
    ### --- TESTING ---
    #echo "Creating Lauch Agent file:"
    #cat >> /tmp/com.couchpotato.couchpotato.plist <<'EOF'
    #<?xml version="1.0" encoding="UTF-8"?>
    #<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    #<plist version="1.0">
    #<dict>
    #  <key>Label</key>
    #  <string>com.couchpotato.couchpotato</string>
    #  <key>ProgramArguments</key>
    #  <array>
    #      <string>/usr/local/bin/python</string>
    #      <string>/Applications/CouchPotato.app/CouchPotato.py</string>
    #  </array>
    #  <key>RunAtLoad</key>
    #  <true/>
    #</dict>
    #</plist>
    #EOF
    
    #cat >> /tmp/com.couchpotato.couchpotato.plist <<'EOF'
    #<?xml version="1.0" encoding="UTF-8"?>
    #<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    #<plist version="1.0">
    #<dict>
    #    <key>Label</key>
    #    <string>com.couchpotato.couchpotato</string>
    #    <key>ProgramArguments</key>
    #    <array>
    #        <string>/usr/bin/python</string>
    #        <string>CouchPotato.py</string>
    #        <string>--quiet</string>
    #        <string>--daemon</string>
    #    </array>
    #    <key>RunAtLoad</key>
    #    <true/>
    #    <key>WorkingDirectory</key>
    #    <string>/Applications/CouchPotato.app</string>
    #</dict>
    #</plist>
    #EOF
    
    #
    #<?xml version="1.0" encoding="UTF-8"?>
    #<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    #<plist version="1.0">
    #<dict>
    #    <key>Label</key>
    #    <string>com.couchpotato.couchpotato</string>
    #    <key>OnDemand</key>
    #    <false/>
    #    <key>ProgramArguments</key>
    #    <array>
    #    <string>python</string>
    #    <string>/Applications/CouchPotato.app/CouchPotato.py</string>
    #    </array>
    #    <key>RunAtLoad</key>
    #    <true/>
    #    <key>WorkingDirectory</key>
    #    <string>/Applications/CouchPotato.app/</string>
    #    <key>ServiceDescription</key>
    #    <string>CouchPotato</string>
    #</dict>
    #</plist>
    
    #<?xml version="1.0" encoding="UTF-8"?>
    #<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    #<plist version="1.0">
    #<dict>
    #  <key>Label</key>
    #  <string>com.couchpotato.couchpotato</string>
    #  <key>ProgramArguments</key>
    #  <array>
    #     <string>/usr/local/bin/python</string>
    #     <string>/Applications/CouchPotato.app/CouchPotato.py</string>
    #  </array>
    #  <key>RunAtLoad</key>
    #  <true/>
    #</dict>
    #</plist>

    #mv /tmp/com.couchpotato.couchpotato.plist ~/Library/LaunchAgents/
fi

launchctl load ~/Library/LaunchAgents/com.couchpotato.couchpotato.plist
#launchctl start ~/Library/LaunchAgents/com.couchpotatoserver.couchpotato.plist

echo "#------------------------------------------------------------------------------"
echo "# Install CouchPotato - Complete"
echo "#------------------------------------------------------------------------------"
