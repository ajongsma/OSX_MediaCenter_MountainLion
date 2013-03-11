#!/bin/bash
 
# NOTE: this is an OSX launchd wrapper shell script for Spotweb (to be placed in $HOME/bin)

SPOTWEB_HOME=$HOME
 
function shutdown() {
    date
    echo "Shutting down Spotweb"
    $SPOTWEB_HOME/bin/spotweb.sh stop
}
 
date
echo "Starting Spotweb"
SPOTWEB_PID=/tmp/$$

. $SPOTWEB_HOME/bin/spotweb.sh start
 
# Allow any signal which would kill a process to stop Spotweb
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP
 
echo "Waiting for `cat $SPOTWEB_PID`"
wait `cat $SPOTWEB_PID`

## OLD ---------------------
##!/bin/bash
#
##pref=test_pref
##pid=`pgrep spotweb`
#
#PID_SPOTWEB=`pgrep -f spotweb | head -n1`;
#
#[ -z $PID_SPOTWEB ] && $HOME/.bin/tmux_sync_spotweb.sh
