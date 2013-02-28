#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Tmux"
echo "#------------------------------------------------------------------------------"

brew install tmux

[ -d ~/.tmux/tmthemes ] || mkdir -p ~/.tmux/tmthemes
[ -d ~/.tmux/segment ] || mkdir -p ~/.tmux/segment

[ -f ~/.tmux/tmux_bash.conf ] || cp -v conf/tmux/tmux_bash.conf ~/.tmux/
[ -f ~/.tmux/tmux.bindings.conf ] || cp -v conf/tmux/tmux.bindings.conf ~/.tmux/
[ -f ~/.tmux/tmux.mouse.conf ] || cp -v conf/tmux/tmux.mouse.conf ~/.tmux/
#[ -f ~/.tmux/tmux.powerline.conf ] || cp -v tmux.powerline.conf ~/.tmux/


echo "#------------------------------------------------------------------------------"
echo "# Install Tmux - Complete"
echo "#------------------------------------------------------------------------------"
