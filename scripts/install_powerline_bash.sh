#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Bash Powerline"
echo "#------------------------------------------------------------------------------"
### https://github.com/xiaq/powerline-bash

source ~/.bashrc

[ -d ~/.tmux ] || mkdir -p ~/.tmux

cd /usr/local/share
sudo git clone https://github.com/milkbikis/powerline-shell

sudo ln -s /usr/local/share/powerline-shell.py /usr/local/bin/powerline-shell.py

cat >> ~/.bashrc <<'EOF'
## powerline-shell
function _update_ps1() {
   export PS1="$(~/powerline-shell.py $?)"
}

export PROMPT_COMMAND="_update_ps1"
EOF
source ~/.bashrc

#echo "Add to .bashrc:"
#echo "## powerline-shell"
#echo "function _update_ps1() {"
#echo "   export PS1="$(~/powerline-shell.py $?)"""
#echo "}"
#echo ""
#echo "export PROMPT_COMMAND="_update_ps1""
#subl .bashrc

echo "#------------------------------------------------------------------------------"
echo "# Installing Bash Powerline - Complete"
echo "#------------------------------------------------------------------------------"
