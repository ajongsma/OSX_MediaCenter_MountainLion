#!/usr/bin/env bash

# tmux kill-server
# tmux start-server
# tmux list-sessions

# tmux source-file /absolute/path/to/your/.tmux.conf

# Ctrl-b      : the prefix that sends a keybinding to tmux instead of to the shell or program running in tmux.
# Ctrl-b c    : create a new window.
# Ctrl-b "    : split the window horizontally.
# Ctrl-b %    : split the window vertically.
# Ctrl-b s    : list sessions.
# Ctrl-b d    : detach a session.
# Ctrl-b [    : start copy.
# Ctrl-Space  : start selection.
# Ctrl-w      : copy text from selection.
# Ctrl-b ]    : paste.
# Ctrl-b w    : select from windows.
# Ctrl-b l    : last window.
# Ctrl-b n    : next window.
# Ctrl-b      : command mode.
# Ctrl-b <nr> : Change to tab <nr>

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
## tmux attach-session -d -t Spotweb

export TMUX_APP_PATH="/Users/Spotweb/Sites/spotweb"
export TMUX_SESSION="Spotweb"
export TMUX_POWERLINE="false"

command -v sh >/dev/null 2>&1 || { echo >&2 "Sh required but it's not installed.  Aborting."; exit 1; } && export TMUX_SH=`command -v sh`
command -v tmux >/dev/null 2>&1 || { echo >&2 "Tmux required but it's not installed.  Aborting."; exit 1; } && export TMUX_CMD=`command -v tmux`
command -v nice >/dev/null 2>&1 || { echo >&2 "Nice required but it's not installed.  Aborting."; exit 1; } && export TMUX_NICE=`command -v nice`
command -v php >/dev/null 2>&1 && export PHP=`command -v php` || { export PHP=`command -v php`; }
command -v mysql >/dev/null 2>&1 || { echo >&2 "MySQL required but it's not installed.  Aborting."; exit 1; } && export TMUX_MYSQL=`command -v mysql`

if [[ $TMUX_POWERLINE == "true" ]]; then
  export TMUX_CONF="conf/tmux_powerline.conf"
else
  export TMUX_CONF="conf/tmux_bash.conf"
fi
#TMUX_CONF="~/.tmux.conf"

cd $TMUX_APP_PATH

if $TMUX_CMD -q has-session -t $TMUX_SESSION; then
	$TMUX_CMD attach-session -t $TMUX_SESSION
else
	printf "\033]0; $TMUX_SESSION\007\003\n"
	#$TMUX_CMD -f $TMUX_CONF new-session -d -s $TMUX_SESSION -n $TMUX_SESSION 'cd bin && echo "Monitor Started" && echo "It might take a minute for everything to spinup......" && $NICE -n 19 $PHP monitor.php'

fi

tmux new-session -d -s $TMUX_SESSION -n cycle
tmux select-pane -t 0
tmux send-keys -t $TMUX_SESSION:0 'cd $TMUX_APP_PATH; clear; $NICE -n 19 $TMUX_SH spotweb_cycle.sh' C-m

tmux splitw -v -p 25
tmux select-pane -t 1
tmux send-keys -t $TMUX_SESSION:0 'cd $DIR; $TMUX_SH monitor_process.sh "tmux attach-session -d -t $TMUX_SESSION"' C-m

## Create extra tab
#tmux new-window -t NewzNab:1 -n 'monitor' 'echo "Monitor ..."'

## Attach session
#tmux select-window -t $TMUX_SESSION:0
#tmux attach-session -d -t $TMUX_SESSION

