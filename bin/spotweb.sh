#!/bin/bash
 
## Convenience script for easily starting/stopping Spotweb on OSX to be placed in /usr/local/bin.

if [ 'start' = "$1" ]; then 
    echo Starting Spotweb service...
    COMMAND=load
elif [ 'stop' = "$1" ]; then 
    echo Stopping Spotweb service...
    COMMAND=unload
fi
 
if [ 'restart' = "$1" ]; then
    echo Restarting Spotweb service...
    sudo launchctl unload -w $HOME/Library/LaunchDaemons/com.tmux.spotweb.plist
    sudo launchctl load -w $HOME/Library/LaunchDaemons/com.tmux.spotweb.plist
elif [ -n "$COMMAND" ]; then 
    sudo launchctl $COMMAND -w $HOME/Library/LaunchDaemons/com.tmux.spotweb.plist
fi
