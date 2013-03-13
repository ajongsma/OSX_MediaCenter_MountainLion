#!/bin/bash

## NOTE: this is an OSX launchd wrapper shell script
#  https://gist.github.com/mystix/661713


WRAPPED_NAME="Spotweb Updater"
WRAPPED_PRG="launch_tmux_sync_spotweb.sh"
WRAPPED_BASE=/usr/local/bin

## NOTE: We are inheriting WRAPPED_HOME from launchd.
if [ -z "$WRAPPED_HOME" ] ; then
  WRAPPED_HOME="$WRAPPED_BASE"
fi

if [ ! -d "$WRAPPED_HOME" ]; then
  echo "Error! $WRAPPED_HOME does not exist"
  exit 1
fi

function shutdown() {
    date
    echo "Shutting down $WRAPPED_NAME"
    $WRAPPED_HOME/$WRAPPED_PRG stop
    echo "done."

    # Cleaning up the temporary file
    rm -f $WRAPPED_PID
}
 
date
echo "Starting $WRAPPED_NAME"
WRAPPED_PID=/tmp/$$

. $WRAPPED_HOME/$WRAPPED_PRG start
 
# Allow any signal which would kill process
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

echo "Waiting for `cat $WRAPPED_PID`"
wait `cat $WRAPPED_PID`
