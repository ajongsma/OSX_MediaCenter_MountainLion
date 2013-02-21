#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install Launch Agents"
echo "#------------------------------------------------------------------------------"

source ../config.sh

BOLD=$(tput bold)
BLACK=$(tput setaf 0) #   0  Black
RED=$(tput setaf 1)  #  1   Red
GREEN=$(tput setaf 2)  #    2   Green
YELLOW=$(tput setaf 3)  #   3   Yellow
BLUE=$(tput setaf 4)  #     4   Blue
MAGENTA=$(tput setaf 5)  #  5   Magenta
CYAN=$(tput setaf 6)  #     6   Cyan
WHITE=$(tput setaf 7)  #    7   White
RESET=$(tput sgr0)

PRINTF_MASK="%-50s %s %10s %s\n"

plutil -lint com.nnindexer.nnindexer.plist
if [ -f ~/Library/LaunchAgents/com.nnindexer.nnindexer.plist ] ; then
    printf "$PRINTF_MASK" "com.nnindexer.nnindexer.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID	Status	Label"
    launchctl list | grep com.nnindexer.nnindexer
else
    printf "$PRINTF_MASK" "com.nnindexer.nnindexer.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.nnindexer.nnindexer.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.nnindexer.nnindexer.plist

    launchctl list | grep com.nnindexer.nnindexer
fi

plutil -lint com.sabnzbd.SABnzbd.plist
if [ -f ~/Library/LaunchAgents/com.sabnzbd.SABnzbd.plist ] ; then
    printf "$PRINTF_MASK" "com.sabnzbd.SABnzbd.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID	Status	Label"
    launchctl list | grep com.sabnzbd.SABnzbd
else
    printf "$PRINTF_MASK" "com.sabnzbd.SABnzbd.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.sabnzbd.SABnzbd.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.sabnzbd.SABnzbd.plist

    launchctl list | grep com.sabnzbd.SABnzbd
fi

plutil -lint com.maraschino.maraschino.plist
if [ -f ~/Library/LaunchAgents/com.maraschino.maraschino.plist ] ; then
    printf "$PRINTF_MASK" "com.maraschino.maraschino.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID	Status	Label"
    launchctl list | grep com.maraschino.maraschino
else
    printf "$PRINTF_MASK" "com.maraschino.maraschino.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.maraschino.maraschino.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.maraschino.maraschino.plist

    launchctl list | grep com.maraschino.maraschino
fi

plutil -lint com.autosub.autosub.plist
if [ -f ~/Library/LaunchAgents/com.autosub.autosub.plist ] ; then
    printf "$PRINTF_MASK" "com.autosub.autosub.plist found" "$GREEN" "[OK]" "$RESET"
    echo "PID	Status	Label"
    launchctl list | grep com.autosub.autosub
else
    printf "$PRINTF_MASK" "com.autosub.autosub.plist not found" "$YELLOW" "[FAIL]" "$RESET"
fi
