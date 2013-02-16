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

open http://localhost:7000


#sudo python /Applications/auto-sub/AutoSub.py
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s


echo "#------------------------------------------------------------------------------"
echo "# Install Maraschino - Complete"
echo "#------------------------------------------------------------------------------"