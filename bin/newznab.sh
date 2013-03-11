#!/bin/bash
 
## Convenience script for easily starting/stopping Spotweb on OSX to be placed in /usr/local/bin.

if [ 'start' = "$1" ]; then 
    echo Starting NewzNAB service...
    COMMAND=load
elif [ 'stop' = "$1" ]; then 
    echo Stopping NewzNAB service...
    COMMAND=unload
fi
 
if [ 'restart' = "$1" ]; then
    echo Restarting NewzNAB service...
    sudo launchctl unload -w $HOME/Library/LaunchDaemons/com.tmux.newznab.plist
    sudo launchctl load -w $HOME/Library/LaunchDaemons/com.tmux.newznab.plist
elif [ -n "$COMMAND" ]; then 
    sudo launchctl $COMMAND -w $HOME/Library/LaunchDaemons/com.tmux.newznab.plist
fi
