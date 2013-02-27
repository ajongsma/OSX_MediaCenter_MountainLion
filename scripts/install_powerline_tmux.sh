#!/usr/bin/env bash

## https://github.com/erikw/tmux-powerline
## https://github.com/jonnyboy/newznab-tmux/tree/master/powerline
## https://github.com/jonnyboy/newznab-tmux/blob/master/conf/tmux.conf

#mkdir -p ~/Github
#cd ~/Github/
#git clone https://github.com/Lokaltog/powerline-fonts
##open ~/Github/powerline-fonts/DejaVuSansMono/DejaVu\ Sans\ Mono\ for\ Powerline.otf
#open ~/Github/powerline-fonts/DroidSansMono/Droid\ Sans\ Mono\ for\ Powerline.otf
#open ~/Github/powerline-fonts/Inconsolata/Inconsolata\ for\ Powerline.otf
##open ~/Github/powerline-fonts/Menlo/Menlo\ Regular\ for\ Powerline.otf
##open ~/Github/powerline-fonts/Meslo/Meslo\ LG\ L\ DZ\ Regular\ for\ Powerline.otf
##open ~/Github/powerline-fonts/Meslo/Meslo\ LG\ L\ Regular\ for\ Powerline.otf
##open ~/Github/powerline-fonts/Meslo/Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline.otf
##open ~/Github/powerline-fonts/Meslo/Meslo\ LG\ M\ Regular\ for\ Powerline.otf
##open ~/Github/powerline-fonts/Meslo/Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline.otf
##open ~/Github/powerline-fonts/Meslo/Meslo\ LG\ S\ Regular\ for\ Powerline.otf

[ -d ~/.tmux ] || mkdir -p ~/.tmux

cd /usr/local/share
#git clone https://github.com/Lokaltog/powerline.git
git clone git://github.com/erikw/tmux-powerline.git
#ln -s /usr/local/share/tmux-powerline/powerline.sh /usr/local/bin/tmux-powerline

printf 'Copying default theme to mytheme ...\n'
cd /usr/local/share/tmux-powerline/
cp themes/default.sh themes/mytheme.sh
#subl /usr/local/share/tmux-powerline/themes/mytheme.sh

if [ -e ~/.tmux.conf ] ; then
    cp $DIR/conf/tmux.conf ~/.tmux.conf
else
cat >> /tmp/.tmux.conf <<'EOF'
set -g default-terminal "screen-256color"

#Powerline
set-option -g status on
set-option -g status-interval 2
set-option -g status-utf8 on
set-option -g status-justify "centre"
set-option -g status-left-length 60
set-option -g status-right-length 90
set-option -g status-left "#(/usr/local/share/tmux-powerline/powerline.sh left)"
set-option -g status-right "#(/usr/local/share/tmux-powerline/powerline.sh right)"

#Add Powerline
set-window-option -g window-status-current-format "#[fg=colour235, bg=colour27]⮀#[fg=colour255, bg=colour27] #I ⮁ #W #[fg=colour27, bg=colour235]⮀"
EOF
fi
mv /tmp/.tmux.conf ~/
#subl ~/.tmux.conf

printf '#You can bind a toggle of the visibility for the statusbars by adding the following lines:\n'
printf 'bind C-[ run '/usr/local/share/tmux-powerline/mute_powerline.sh left'      # Mute left statusbar.\n'
printf 'bind C-] run '/usr/local/share/tmux-powerline/mute_powerline.sh right'     # Mute right statusbar.\n'

printf 'Reloading tmux.conf...\n'
tmux source-file ~/.tmux.conf

if [ ! -e ~/.powerlinerc ] ; then
    cp $DIR/conf/tmux-powerlinerc ~/.tmux-powerlinerc
else
	printf 'Creating default configuration file...\n'
	./generate_rc.sh
	mv ~/.tmux-powerlinerc.default ~/.tmux-powerlinerc

	printf 'Change the theme to use and values for segments you want to use:\n'
	subl ~/.tmux-powerlinerc

	printf 'If debugging is required, enable debuggin in file ~/.tmux-powerlinerc\n'
	printf 'For detailed inspection of all executed bash commands, type "bash -x powerline.sh (left|right)"\n'
fi

if [ ! -e ~/.bashrc] ; then
    cp $DIR/conf/bashrc ~/.bashrc
else
	printf 'Add/Change the following in ~/.bashrc\n'
	printf 'export TERM="screen-256color"\n'
	printf 'alias tmux="tmux -2"\n'
	printf 'PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'\n'
	subl ~/.bashrc
fi
source ~/.bashrc

#printf 'set t_Co=256                        " force vim to use 256 colors'
#printf 'let g:solarized_termcolors=256      " use solarized 256 fallback'
#subl ~/.vimrc

##?? source ~/path/to/tmux-colors-solarized/tmuxcolors.conf
##?? https://github.com/seebi/tmux-colors-solarized


