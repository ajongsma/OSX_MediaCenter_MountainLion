#!/bin/bash

## Convenience script for easily start debugging a plist file.

## launchctl list com.tmux.spotweb
## launchctl list com.tmux.spotweb output
## launchctl list | grep spotweb


# Stop service
function stop {
  echo "Stopping $1"
  launchctl unload $1
}

# Start service
function start {
  echo "Starting $1"
  launchctl load -w $1
}

# Restart service
function restart {
  echo "Restarting $1"
  stop
  start
  echo "done"  
}

if [ "$1" == "" ]; then
  echo "Please supply plist file."
  exit 1
else
  echo "Checking plist file $1"
  plutil -lint $1

  echo "Changing launchctl log level to Debug"
  sudo launchctl log level debug

  echo "Restart service"
  restart $1

  echo "Start tailing the system.log"
  osascript -e 'tell app "Terminal"
    do script "tail -f /var/log/system.log"
  end tell'

  echo "Changing launchctl log level to Error"
  sudo launchctl log level error
fi
