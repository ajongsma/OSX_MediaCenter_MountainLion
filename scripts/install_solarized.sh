#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Solarized"
echo "#------------------------------------------------------------------------------"

source ~/.bashrc

git clone https://github.com/altercation/solarized.git ~/Github/Solarized

open /Users/Andries/Github/Solarized/osx-terminal.app-colors-solarized/xterm-256color/Solarized\ Light\ xterm-256color.terminal
open /Users/Andries/Github/Solarized/osx-terminal.app-colors-solarized/xterm-256color/Solarized\ Dark\ xterm-256color.terminal

open /Users/Andries/Github/Solarized/iterm2-colors-solarized/Solarized\ Light.itermcolors
open /Users/Andries/Github/Solarized/iterm2-colors-solarized/Solarized\ Dark.itermcolors


echo "#------------------------------------------------------------------------------"
echo "# Installing Solarized - Complete"
echo "#------------------------------------------------------------------------------"
