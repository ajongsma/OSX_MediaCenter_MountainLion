#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing CouchPotato"
echo "#------------------------------------------------------------------------------"
## http://christopher-williams.net/2011/02/automating-your-movie-downloads-with-sabnzbd-and-couchpotato/

source ../config.sh

echo "Download the latest CouchPotato from http://couchpotatoapp.com"
open http://couchpotatoapp.com
#open https://couchpota.to/updates/latest/osx/

#cd ~/Downloads
while ( [ ! -e ~/Downloads/CouchPotato.app ] )
do
    printf 'Waiting for CouchPotato to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
    sleep 15
done
sudo mv ~/Downloads/CouchPotato.app /Applications

#??
#osascript -e 'tell app "Terminal"
#    do script "/Applications/CouchPotato.app"
#end tell'
#??

#??
#open /Applications/CouchPotato.app
#??

#??
#osascript -e 'tell app "Terminal"
#    do script "python /Applications/CouchPotato.app/CouchPotato.py"
#end tell'
#??

#??
# python ~/Downloads/CouchPotato.app/CouchPotato.py -d
#??

echo "-----------------------------------------------------------"
echo "| Enter the following settings:"
echo "| username          : couchpotato"
echo "| password          : <password>"
echo "| port              : 8082"
echo "| Lauch Browser     : Uncheck"
echo "-----------------------------------------------------------"
echo "| Download Apps:"
echo "| SABNnzbd:"
echo "| SABnzbd URL       : localhost:8080"
echo "| SABnzbd API Key   : (from SABnzb (http://localhost:8080/config/general/)"
echo "| SABnzbd Category  : movies"
echo "-----------------------------------------------------------"
echo "-----------------------------------------------------------"
echo " Settings, Searcher :"
echo " Preferrd Words     : dutch"
echo " Ignored Words      : <remove dutch>"
echo " Retention          : 1000"
echo "-----------------------------------------------------------"
open http://localhost:8082
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

source ../config.sh
#if [[ $INST_COUCHPOTATOD_API == "" ]]; then
if [[ -z $INST_COUCHPOTATOD_API ]] ; then
    echo "-----------------------------------------------------------"
    echo "| Main Site Settings, API:"
    echo "| Please add the CouchPotato API key to config.sh"
    echo "-----------------------------------------------------------"
    open http://localhost/newznab/admin/site-edit.php
    subl ../config.sh

    while ( [[ $INST_COUCHPOTATOD_API == "" ]] )
    do
        printf 'Waiting for the CouchPotato API key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
        source ../config.sh
    done
fi


echo "-----------------------------------------------------------"
echo "| Menu, Config, Categories:"
echo "| movies, Default, Default, nzbToCouchpotato.py"
echo "-----------------------------------------------------------"
open http://localhost:8080/config/switches/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

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
#

#mv /tmp/com.couchpotato.couchpotato.plist ~/Library/LaunchAgents/
#launchctl load ~/Library/LaunchAgents/com.couchpotato.couchpotato.plist
#
#launchctl start ~/Library/LaunchAgents/com.couchpotatoserver.couchpotato.plist

echo "#------------------------------------------------------------------------------"
echo "# Installing CouchPotato - Complete"
echo "#------------------------------------------------------------------------------"
