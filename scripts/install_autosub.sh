#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install Auto-Sub"
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

echo "Creating Lauch Agent file:"
cat >> /tmp/com.autosub.autosub.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.autosub.autosub</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python</string>
        <string>AutoSub.py</string>
        <string>--config</string>
        <string>/Applications/auto-sub/config.properties</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/Applications/auto-sub</string>
</dict>
</plist>
EOF

sudo mv /tmp/com.autosub.autosub.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.autosub.autosub.plist
#launchctl start ~/Library/LaunchAgents/com.autosub.autosub.plist

echo "#------------------------------------------------------------------------------"
echo "# Install Auto-Sub - Complete"
echo "#------------------------------------------------------------------------------"
