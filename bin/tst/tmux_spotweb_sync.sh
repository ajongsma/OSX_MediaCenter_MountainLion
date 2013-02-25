#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
export DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

## Process COMMAND:
## tmux attach-session -d -t NewzNab

export TMUX_SPOTWEB_PATH="/Users/Spotweb/Sites/spotweb"
export TMUX_SPOTWEB_SESSION="Newznab"
export TMUX_SPOTWEB_POWERLINE="false"

command -v tmux >/dev/null 2>&1 || { echo >&2 "Tmux required but it's not installed.  Aborting."; exit 1; } && export TMUX_SPOTWEB_CMD=`command -v tmux`
command -v mysql >/dev/null 2>&1 || { echo >&2 "MySQL required but it's not installed.  Aborting."; exit 1; } && export TMUX_SPOTWEB_MYSQL=`command -v mysql`
command -v nice >/dev/null 2>&1 || { echo >&2 "Nice required but it's not installed.  Aborting."; exit 1; } && export TMUX_SPOTWEB_NICE=`command -v nice`

## ERROR
#command -v php5 >/dev/null 2>&1 && export PHP=`command -v php5` || { export PHP=`command -v php`; }
##

if [[ $TMUX_SPOTWEB_POWERLINE == "true" ]]; then
  export TMUX_SPOTWEB_CONF="conf/tmux_spotweb_powerline.conf"
else
  export TMUX_SPOTWEB_CONF="conf/tmux_spotweb_bash.conf"
fi
#TMUX_SPOTWEB_CONF="~/.tmux.conf"

cd $TMUX_SPOTWEB_PATH

#tmux start-server

if $TMUX_SPOTWEB_CMD -q has-session -t $TMUX_SPOTWEB_SESSION; then
	$TMUX_SPOTWEB_CMD attach-session -t $TMUX_SPOTWEB_SESSION
else
	printf "\033]0; $TMUX_SPOTWEB_SESSION\007\003\n"
	#$TMUX_SPOTWEB_CMD -f $TMUX_SPOTWEB_CONF new-session -d -s $TMUX_SPOTWEB_SESSION -n $TMUX_SPOTWEB_SESSION 'cd bin && echo "Monitor Started" && echo "It might take a minute for everything to spinup......" && $NICE -n 19 $PHP monitor.php'

fi

tmux new-session -d -s NewzNab -n cycle

tmux splitw -v -p 25
tmux select-pane -t 1
tmux send-keys -tNewzNab:0 'clear; ifstat -S' C-m
tmux splitw -v -p 50
tmux select-pane -t 2
#tmux send-keys -tNewzNab:0 'iostat -K -w 5' C-m
tmux send-keys -tNewzNab:0 'cd $DIR; sh monitor_process.sh "tmux attach-session -d -t NewzNab"' C-m

#tmux new-window -t NewzNab:1 -n monitor

tmux select-pane -t 0
#tmux send-keys -t NewzNab:0 "cd $TMUX_SPOTWEB_PATH" C-m
tmux send-keys -t NewzNab:0 'cd $TMUX_SPOTWEB_PATH; ./spotweb_cycle.sh' C-m

tmux select-window -t NewzNab:0
tmux attach-session -d -t NewzNab

#tmux select-window -t NewzNab:0
#tmux attach-session -d -t NewzNab

## tmux new-session -d -s NewzNab
##
## tmux new-window -t NewzNab:1 -n 'Server1' 'echo "Server1"'
## tmux new-window -t NewzNab:2 -n 'Server2' 'echo "Server2"'
## tmux new-window -t NewzNab:3 -n 'Server3' 'echo "Server3"'
## tmux new-window -t NewzNab:4 -n 'Server4' 'echo "Server4"'
## tmux new-window -t NewzNab:5 -n 'Server5' 'echo "Server5"'
##
## tmux select-window -t NewzNab:1
## tmux -2 attach-session -t NewzNab
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
## #Sphinx Startup
## tmux new-session -d -s NewzNab -n NewzNab
## tmux send-keys -tNewzNab:0 'cd $TST_NEWZNAB_PATH/misc/sphinx' C-m
## tmux send-keys -tNewzNab:0 './nnindexer.php daemon' C-m
## sleep 3
##
## #NewzNab Panes
## tmux send-keys -tNewzNab:0 'cd $TST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/' C-m
## tmux send-keys -tNewzNab:0 'sh newznab_local.sh' C-m
## tmux splitw -h -p 50
## #tmux send-keys -tNewzNab:0 'cd $TST_NEWZNAB_PATH/misc/update_scripts/' C-m
## #tmux send-keys -tNewzNab:0 'php justpostprocessing.php' C-m
## tmux send-keys -tNewzNab:0 'cd $TST_SPOTWEB_PATH' C-m
## tmux send-keys -tNewzNab:0 'sh spotweb_cycle.sh' C-m
##

