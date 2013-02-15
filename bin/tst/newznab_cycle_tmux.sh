#!/bin/sh

export TST_NEWZNAB_PATH="/Users/Newznab/Sites/newznab"

#This script assumes you have used the following 2 guides
# 1) http://www.tiag.me/how-to-backfill-newznab-safely-without-bloating-your-database/
# 2) https://sites.google.com/site/1204nnplus/optional-configurations
#You can still use this script without having followed those guides but will have to edit to suit your application.
#PLEASE NOTE: I used newznab_screen_backfill.sh instead of newznab_screen_local.sh You may need to change this!!!
#Be sure to adjust paths to your install DIR
#If you are not using Sphinx, Comment out the "Shpinx Startup" section
#If you do not want to see Top, NIC stats, or Drive stats then comment out the "Monitoring Windows" section
 
#Sphinx Startup
tmux new-session -d -s NewzNab -n NewzNab
tmux send-keys -tNewzNab:0 'cd $TST_NEWZNAB_PATH/misc/sphinx' C-m
tmux send-keys -tNewzNab:0 './nnindexer.php daemon' C-m
sleep 3

#NewzNab Panes
tmux send-keys -tNewzNab:0 'cd $TST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/' C-m
tmux send-keys -tNewzNab:0 'sh newznab_screen_backfill.sh' C-m
tmux splitw -h -p 50
tmux send-keys -tNewzNab:0 'cd $TST_NEWZNAB_PATH/misc/update_scripts/' C-m
tmux send-keys -tNewzNab:0 'php justpostprocessing.php' C-m
 
#Monitoring Panes
tmux select-pane -t 0
tmux splitw -v -p 50
tmux send-keys -tNewzNab:0 'top' C-m
tmux select-pane -t 2
tmux splitw -v -p 50
tmux send-keys -tNewzNab:0 'iostat -xd sda 1' C-m
tmux splitw -v -p 50
tmux send-keys -tNewzNab:0 'ifstat -S' C-m
 
tmux select-window -tNewzNab:0
tmux attach-session -d -tNewzNab
