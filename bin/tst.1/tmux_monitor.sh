#!/usr/bin/env bash

# tmux kill-server
# tmux start-server
# tmux list-sessions

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

## tmux attach-session -d -t Spotweb

SOURCE="${BASH_SOURCE[0]}"
TMUX_CURRENT_DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$TMUX_CURRENT_DIR/$SOURCE"
  TMUX_CURRENT_DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
TMUX_CURRENT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
unset SOURCE

#TMUX_APP_PATH="/Users/Spotweb/Sites/spotweb"
#TMUX_APP="spotweb_cycle.sh"
TMUX_SESSION="Monitor"
TMUX_SESSION_PANE_1="Spotweb"
TMUX_SESSION_PANE_2="Newznab"
TMUX_POWERLINE="true"

command -v sh >/dev/null 2>&1 || { echo >&2 "Sh required but it's not installed.  Aborting."; exit 1; } && TMUX_SH=`command -v sh`
command -v tmux >/dev/null 2>&1 || { echo >&2 "Tmux required but it's not installed.  Aborting."; exit 1; } && TMUX_CMD=`command -v tmux`
command -v nice >/dev/null 2>&1 || { echo >&2 "Nice required but it's not installed.  Aborting."; exit 1; } && TMUX_NICE=`command -v nice`
command -v php >/dev/null 2>&1 && export PHP=`command -v php` || { PHP=`command -v php`; }
command -v mysql >/dev/null 2>&1 || { echo >&2 "MySQL required but it's not installed.  Aborting."; exit 1; } && TMUX_MYSQL=`command -v mysql`

if [[ $TMUX_POWERLINE == "true" ]]; then
  TMUX_CONF="$HOME/.tmux/conf/tmux_powerline.conf"
else
  TMUX_CONF="$HOME/.tmux/conf/tmux_bash.conf"
fi


#tmux list-sessions
if $TMUX_CMD -q has-session -t $TMUX_SESSION_1; then
	echo "Session found: $TMUX_SESSION"
	$TMUX_CMD attach-session -t $TMUX_SESSION
else
	echo "Session not found: $TMUX_SESSION"

	tmux start-server
	tmux -f $TMUX_CONF new-session -d -s $TMUX_SESSION -n $TMUX_SESSION
	# tmux attach-session -d -t Monitor

	tmux select-pane -t 0
	tmux splitw -h -p 50

	tmux select-pane -t 0
	if $TMUX_CMD -q has-session -t $TMUX_SESSION_PANE_1; then
		echo "Session found: $TMUX_SESSION_PANE_1"
		$TMUX_CMD attach-session -t $TMUX_SESSION_PANE_1
	else
		echo "Session not found: $TMUX_SESSION_PANE_1"
	fi

	tmux select-pane -t 1
	if $TMUX_CMD -q has-session -t $TMUX_SESSION_PANE_2; then
		echo "Session found: $TMUX_SESSION_PANE_2"
		$TMUX_CMD attach-session -t $TMUX_SESSION_PANE_2
	else
		echo "Session not found: $TMUX_SESSION_PANE_2"
	fi

#	#tmux send-keys -t $TMUX_SESSION:0 "cd $TMUX_APP_PATH" C-m
#	#tmux send-keys -t $TMUX_SESSION:0 "clear" C-m
#	#tmux send-keys -t $TMUX_SESSION:0 "$TMUX_NICE -n 19 $TMUX_SH $TMUX_APP" C-m
#
#	tmux splitw -v -p 12
#	tmux select-pane -t 1
#	tmux send-keys -t $TMUX_SESSION:0 "cd $TMUX_CURRENT_DIR" C-m
#	tmux send-keys -t $TMUX_SESSION:0 "$TMUX_SH monitor_process_tmux.sh 'tmux attach-session -d -t $TMUX_SESSION'" C-m
#
#	## Create extra tab
#	#tmux new-window -t NewzNab:1 -n 'monitor' 'echo "Monitor ..."'
#
#	## Attach session
	tmux select-window -t $TMUX_SESSION:0
	tmux select-pane -t 0
	tmux attach-session -d -t $TMUX_SESSION
fi