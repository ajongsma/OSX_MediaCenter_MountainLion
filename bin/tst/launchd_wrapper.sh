#!/bin/bash

## NOTE: this is an OSX launchd wrapper shell script
#  https://gist.github.com/mystix/661713


WRAPPED_NAME="Spotweb"
WRAPPED_PRG="launch_tmux_sync_spotweb.sh"
WRAPPED_ROOT=/usr/local/bin

if [ ! -d "$WRAPPED_ROOT" ]; then
  echo "Error! $WRAPPED_ROOT does not exist"
  exit 1
fi

function shutdown() {
    date
    echo "Shutting down $WRAPPED_NAME"
    $WRAPPED_ROOT/$WRAPPED_PRG stop
    echo "done."

    # Cleaning up the temporary file
    rm -f $WRAPPED_PID
}
 
date
echo "Starting $WRAPPED_NAME Updater"
WRAPPED_PID=/tmp/$$
 
. $WRAPPED_ROOT/$WRAPPED_PRG start
 
# Allow any signal which would kill process
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

echo "Waiting for `cat $WRAPPED_PID`"
wait `cat $WRAPPED_PID`
