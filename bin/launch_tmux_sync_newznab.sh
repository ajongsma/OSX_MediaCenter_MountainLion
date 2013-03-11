#!/bin/bash

#pref=test_pref
#pid=`pgrep spotweb`

#PATTERN="'/bin/sh /Users/Andries/Github/OSX_NewBox/bin/newznab_cycle.sh\$'"
#pgrep -f $PATTERN
#echo pgrep -f $PATTERN

PID_NEWZNAB=`pgrep -f newznab | head -n1`;

[ -z $PID_NEWZNAB ] && $HOME/.bin/tmux_sync_newznab.sh
