#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Configuring Sickbeard for SABnzbd - nzbToMedia"
echo "#------------------------------------------------------------------------------"

source ../config.sh

if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'SABnzbd - nzbToMedia installed\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'SABnzbd - nzbToMedia not installed\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${RED} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi

echo "-----------------------------------------------------------"
echo "| Add the following to [SickBeard]:"
echo "| host                                    : localhost"
echo "| Port                                    : 8081"
echo "| username                                : $INST_SICKBEARD_UID"
echo "| password                                : $INST_SICKBEARD_PW"
echo "-----------------------------------------------------------"
subl ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s


echo "#------------------------------------------------------------------------------"
echo "# Configuring Sickbeard for SABnzbd - nzbToMedia - Complete"
echo "#------------------------------------------------------------------------------"
