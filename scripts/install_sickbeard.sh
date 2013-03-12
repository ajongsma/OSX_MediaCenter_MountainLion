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
[ -d $INST_FOLDER_SERIES_COMPLETE ] || mkdir -p $INST_FOLDER_SERIES_COMPLETE

cd /Applications
sudo git clone git://github.com/midgetspy/Sick-Beard.git
sudo chown -R `whoami`:wheel /Applications/Sick-Beard/
cd Sick-Beard
#?? python /Applications/Sick-Beard/CouchPotato.py sickbeard.py  -d -q

osascript -e 'tell app "Terminal"
    do script "python /Applications/Sick-Beard/sickbeard.py"
end tell'
#python /Applications/Sick-Beard/sickbeard.py

echo "-----------------------------------------------------------"
echo "| Config, General:"
echo "| Launch Browser    : disable"
echo "| User Name         : $INST_SICKBEARD_UID"
echo "| Password          : $INST_SICKBEARD_PW"
echo "| Enable API        : enable"
echo "| Enable API        : Generate"
echo "|-------------------"
echo "| Save Changes"
echo "-----------------------------------------------------------"
echo "| >> Copy the generated API key into $DIR/config.sh <<"
echo "-----------------------------------------------------------"
echo "| Config, Search Settings, NZB Search:"
echo "| Search Frequency  : 15"
echo "| Usenet Retention  : $INST_NEWSSERVER_RETENTION"
echo "| Search NZB        : enable"
echo "| NZBMethod         : SABnzbd"
echo "| SABnzbd URL       : http://localhost:8080"
echo "| SABnzbd Username  : $INST_SABNZBD_UID"
echo "| SABnzbd Password  : $INST_SABNZBD_PW"
echo "| SABnzbd API Key   : $INST_SABNZBD_KEY_API"
echo "| SABnzbd Category  : tv"
echo "|-------------------"
echo "| Test and Save Changes"
echo "-----------------------------------------------------------"
echo "| Config, Search Providers"
echo "| Sick Beard Index  : Enable"
echo "|-------------------"
echo "| Save Changes"
echo "-----------------------------------------------------------"
echo "| Config, Post Processing"
echo "| Keep original files : Uncheck"
echo "| Name Pattern        : Custom"
echo "|                     : Season %0S/%SN S%0SE%0E %QN-%RG"
echo "| Multi-Episode       : Extend"
echo "|-------------------"
echo "| Save Changes"
echo "-----------------------------------------------------------"
echo "| Home, Add Show"
echo "| - Add Existing Show"
echo "|   - New"
echo "| Choose Directory    : $INST_FOLDER_SERIES_COMPLETE"
echo "|-------------------"
echo "| Submit"
echo "-----------------------------------------------------------"
open http://localhost:8081
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

source ../config.sh
#if [[ $INST_SABNZBD_KEY_API == "" ]] || [[ $INST_SABNZBD_KEY_NZB == "" ]]; then
if [[ -z $INST_SICKBEARD_KEY_API ]]; then
    echo "-----------------------------------------------------------"
    echo "| API:"
    echo "| Please add the Sickbeard API key to config.sh"
    echo "| API Key                              : INST_SICKBEARD_KEY_API=<paste value>"
    echo "-----------------------------------------------------------"
    #open http://localhost/newznab/admin/site-edit.php
    http://localhost:8081/config/general/
    subl ../config.sh

    while ( [[ -z $INST_SICKBEARD_KEY_API ]])
    do
        printf 'Waiting for Sick-Beard API key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 3
        source ../config.sh
    done
fi

#####
## sudo cp /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/ 
#autoProcessTV.cfg.sample
#autoProcessTV.py
#hellaToSickBeard.py
#sabToSickBeard.py
#
## Original
#[SickBeard]
#host=localhost
#port=8081
#username=
#password=
#web_root=
#
## nzbToMedia
#[SickBeard]
#host=localhost
#port=8081
#username=sickbeard
#password=mini_sickbeard
#web_root=
#ssl=0
#watch_dir= /Users/Andries/Downloads/Usenet/Complete
#failed_fork=0
#category = tv
#destination = /Users/Andries/Media/Series
#####

#echo "-----------------------------------------------------------"
#echo "| Menu, Config, Categories:"
#echo "| tv, Default, Default, nzbToSickBeard.py"
#echo "-----------------------------------------------------------"
#open http://localhost:8080/config/categories/
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s

#open http://localhost:8080/config/switches/


##### ????
## http://jetshred.com/2012/07/31/configuring-sickbeard-to-work-with-sabnzbd-plus/
## tv, Default, Default, sabToSickBeard.py, /Users/Andries/Media/Series
##### ????

#sudo python /Applications/Sick-Beard/sickbeard.py –d
#sudo python /Applications/Sick-Beard/sickbeard.py -q --nolaunch

if [ -f $DIR/conf/launchctl/com.sickbeard.sickbeard.plist ] ; then
    echo "Copying Lauch Agent file:"
    cp $DIR/launchctl/com.sickbeard.sickbeard.plist ~/Library/LaunchAgents/
else
    echo "Creating Lauch Agent file:"
    cat >> /tmp/com.sickbeard.sickbeard.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
	<string>com.sickbeard.sickbeard</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/python</string>
		<string>/Applications/Sick-Beard/SickBeard.py</string>
		<string>-q</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>WorkingDirectory</key>
	<string>/Applications/Sick-Beard</string>
</dict>
</plist>
EOF
    sudo mv /tmp/com.sickbeard.sickbeard.plist ~/Library/LaunchAgents/
fi

launchctl load ~/Library/LaunchAgents/com.sickbeard.sickbeard.plist

echo "#------------------------------------------------------------------------------"
echo "# Installing Sick-Beard - Complete"
echo "#------------------------------------------------------------------------------"
