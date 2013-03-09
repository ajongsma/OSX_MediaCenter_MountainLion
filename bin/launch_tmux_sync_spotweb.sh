#!/bin/bash

#pref=test_pref
#pid=`pgrep spotweb`

PID_SPOTWEB=`pgrep -f spotweb | head -n1`;

[ -z $PID_SPOTWEB ] && $HOME/.bin/tmux_sync_spotweb.sh