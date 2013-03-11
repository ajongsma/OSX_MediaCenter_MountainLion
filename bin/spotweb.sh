#!/bin/bash
 
### Convenience script for easily starting/stopping Spotweb on OSX to be placed in /usr/local/bin.
##
## launchctl list com.tmux.spotweb
## launchctl list com.tmux.spotweb output
## launchctl list | grep spotweb


# Stop a service
function stop {
  echo "Stopping $NAME"
 launchctl unload -w $HOME/Library/LaunchAgents/$PLIST
}

# Starts the service
function start {
  echo "Starting $NAME"
 launchctl load -w $HOME/Library/LaunchAgents/$PLIST
}

# Does a restart
function restart {
  echo "Restarting $NAME"
    stop
    start
  echo "done"  
}

# Tells us if the service is running or not
function status {
  if [ -f $PIDFILE ]; then
    GETPID=`cat $PIDFILE`
    echo "$NAME is running with a PID of $PID_FILE"
  else
    echo "$NAME is not running"
  fi
}

### MAIN
NAME="spotweb"
PLIST="com.tmux.spotweb.plist"
PID_FILE="/tmp/$NAME.pid"

case "$1" in
  start)
    start $NAME $PLIST ;;
  stop)
    stop $NAME $PLIST ;;
  restart)
    restart ;;
  status)
    status $NAME $PLIST ;;
  *)
    echo "Usage : service [ stop | start | restart | status ]"   
esac

