#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Bash Powerline"
echo "#------------------------------------------------------------------------------"
### https://github.com/xiaq/powerline-bash

source ~/.bashrc

[ -d ~/.tmux ] || mkdir -p ~/.tmux
#cp -v conf/tmux/* ~/.tmux
[ -f ~/.tmux/tmux_bash.conf ] || cp -v conf/tmux/tmux_bash.conf ~/.tmux/
[ -f ~/.tmux/tmux_powerline.conf ] || cp -v conf/tmux/tmux_powerline.conf ~/.tmux/
[ -f ~/.tmux/tmux.bindings.conf ] || cp -v conf/tmux/tmux.bindings.conf ~/.tmux/
[ -f ~/.tmux/tmux.mouse.conf ] || cp -v conf/tmux/tmux.mouse.conf ~/.tmux/
[ -f ~/.tmux/tmux.powerline.conf ] || cp -v tmux.powerline.conf ~/.tmux/

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
