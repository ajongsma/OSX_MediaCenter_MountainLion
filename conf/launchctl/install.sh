#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Install Launch Agents"
echo "#------------------------------------------------------------------------------"

source ../config.sh

LAUNCHAGENTS_DIR=$HOME/Library/LaunchAgents

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GREY=$(tput setaf 238)
ORANGE=$(tput setaf 172)
BOLD=$(tput bold)
UNDERLINE=$(tput sgr 0 1)
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

plutil -lint com.sickbeard.sickbeard.plist
if [ -f ~/Library/LaunchAgents/com.sickbeard.sickbeard.plist ] ; then
    printf "$PRINTF_MASK" "com.sickbeard.sickbeard.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID   Status  Label"
    launchctl list | grep com.sickbeard.sickbeard
else
    printf "$PRINTF_MASK" "com.sickbeard.sickbeard.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.sickbeard.sickbeard.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.sickbeard.sickbeard.plist

    launchctl list | grep com.sickbeard.sickbeard
fi

plutil -lint com.autosub.autosub.plist
if [ -f ~/Library/LaunchAgents/com.autosub.autosub.plist ] ; then
    printf "$PRINTF_MASK" "com.autosub.autosub.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID   Status  Label"
    launchctl list | grep com.autosub.autosub
else
    printf "$PRINTF_MASK" "com.autosub.autosub.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.autosub.autosub.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.autosub.autosub.plist

    launchctl list | grep com.autosub.autosub
fi

plutil -lint com.couchpotato.couchpotato.plist
if [ -f ~/Library/LaunchAgents/com.couchpotato.couchpotato.plist ] ; then
    printf "$PRINTF_MASK" "com.couchpotato.couchpotato.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID   Status  Label"
    launchctl list | grep com.couchpotato.couchpotato
else
    printf "$PRINTF_MASK" "com.couchpotato.couchpotato.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.couchpotato.couchpotato.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.couchpotato.couchpotato.plist

    launchctl list | grep com.couchpotato.couchpotato
fi

plutil -lint com.maraschino.maraschino.plist
if [ -f ~/Library/LaunchAgents/com.maraschino.maraschino.plist ] ; then
    printf "$PRINTF_MASK" "com.maraschino.maraschino.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID   Status  Label"
    launchctl list | grep com.maraschino.maraschino
else
    printf "$PRINTF_MASK" "com.maraschino.maraschino.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.maraschino.maraschino.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.maraschino.maraschino.plist

    launchctl list | grep com.maraschino.maraschino
fi

plutil -lint com.tmux.spotweb.plist
if [ -f ~/Library/LaunchAgents/com.tmux.spotweb.plist ] ; then
    printf "$PRINTF_MASK" "com.tmux.spotweb.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID   Status  Label"
    launchctl list | grep com.tmux.spotweb
else
    printf "$PRINTF_MASK" "com.tmux.spotweb.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.tmux.spotweb.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.tmux.spotweb.plist

    launchctl list | grep com.tmux.spotweb
fi

plutil -lint com.tmux.newznab.plist
if [ -f ~/Library/LaunchAgents/com.tmux.newznab.plist ] ; then
    printf "$PRINTF_MASK" "com.tmux.newznab.plist found" "$GREEN" "[OK]" "$RESET"

    echo "PID   Status  Label"
    launchctl list | grep com.tmux.newznab
else
    printf "$PRINTF_MASK" "com.tmux.newznab.plist not found" "$YELLOW" "[FAIL]" "$RESET"

    cp com.tmux.newznab.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.tmux.newznab.plist

    launchctl list | grep com.tmux.newznab
fi