#!/bin/bash
 
# convenience script for easily starting/stopping tomcat on OSX
# (to be placed in /usr/local/bin. remember to run chmod +x on it)
if [ 'start' = "$1" ]; then 
    echo Starting tomcat service...
    COMMAND=load
elif [ 'stop' = "$1" ]; then 
    echo Stopping tomcat service...
    COMMAND=unload
fi
 
if [ 'restart' = "$1" ]; then
    echo Restarting tomcat service...
    sudo launchctl unload -w /Library/LaunchDaemons/org.apache.tomcat.plist
    sudo launchctl load -w /Library/LaunchDaemons/org.apache.tomcat.plist
elif [ -n "$COMMAND" ]; then 
    sudo launchctl $COMMAND -w /Library/LaunchDaemons/org.apache.tomcat.plist
fi