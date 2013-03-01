#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Tmux"
echo "#------------------------------------------------------------------------------"

brew install tmux

[ -d ~/.tmux/conf ] || mkdir -p ~/.tmux/conf
[ -d ~/.tmux/tmthemes ] || mkdir -p ~/.tmux/tmthemes
[ -d ~/.tmux/segment ] || mkdir -p ~/.tmux/segment

[ -f ~/.tmux/conf/tmux_bash.conf ] || cp -v conf/tmux/tmux_bash.conf ~/.tmux/conf/
[ -f ~/.tmux/conf/tmux.bindings.conf ] || cp -v conf/tmux/tmux.bindings.conf ~/.tmux/conf/
[ -f ~/.tmux/conf/tmux.mouse.conf ] || cp -v conf/tmux/tmux.mouse.conf ~/.tmux/conf/
#[ -f ~/.tmux/conf/tmux.powerline.conf ] || cp -v tmux.powerline.conf ~/.tmux/conf/


echo "#------------------------------------------------------------------------------"
echo "# Install Tmux - Complete"
echo "#------------------------------------------------------------------------------"
