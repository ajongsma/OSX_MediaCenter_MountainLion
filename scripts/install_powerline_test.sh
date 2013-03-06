#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Powerline - TEST"
echo "#------------------------------------------------------------------------------"

source ~/.bashrc

cd ~/Github
git clone https://github.com/Lokaltog/vim-powerline.git

brew install --use-gcc https://raw.github.com/ummels/homebrew/fontforge/Library/Formula/fontforge.rb
brew linkapps

mkdir ~/.fonts
cd ~/.fonts

/usr/local/bin/fontforge -lang=py -script $HOME/Github/vim-powerline/fontpatcher/fontpatcher /Library/Fonts/Verdana.ttf
open Verdana-Powerline.ttf

## ==>>> Suddenly seems to work for all fonts, how odd

##-----------------------------------------------------------------------


### https://powerline.readthedocs.org/en/latest/overview.html#installation
### 
### Bash prompt
###   Add the following line to your bashrc, where {path} is the absolute path to your Powerline installation directory:
###   . {path}/powerline/bindings/bash/powerline.sh
### Zsh prompt
###   Add the following line to your zshrc, where {path} is the absolute path to your Powerline installation directory:
###   . {path}/powerline/bindings/zsh/powerline.zsh
### Tmux statusline
###   Add the following line to your tmux.conf, where {path} is the absolute path to your Powerline installation directory:
###   source '{path}/powerline/bindings/tmux/powerline.conf'
### 
### /Users/Andries/Library/Python/2.7/lib/python/site-packages/powerline/bindings/awesome/powerline.sh
### /Users/Andries/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

#. /Users/Andries/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
#. /Users/Andries/Library/Python/2.7/bin/powerline
#source '/Users/Andries/Library/Python/2.7/lib/python/site-packages/powerline/bindings/tmux/powerline.conf'



#pip install --user git+git://github.com/Lokaltog/powerline

#curl -O http://www.fsd.it/fonts/imm/pr+/img/pragmatapro_screenshots.zip
#cd /usr/local/share
#sudo git clone https://github.com/milkbikis/powerline-shell
#
#sudo ln -s /usr/local/share/powerline-shell.py /usr/local/bin/powerline-shell.py
#
#cat >> ~/.bashrc <<'EOF'
### powerline-shell
#function _update_ps1() {
#   export PS1="$(~/powerline-shell.py $?)"
#}
#
#export PROMPT_COMMAND="_update_ps1"
#EOF
#source ~/.bashrc

#echo "Add to .bashrc:"
#echo "## powerline-shell"
#echo "function _update_ps1() {"
#echo "   export PS1="$(~/powerline-shell.py $?)"""
#echo "}"
#echo ""
#echo "export PROMPT_COMMAND="_update_ps1""
#subl .bashrc

echo "#------------------------------------------------------------------------------"
echo "# Installing Powerline - TEST - Complete"
echo "#------------------------------------------------------------------------------"
