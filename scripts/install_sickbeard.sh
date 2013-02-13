#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Sick-Beard"
echo "#------------------------------------------------------------------------------"

### ----------------------------------------
### http://jetshred.com/2012/07/26/installing-sickbeard-on-os-x-10-dot-8/
### Since daemon mode is what’s not working all that’s necessary to get around the bug is to not use daemon mode. Here it is:
### --------------------
### This script starts SickBeard and suppressed the output so
### that it runs as if in daemon mode while avoiding the daemon mode
### issue. Once you have changed the settings
### save this script as an Application and add it to your Login Items.
##
###Change the following line to the path to your SickBeard folder
##set pathToSickBeard to "~/Development/Sick-Beard"
##
###You probably don't want to change anything below here
##do shell script "python " & pathToSickBeard & "/SickBeard.py > /dev/null 2>&1 &"
### ----------------------------------------

source ../config.sh

[ -d ~/Github ] || mkdir -p ~/Github
#if [ ! -d ~/Github/ ] ; then
#    mkdir ~/Github/
#fi

#cd ~/Github/
#
#git clone https://github.com/clinton-hall/nzbToMedia
#cp -R ~/Github/nzbToMedia/* ~/Library/Application\ Support/SABnzbd/scripts/
##cp /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/
#
#cd ~/Library/Application\ Support/SABnzbd/scripts/
#cp autoProcessTV.cfg.sample autoProcessTV.cfg 
#cp autoProcessMovie.cfg.sample autoProcessMovie.cfg
#echo "-----------------------------------------------------------"
#echo "| Modify the following:"
#echo "| port=8081"
#echo "| username=couchpotato"
#echo "| password=<password>"
#echo "| web_root="
#echo "-----------------------------------------------------------"
#subl autoProcessTV.cfg 

cd /Applications
sudo git clone git://github.com/midgetspy/Sick-Beard.git
sudo chown `whoami` /Applications/Sick-Beard/
#sudo chown -R andries:staff /Applications/Sick-Beard/
cd Sick-Beard
#?? python /Applications/Sick-Beard/CouchPotato.py sickbeard.py  -d -q

osascript -e 'tell app "Terminal"
    do script "python /Applications/Sick-Beard/sickbeard.py"
end tell'
#python /Applications/Sick-Beard/sickbeard.py

echo "-----------------------------------------------------------"
echo "| Menu, Config, General:"
echo "| Launch Browser    : disable"
echo "| User Name         : sickbeard"
echo "| Password          : <password>"
echo "| Enable API        : enable"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Search Settings:"
echo "| Enable API        : enable"
echo "| Search Frequency  : 15"
echo "| Usenet Retention  : 1000"
echo "| NZB Search        : enable"
echo "| NZBMethod         : SABnzbd"
echo "| SABnzbd URL       : http://localhost:8080"
echo "| SABnzbd Username  : sabnzbd"
echo "| SABnzbd Password  : <password>"
echo "| SABnzbd API Key   : (from SABnzb (http://localhost:8080/config/general/)"
echo "| SABnzbd Category  : tv"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Search Providers"
echo "| Sick Beard Index  : Enable"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Post Processing"
echo "| Keep original files : Uncheck"
echo "| Name Pattern      : Season %0S/%SN S%0SE%0E %QN-%RG"
echo "| Multi-Episode     : Extend"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Categories:"
echo "| tv, Default, Default, nzbToSickBeard.py"
echo "-----------------------------------------------------------"
open http://localhost:8081
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

#open http://localhost:8080/config/switches/


##### ????
## http://jetshred.com/2012/07/31/configuring-sickbeard-to-work-with-sabnzbd-plus/
## tv, Default, Default, sabToSickBeard.py, /Users/Andries/Media/Series
##### ????

#sudo python /Applications/Sick-Beard/sickbeard.py –d
#sudo python /Applications/Sick-Beard/sickbeard.py -q --nolaunch

echo "Creating Lauch Agent file:"
cat >> /tmp/com.sickbeard.sickbeard.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>Label</key>
    <string>com.sickbeard.sickbeard</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python</string>
        <string>SickBeard.py</string>
        <string>-q</string>
        <string>--nolaunch</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/Applications/Sick-Beard</string>
</dict>
</plist>
EOF

mv /tmp/com.sickbeard.sickbeard.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.sickbeard.sickbeard.plist

echo "#------------------------------------------------------------------------------"
echo "# Installing Sick-Beard - Complete"
echo "#------------------------------------------------------------------------------"
