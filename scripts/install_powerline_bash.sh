#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Bash Powerline"
echo "#------------------------------------------------------------------------------"
### https://github.com/xiaq/powerline-bash

source ~/.bashrc

[ -d ~/.tmux ] || mkdir -p ~/.tmux/conf
#cp -v conf/tmux/* ~/.tmux
[ -f ~/.tmux/conf/tmux_bash.conf ] || cp -v conf/tmux/tmux_bash.conf ~/.tmux/conf/
[ -f ~/.tmux/conf/tmux.bindings.conf ] || cp -v conf/tmux/tmux.bindings.conf ~/.tmux/conf/
[ -f ~/.tmux/conf/tmux.mouse.conf ] || cp -v conf/tmux/tmux.mouse.conf ~/.tmux/conf/
#[ -f ~/.tmux/conf/tmux.powerline.conf ] || cp -v conf/tmux/tmux.powerline.conf ~/.tmux/conf/
#[ -f ~/.tmux/conf/tmux_powerline.conf ] || cp -v conf/tmux/tmux_powerline.conf ~/.tmux/conf/

cd /usr/local/share
sudo git clone https://github.com/milkbikis/powerline-shell

sudo ln -s /usr/local/share/powerline-shell.py /usr/local/bin/powerline-shell.py

cat >> ~/.bashrc <<'EOF'

## powerline-shell
function _update_ps1() {
   export PS1="$(/usr/local/share/powerline-shell/powerline-shell.py $?)"
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
