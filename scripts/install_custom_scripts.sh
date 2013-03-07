#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Custom Scripts"
echo "#------------------------------------------------------------------------------"

source ../config.sh

GIT_ROOT=$(readlink -f ./$(git rev-parse --show-cdup))

[ -d $HOME/.bin ] || mkdir $HOME/.bin

if [ ! -f "$HOME/.bin/tmux_sync_newznab.sh" ] ; then
	echo "Not found: tmux_sync_newznab.sh. Copying..."
	cp ../bin/tmux_sync_newznab.sh $HOME/.bin/
    #mkdir -p $INST_NEWZNAB_PATH/misc/custom
else
	echo "Found: tmux_sync_newznab.sh"
fi
if [ ! -L "/usr/local/bin/tmux_sync_newznab.sh" ] ; then
	echo "Symbolic link not found: tmux_sync_newznab.sh. Creating..."
	ln -s $HOME/.bin/tmux_sync_newznab.sh /usr/local/bin/tmux_sync_newznab.sh
else
	echo "Found symbolic link: tmux_sync_newznab.sh"
fi


if [ ! -f "$HOME/.bin/tmux_sync_spotweb.sh" ] ; then
	echo "Not found: tmux_sync_spotweb.sh. Copying..."
	cp ../bin/tmux_sync_spotweb.sh $HOME/.bin/
    #mkdir -p $INST_NEWZNAB_PATH/misc/custom
else
	echo "Found: tmux_sync_spotweb.sh"
fi
if [ ! -L "/usr/local/bin/tmux_sync_spotweb.sh" ] ; then
	echo "Symbolic link not found: tmux_sync_spotweb.sh. Creating..."
	ln -s $HOME/.bin/tmux_sync_spotweb.sh /usr/local/bin/tmux_sync_spotweb.sh
else
	echo "Found symbolic link: tmux_sync_spotweb.sh"
fi

if [ ! -f "$HOME/.bin/tmux_process_monitor.sh" ] ; then
	echo "Not found: tmux_process_monitor.sh. Copying..."
	cp ../bin/tmux_process_monitor.sh $HOME/.bin/
    #mkdir -p $INST_NEWZNAB_PATH/misc/custom
else
	echo "Found: tmux_process_monitor.sh"
fi
if [ ! -L "/usr/local/bin/tmux_process_monitor.sh" ] ; then
	echo "Symbolic link not found: tmux_process_monitor.sh. Creating..."
	ln -s $HOME/.bin/tmux_process_monitor.sh /usr/local/bin/tmux_process_monitor.sh
else
	echo "Found symbolic link: tmux_process_monitor.sh"
fi




#echo "-----------------------------------------------------------"
#echo "| Click on the Cogwheel top-right and enter the following settings:"
#echo "| "
#echo "| Web Interface"
#echo "| -------------------------"
#echo "| Save changes"
#echo "| -------------------------"
#echo "| Download settings"
#echo "-----------------------------------------------------------"
#open http://localhost/newznab/admin/role-edit.php?action=add
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s
#
#if [ -f $DIR/launchctl/com.headphones.headphones.plist ] ; then
#    cp $DIR/launchctl/com.headphones.headphones.plist ~/Library/LaunchAgents/
#else
#fi
#launchctl load ~/Library/LaunchAgents/com.headphones.headphones.plist

echo "#------------------------------------------------------------------------------"
echo "# Installing Custom Scripts - Complete"
echo "#------------------------------------------------------------------------------"
