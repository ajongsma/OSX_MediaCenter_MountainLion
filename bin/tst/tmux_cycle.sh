#!/bin/sh

export TST_NEWZNAB_PATH="/Users/Newznab/Sites/newznab"
export TST_SPOTWEB_PATH="/Users/Spotweb/Sites/spotweb"

# This script assumes you have used the following 2 guides
#  1) http://www.tiag.me/how-to-backfill-newznab-safely-without-bloating-your-database/
#  2) https://sites.google.com/site/1204nnplus/optional-configurations
# You can still use this script without having followed those guides but will have to edit to suit your application.
# PLEASE NOTE: I used newznab_screen_backfill.sh instead of newznab_screen_local.sh You may need to change this!!!
# Be sure to adjust paths to your install DIR
# If you are not using Sphinx, Comment out the "Shpinx Startup" section
# If you do not want to see Top, NIC stats, or Drive stats then comment out the "Monitoring Windows" section

# http://www.jeffstory.org/wordpress/?p=132

cd $TST_SPOTWEB_PATH

tmux start-server
tmux new-session -d -s NewzNab

#tmux new-window -t NewzNab:1 -n test
#tmux new-window -t NewzNab:2 -n solr
#tmux new-window -t NewzNab:3 -n docs
#tmux new-window -t NewzNab:4 -n runserver
#tmux new-window -t NewzNab:5 -n utility

tmux send-keys -t NewzNab:0 'cd $TST_SPOTWEB_PATH; clear' C-m
tmux send-keys -t NewzNab:0 './spotweb_cycle.sh' C-m
#tmux send-keys -t NewzNab:1 'cd ~/Code/Python/django-haystack/tests/; export PYTHONPATH=`pwd`; clear' C-m
#tmux send-keys -t NewzNab:2 'cd ~/Code/Python/all_django_projects/ds_recipe_testbed/my-solr; clear; ./run-solr.sh' C-m
#tmux send-keys -t NewzNab:3 'cd ~/Code/Python/django-haystack/docs; clear' C-m
#tmux send-keys -t NewzNab:4 'cd ~/Code/Python/all_django_projects/ds_recipe_testbed; clear; ./manage.py runserver' C-m
#tmux send-keys -t NewzNab:5 'cd ~/Code/Python/all_django_projects/ds_recipe_testbed; clear' C-m

tmux select-window -t NewzNab:0
tmux attach-session -d -t NewzNab

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
## #Monitoring Panes
## tmux select-pane -t 0
## tmux splitw -v -p 50
## tmux send-keys -tNewzNab:0 'top' C-m
## tmux select-pane -t 2
## tmux splitw -v -p 50
## #tmux send-keys -tNewzNab:0 'iostat -xd sda 1' C-m
## tmux send-keys -tNewzNab:0 'iostat -K -w 5' C-m
## tmux splitw -v -p 50
## tmux send-keys -tNewzNab:0 'ifstat -S' C-m
##
## tmux select-window -tNewzNab:0
## tmux attach-session -d -tNewzNab
