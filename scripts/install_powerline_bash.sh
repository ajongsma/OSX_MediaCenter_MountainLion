#!/usr/bin/env bash

### https://github.com/xiaq/powerline-bash

source ~/.bashrc

cd /usr/local/share
sudo git clone https://github.com/milkbikis/powerline-shell

sudo ln -s /usr/local/share/powerline-shell.py /usr/local/bin/powerline-shell.py

echo "Add to .bashrc:"
echo "function _update_ps1() {"
echo "   export PS1="$(~/powerline-shell.py $?)"""
echo "}

export PROMPT_COMMAND="_update_ps1"
subl .bashrc

