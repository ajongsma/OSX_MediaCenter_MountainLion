#!/bin/bash

#------------------------------------------------------------------------------
# VARIABLES
#------------------------------------------------------------------------------

# this is required in order be able to build many packages because Xcode4 dropped `ppc` architecture
export ARCHFLAGS='-arch i386 -arch x86_64'

#------------------------------------------------------------------------------
# TESTING USER INPUT
#------------------------------------------------------------------------------

#echo "Please enter the Root password:"
#sudo -v

#------------------------------------------------------------------------------
# Preflight
#------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^darwin ]]; then
  os="Mac"
  app_file="chrome-mac.zip"
  app_path="/Applications"
else
  echo "Linux unsupported (for now)."
  exit 1
fi

# run software update and reboot
#sudo softwareupdate --install --all

# turn on ssh
#sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

#sudo shutdown -r now


#------------------------------------------------------------------------------
# Creating mandatory directories
#------------------------------------------------------------------------------

if [ ! -e /src/ ] ; then
    sudo mkdir -p /src/
    #sudo chown -R `whoami` /src/
else
    echo "Directory /src/         [OK]"
fi

if [ ! -e ~/Github/ ] ; then
    mkdir -p ~/Github/
else
    echo "Directory ~/Github/     [OK]"
fi

#------------------------------------------------------------------------------
# INSTALLATION STARTS HERE
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Install font(s)
#------------------------------------------------------------------------------

#https://github.com/skwp/dotfiles/tree/master/fonts
if [ ! -e /Users/Andries/Library/Fonts/Inconsolata.otf ] ; then
  echo "==> Installing nicer coding font (click 'install' when prompted)"

  font=Inconsolata.otf && \
    curl http://www.levien.com/type/myfonts/$font -o /tmp/$font && \
    open -W -a /Applications/Font\ Book.app /tmp/$font && \
    rm /tmp/$font && \
    unset font
else
    echo "Font: Inconsolata       [OK]"
fi

#------------------------------------------------------------------------------
# Check for installation Xcode
#------------------------------------------------------------------------------
# install xcode via App Store first!
# install the command-line tools as well
# /Applications/Xcode.app/Contents/Developer/usr/bin/

#open http://itunes.apple.com/us/app/xcode/id497799835?mt=12
if [ ! -e /Applications/Xcode.app ] ; then
    open http://itunes.apple.com/us/app/xcode/id497799835?mt=12
  
    echo "Xcode not installed, please install..."
    sleep 15
#    quit
else
    echo "Xcode found               [OK]"
fi

while ( [ ! -e /Applications/Xcode.app ] )
do
    echo "Waiting for Xcode to be installed..."
    sleep 15
done

#------------------------------------------------------------------------------
# Check for Command Line Tools
#------------------------------------------------------------------------------
while ( [ $(which gcc) == "" ] )
do
    echo "Waiting for Command Line Tools to be installed..."
    sleep 15
done

#------------------------------------------------------------------------------
# CHECKING SSH KEY
#------------------------------------------------------------------------------

# Check if an id_rsa key is set; we'll need it for github auth
#if [[ ! -f ~/.ssh/id_rsa ]]; then
#  echo "$(tput setaf 9)"
#	echo "ERROR: You do not have an SSH key set yet. You need one linked to your GitHub account."
#	echo "Ignore this error if have one that is not named id_rsa.$(tput sgr0)"
##	exit 1
#fi

#------------------------------------------------------------------------------
# GitHub - Clone
#------------------------------------------------------------------------------

# Reference info
# https://github.com/roderik/dotfiles
# https://github.com/mathiasbynens/dotfiles

## Other References info
# https://github.com/freshshell/fresh/blob/master/bin/fresh

#cd ~/Github/
#git clone https://github.com/ajongsma/OSX_NewBox.git
if [ -d ~/Github/OSX_NewBox ]; then
  cd ~/Github/OSX_NewBox
  git pull --rebase
  cd -
else
  git clone https://github.com/ajongsma/OSX_NewBox.git ~/Github/OSX_NewBox
fi

#------------------------------------------------------------------------------
# Install scripts
#------------------------------------------------------------------------------
# Install iTerm2
sudo scripts/install_iterm2.sh

# Install Homebrew
#./OSX_NewBox/install_homebrew.sh

# Install Alfred
#./install_alfred.sh

## Install Sublime Text 2
# http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg

#------------------------------------------------------------------------------
# Updating system defaults
#------------------------------------------------------------------------------
#./dotfiles/.osx
