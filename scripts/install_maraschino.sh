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

if [ -f $DIR/conf/launchctl/com.maraschino.maraschino.plist ] ; then
    echo "Copying Lauch Agent file:"
    cp $DIR/launchctl/com.maraschino.maraschino.plist ~/Library/LaunchAgents/
else
    echo "Creating Lauch Agent file:"
    cat >> /tmp/com.maraschino.maraschino.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.maraschino.maraschino</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/bin/python</string>
      <string>/Applications/maraschino/Maraschino.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF
    sudo mv /tmp/com.maraschino.maraschino.plist ~/Library/LaunchAgents/
fi

launchctl load ~/Library/LaunchAgents/com.maraschino.maraschino.plist

echo "#------------------------------------------------------------------------------"
echo "# Install Maraschino - Complete"
echo "#------------------------------------------------------------------------------"
