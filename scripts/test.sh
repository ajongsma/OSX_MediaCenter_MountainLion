#!/usr/bin/env bash


[ -d /usr/local/share/newznab ] || mkdir -p /usr/local/share/newznab
cp /Users/Andries/Github/OSX_NewBox/bin/share/tmux_sync_newznab.sh /usr/local/share/newznab
cp /Users/Andries/Github/OSX_NewBox/bin/share/newznab_cycle.sh /usr/local/share/newznab
ln -s /usr/local/share/newznab/tmux_sync_newznab.sh /usr/local/bin/

[ -d /var/log/newznab ] || sudo mkdir -p /var/log/newznab && sudo chown `whoami` /var/log/newznab

INST_FILE_LAUNCHAGENT="com.tmux.newznab.plist"
if [ -f $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
    echo "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT"
    cp $DIR/launchctl/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
    if [ "$?" != "0" ]; then
        echo -e "${RED}  ============================================== ${RESET}"
        echo -e "${RED} | ERROR ${RESET}"
        echo -e "${RED} | Copy failed: ${RESET}"
        echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
        echo -e "${RED} | --- press any key to continue --- ${RESET}"
        echo -e "${RED}  ============================================== ${RESET}"
        read -n 1 -s
        exit 1
    fi
    launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
else
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | LaunchAgent file not found: ${RESET}"
    echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
    echo -e "${RED} | --- press any key to continue --- ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
    exit 1
fi
