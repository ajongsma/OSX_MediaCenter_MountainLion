#!/bin/bash

#pref=test_pref
#pid=`pgrep spotweb`

PID_NEWZNAB=`pgrep -f newznab | head -n1`;

[ -z $PID_NEWZNAB ] && $HOME/.bin/tmux_sync_newznab.sh