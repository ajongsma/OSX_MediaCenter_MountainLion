#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [ -L config.sh ]; then
  rm config.sh
fi
if [ ! -f config.sh ]; then
  clear
  echo "No config.sh found. Creating file, and please edit the required values"
  cp config.sh.default config.sh
  vi config.sh
fi

source config.sh

if [[ $AGREED == "no" ]]; then
  echo "Please edit the config.sh file"
  exit
fi

## ----------------------------------------------------------------------------
## -= Used git's =-
## Postprocessing scripts:
## git clone https://github.com/clinton-hall/nzbToMedia
## https://github.com/jonnyboy/newznab

## ?? https://github.com/roderik/dotfiles
## ?? https://github.com/mathiasbynens/dotfiles
## ----------------------------------------------------------------------------

BOLD=$(tput bold)
BLACK=$(tput setaf 0) #   0  Black
RED=$(tput setaf 1)  #  1   Red
GREEN=$(tput setaf 2)  #    2   Green
YELLOW=$(tput setaf 3)  #   3   Yellow
BLUE=$(tput setaf 4)  #     4   Blue
MAGENTA=$(tput setaf 5)  #  5   Magenta
CYAN=$(tput setaf 6)  #     6   Cyan
WHITE=$(tput setaf 7)  #    7   White
RESET=$(tput sgr0)
col=40

##-----------------------------------------------------------------------------
## Check OS
##-----------------------------------------------------------------------------
if [[ "$OSTYPE" =~ ^darwin ]]; then
  OS="Mac"
  APP_PATH="/Applications"
  printf 'OS X Detected\n' "$GREEN" $col '[OK]' "$RESET"
else
  printf 'Linux unsupported.\n' "$RED" $col '[FAIL]' "$RESET"
  exit 1
fi

#------------------------------------------------------------------------------
# Keep-alive: update existing sudo time stamp until finished
#------------------------------------------------------------------------------
# Ask for the administrator password upfront
echo -e "Please enter root password"
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#------------------------------------------------------------------------------
# Checking if system is up-to-date
#------------------------------------------------------------------------------
## Run software update and reboot
if [[ $INST_OSX_UPDATES == "true" ]]; then
    sudo softwareupdate --list
    sudo softwareupdate --install --all
fi

#------------------------------------------------------------------------------
# Dotfiles
#------------------------------------------------------------------------------
## http://noiseandheat.com/blog/2011/12/os-x-lion-terminal-colours/

if [ ! -f ~/.bash_profile ] ; then
    echo "Creating default .bash_profile..."
    cp conf/bash_profile ~/.bash_profile
else
    echo "File ~/.bash_profile found, please add the following manually..."
    echo "# Tell ls to be colourful"
    echo "export CLICOLOR=1"
    echo ""
    echo "# Tell grep to highlight matches"
    echo "export GREP_OPTIONS='--color=auto'"
    echo " --- press any key to continue ---"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    nano ~/.bash_profile
fi
source ~/.bash_profile

#------------------------------------------------------------------------------
# Show the ~/Library folder
#------------------------------------------------------------------------------
chflags nohidden ~/Library


#------------------------------------------------------------------------------
# Checking existence directories
#------------------------------------------------------------------------------
if [ ! -d ~/Sites/ ] ; then
    printf 'Creating directory ~/Sites…\n' "YELLOW" $col '[WAIT]' "$RESET"
    mkdir -p ~/Sites/
else
    printf 'Directory ~/Sites/ found\n' "$GREEN" $col '[OK]' "$RESET"
fi

if [ ! -d ~/Github/ ] ; then
    printf 'Creating directory ~/Github…\n' "YELLOW" $col '[WAIT]' "$RESET"
    mkdir -p ~/Github/
else
    printf 'Directory ~/Github/ found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for installation Xcode
#------------------------------------------------------------------------------
if [ ! -e /Applications/Xcode.app ] ; then
    printf 'Xcode not installed, please install..\n' "$RED" $col '[FAIL]' "$RESET"

    open http://itunes.apple.com/nl/app/xcode/id497799835?mt=12
    while ( [ ! -e /Applications/Xcode.app ] )
    do
        printf 'Waiting for Xcode to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
else
    printf 'Xcode found' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for Command Line Tools via GCC check
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/gcc ] ; then
    printf 'GCC not installed, please Command Line tools..\n' "$RED" $col '[FAIL]' "$RESET"
    open https://developer.apple.com/downloads/index.action#
    while ( [ ! -e /usr/bin/gcc ] )
    do
        printf 'Waiting for GCC to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    printf 'GCC found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for XQuartz
#------------------------------------------------------------------------------
if [ ! -d /opt/X11/ ] ; then
    printf 'XQuartz not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    open http://xquartz.macosforge.org/landing/
    while ( [ ! -d /opt/X11/ ] )
    do
        printf 'Waiting for XQuartz to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done

    #echo -e "${BLUE} ---      Restart needed       --- ${RESET}"
    #echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    #read -n 1 -s
    sudo shutdown -r +1 "Server is rebooting in 1 minute..."
else
    printf 'XQuartz found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for Java
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/java ] ; then
    printf 'Java not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    while ( [ ! -e /usr/bin/java ] )
    do
        printf 'Waiting for Java to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    printf 'Java found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for OS X Server 2.0
#------------------------------------------------------------------------------
if [ ! -e /Applications/Server.app ] ; then
    printf 'OS X Server not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    open https://itunes.apple.com/nl/app/os-x-server/id537441259?mt=12
    while ( [ ! -e /Applications/Server.app ] )
    do
        printf 'Waiting for OS X Server to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
    open /Applications/Server.app
    printf 'Please enable:\n' "BLUE" $col '[WAIT]' "$RESET"
    printf ' * Websites…\n' "BLUE" $col '[WAIT]' "$RESET"
    printf ' * PHP Web Applications…\n' "BLUE" $col '[WAIT]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
else
    printf 'OS X Server found\n' "$GREEN" $col '[OK]' "$RESET"
fi

SERVICE='httpd'
if ps ax | grep -v grep | grep $SERVICE > /dev/null ; then
    printf $SERVICE' is running\n' "$GREEN" $col '[OK]' "$NORMAL"
else
    printf $SERVICE' is not running\n' "$RED" $col '[FAIL]' "$NORMAL"
fi

#------------------------------------------------------------------------------
# Copy original libphp5 file
#------------------------------------------------------------------------------
#sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
if [ ! -e /usr/libexec/apache2/libphp5.so.org ] ; then
    printf 'Backup file libphp5.org not found, copying file…\n' "YELLOW" $col '[WAIT]' "$RESET"
    sudo cp /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
    if [ -e /usr/libexec/apache2/libphp5.so.org ] ; then
        printf 'Backup file libphp5.org found\n' "YELLOW" $col '[OK]' "$RESET"
    else
        echo "No file libphp5 found                             [ERR]"
        printf 'No backup of file libphp5.so found\n' "$RED" $col '[FAIL]' "$NORMAL"
    fi
else
    printf 'Backup file libphp5.org found\n' "YELLOW" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for iTerm 2
#------------------------------------------------------------------------------
if [[ $INST_ITERM2 == "true" ]]; then
    if [ ! -e /Applications/iTerm.app ] ; then
        printf 'iTerm not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
        open http://www.iterm2.com
        while ( [ ! -e /Applications/iTerm.app ] )
        do
            printf 'Waiting for iTerm to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
        open /Applications/iTerm.app
    else
        printf 'iTerm found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for Sublime Text
#------------------------------------------------------------------------------
if [[ $INST_SUBLIMETEXT == "true" ]]; then
    if [ ! -e /Applications/Sublime\ Text\ 2.app ] ; then
        printf 'Sublime Text not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
        open http://www.sublimetext.com
        while ( [ ! -e /Applications/Sublime\ Text\ 2.app ] )
        do
            printf 'Waiting for Sublime Text to be installed...\n' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
        open /Applications/Sublime\ Text\ 2.app
    else
        printf 'Sublime Text found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
    if [ ! -e /usr/local/bin/subl ] ; then
        printf 'Symbolic link to Sublime Text not found, creating...\n' "$RED" $col '[FAIL]' "$RESET"
        if [ ! -d /usr/local/bin ] ; then
            sudo mkdir -p /usr/local/bin/ 
        fi
        sudo ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
    else
        printf 'Sublime Text link found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for Xlog
#------------------------------------------------------------------------------
#https://itunes.apple.com/nl/app/xlog/id430304898?l=en&mt=12
if [[ $INST_XLOG == "true" ]]; then
    if [ ! -e /Applications/Xlog.app ] ; then
        printf 'Xlog not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
        open https://itunes.apple.com/us/app/xlog/id430304898?mt=12&ls=1
        while ( [ ! -e /Applications/Xlog.app ] )
        do
            printf 'Waiting for Xlog to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
        open /Applications/Xlog.app
    else
        printf 'Xlog found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for GitHub for Mac
#------------------------------------------------------------------------------
if [[ $INST_MACGITHUB == "true" ]]; then
    if [ ! -e /Applications/GitHub.app ] ; then
        printf 'Github not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
        open http://mac.github.com
        while ( [ ! -e /Applications/GitHub.app ] )
        do
            printf 'Waiting for Github to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
        #open /Applications/GitHub.app
    else
        printf 'GitHub found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for Dropbox
#------------------------------------------------------------------------------
if [[ $INST_DROPBOX == "true" ]]; then
    if [ ! -d /Library/DropboxHelperTools ] ; then
        printf 'Dropbox not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
        open https://www.dropbox.com/download?plat=mac
        while ( [ ! -d /Library/DropboxHelperTools ] )
        do
            printf 'Waiting for Dropbox to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
        #open /Applications/GitHub.app
    else
        printf 'Dropbox found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

##------------------------------------------------------------------------------
## Install HomeBrew
##------------------------------------------------------------------------------
## This will install:
## /usr/local/bin/brew
## /usr/local/Library/...
## /usr/local/share/man/man1/brew.1
## Consider amending your PATH so that /usr/local/bin occurs before /usr/bin in your PATH.
## Don’t forget to add /usr/local/Cellar/coreutils/8.20/libexec/gnubin to $PATH

if [ ! -e /usr/local/bin/brew ] ; then
    printf 'HomeBrew not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_brew.sh"
    while ( [ ! -e /usr/local/bin/brew ] )
    do
        printf 'Waiting for HomeBrew to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
    #open /Applications/GitHub.app
else
    printf 'HomeBrew found\n' "$GREEN" $col '[OK]' "$RESET"
fi

##------------------------------------------------------------------------------
## Install several tools via Brew
##------------------------------------------------------------------------------
### Consider amending your PATH so that /usr/local/bin occurs before /usr/bin in your PATH.

#/usr/local/bin/
brew tap homebrew/dupes
brew install apple-gcc42
brew install gnu-sed
brew install coreutils
brew install autoconf
brew install automake
brew install findutils
brew install bash
brew install wget
brew install tmux

echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
echo "# homebrew"
echo "PATH=/usr/local/bin:/usr/local/sbin:$PATH"
echo "# GNU coreutils"
echo "PATH=/opt/local/libexec/gnubin/:$PATH"

if [ ! -f ~/.bashrc ] ; then
    echo "Copying default .bashrc..."
    cp conf/bashrc ~/.bashrc
else
    echo "File ~/.bashrc found, please add the following manually..."
    echo "# Tell ls to be colourful"
    echo "export CLICOLOR=1"
    echo ""
    echo "# Tell grep to highlight matches"
    echo "export GREP_OPTIONS='--color=auto'"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    nano ~/.bashrc
fi
source ~/.bashrc

##------------------------------------------------------------------------------
## Install MySQL
##------------------------------------------------------------------------------
if [ ! -e /usr/local/bin/mysql ] ; then
    printf 'MySQL not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_mysql.sh"
else
    printf 'MySQL found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install MySQL Workbench
#------------------------------------------------------------------------------
if [[ $INST_MYSQL_WORKBENCH == "true" ]]; then
    if [ ! -e /Applications/MySQLWorkbench.app ] ; then
        #echo "MySQL Workbench not installed, please install..."
        printf 'MySQL Workbench not installed, please install...' "$RED" $col '[FAIL]' "$RESET"
        open http://dev.mysql.com/downloads/workbench/
        while ( [ ! -e /Applications/MySQLWorkbench.app ] )
        do
            #echo "Waiting for pgAdmin to be installed..."
            printf 'Waiting for MySQL Workbench to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
        open /Applications/MySQLWorkbench.app
    else
        printf 'MySQL Workbench found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for PostgreSQL
#------------------------------------------------------------------------------
if [ ! -d /usr/local/var/postgres ] ; then
    printf 'PostgreSQL not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_postgresql.sh"
else
    printf 'PostgreSQL found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install pgAdmin (http://www.pgadmin.org/download/macosx.php)
#------------------------------------------------------------------------------
if [[ $INST_PGADMIN == "true" ]]; then
    if [ ! -e /Applications/pgAdmin3.app ] ; then
        printf 'pgAdmin not installed, please install...\n' "$RED" $col '[FAIL]' "$RESET"
        open http://www.pgadmin.org/download/macosx.php
        while ( [ ! -e /Applications/pgAdmin3.app ] )
        do
            printf 'Waiting for pgAdmin to be installed...\n' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
    else
        printf 'pgAdmin found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Install for InductionApp (http://inductionapp.com)
#------------------------------------------------------------------------------
if [[ $INST_INDUCTIONAPP == "true" ]]; then
    if [ ! -e /Applications/Induction.app ] ; then
        printf 'Induction not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
        printf 'Induction is in testing phase, uninstall if not needed\n' "$BLUE" $col '[FAIL]' "$RESET"
        open http://inductionapp.com
        while ( [ ! -e /Applications/Induction.app ] )
        do
            printf 'Waiting for Induction to be installed…\n' "YELLOW" $col '[WAIT]' "$RESET"
            sleep 15
        done
        open /Applications/Induction.app
    else
        printf 'Induction found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

##------------------------------------------------------------------------------
## Install PHP 5.4
##------------------------------------------------------------------------------

if [ ! -d /usr/local/etc/php/5.4 ] ; then
    printf 'PHP 5.4 not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_php54.sh"
else
    printf 'PHP 5.4 found\n' "$GREEN" $col '[OK]' "$RESET"
fi

##------------------------------------------------------------------------------
## Install Python
##------------------------------------------------------------------------------
if [ ! -e /usr/bin/python ] ; then
    printf 'Python not installed, please install…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_python.sh"
else
    printf 'Python found\n' "$GREEN" $col '[OK]' "$RESET"
fi

##------------------------------------------------------------------------------
## Install PEAR
##------------------------------------------------------------------------------
if [ ! -e /usr/local/share/pear/bin/pear ] ; then
    printf 'Pear not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_pear.sh"
else
    printf 'Pear found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install Sphinx
#------------------------------------------------------------------------------
if [ ! -e /usr/local/bin/searchd ] ; then
    printf 'Sphinx not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sphinx.sh"
else
    printf 'local found\n' "$GREEN" $col '[OK]' "$RESET"
fi

##------------------------------------------------------------------------------
## Install Powerline
##------------------------------------------------------------------------------
if [ ! -d /usr/local/share/tmux-powerline ] ; then
    printf 'Powerline not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_powerline_tmux.sh"
else
    printf 'Powerline found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install NewzNAB
#------------------------------------------------------------------------------
## http://mar2zz.tweakblogs.net/blog/6947/newznab.html#more

if [ ! -d /Users/Newznab/Sites/newznab ] ; then
    printf 'NewzNAB not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_newznab.sh"
else
    printf 'NewzNAB found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Installing additional NewzNAB themes
#------------------------------------------------------------------------------
for another_newznab_theme in \
    $INST_NEWZNAB_PATH/www/templates/simple \
    $INST_NEWZNAB_PATH/www/templates/bootstrapped \
    $INST_NEWZNAB_PATH/www/templates/carbon \
    $INST_NEWZNAB_PATH/www/templates/dusplic
do
    [[ -e $another_newznab_theme ]] && echo "Found theme: $another_newznab_theme" && [[ $INST_NEWZNAB_THEMES != "false" ]] && export INST_NEWZNAB_THEMES="true" || export INST_NEWZNAB_THEMES="true"
done

if [[ $INST_NEWZNAB_THEMES == "true" ]]; then
    printf 'NewzNAB thems not all installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_newznab_themes.sh"
else
    printf 'NewzNAB themes found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Configure Sphinx for NewzNAB
#------------------------------------------------------------------------------
if [ ! -f $INST_NEWZNAB_PATH/db/sphinxdata/sphinx.conf ] ; then
    printf 'NewzNAB Sphinx config found, installing...\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_newznab_sphinx.sh"
else
    printf 'NewzNAB Sphinx config found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install NewzNAB - jonnyboy/newznab-tmux
#------------------------------------------------------------------------------
if [ ! -d $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux ] ; then
    printf 'NewzNAB jonnyboy Tmux not found, installing...\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_newznab_tmux.sh"
else
    printf 'NewzNAB jonnyboy Tmux scripts found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install NewzNAB - Custom Scripts
#------------------------------------------------------------------------------
if [ ! -d $INST_NEWZNAB_PATH/misc/custom ] ; then
    printf 'NewzNAB Custom Scripts not found, installing...\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_newznab_script_custom.sh"
else
    printf 'NewzNAB Custom Scripts found\n' "$GREEN" $col '[OK]' "$RESET"
fi

## open -a iTerm.app $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/newznab_local.sh

osascript -e 'tell app "Terminal"
    do script "$INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/newznab_local.sh"
end tell'

#------------------------------------------------------------------------------
# Install Spotweb
#------------------------------------------------------------------------------
if [ ! -d /Users/Newznab/Sites/spotweb ] ; then
    printf 'Spotweb not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_spotweb.sh"
else
    printf 'Spotweb found\n' "$GREEN" $col '[OK]' "$RESET"
fi

osascript -e 'tell app "Terminal"
    do script "php $INST_SPOTWEB_PATH/retrieve.php"
end tell'

#------------------------------------------------------------------------------
# Install SABnzbd+
#------------------------------------------------------------------------------
if [ ! -e /Applications/SABnzbd.app ] ; then
    printf 'SABnzbd not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sabnzbd.sh"
    while ( [ ! -e /Applications/SABnzbd.app ] )
    do
        echo "Waiting for SABnzbd to be installed..."
        sleep 15
    done
else
    printf 'SABnzbd found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install SABnzbd+ - nzbToMedia
#------------------------------------------------------------------------------
if [[ ! -a ~/Library/Application\ Support/SABnzbd/scripts/*.sh ]]; then
    printf 'SABnzbd nzbToMedia not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sabnzbd_nzbtomedia.sh"
    while ( [ ! -a ~/Library/Application\ Support/SABnzbd/scripts/*.sh ] )
    do
        echo "Waiting for SABnzbd+ nzbToMediato be installed..."
        sleep 15
    done
else
    printf 'SABnzbd+ nzbToMedia found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install Cheetah
#------------------------------------------------------------------------------
if [ ! -e /usr/local/bin/cheetah ] ; then
    printf 'SABnzbd not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_cheetah.sh"
    while ( [ ! -e /usr/local/bin/cheetah ] )
    do
        echo "Waiting for Cheetah to be installed..."
        sleep 15
    done
else
    printf 'Cheetah found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install Sick-Beard
#------------------------------------------------------------------------------
if [ ! -d /Applications/Sick-Beard ] ; then
    printf 'Sick-Beard not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sickbeard"
    while ( [ ! -d /Applications/Sick-Beard ] )
    do
        echo "Waiting for Sick-Beard to be installed..."
        sleep 15
    done
else
    printf 'Sick-Beard found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring Sickbeard for SABnzbd - nzbToMedia"
#------------------------------------------------------------------------------"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_sickbeard_nzbtomedia.sh"

source "$DIR/scripts/install_sickbeard_nzbtomedia.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'Sick-Beard: SABnzbd - nzbToMedia not installed\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sickbeard_nzbtomedia.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'Sick-Beard: SABnzbd - nzbToMedia configured\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring SABnzbd for Sickbeard - post-processing"
#------------------------------------------------------------------------------"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_sabnzbd_sickbeard.sh"

source "$DIR/scripts/install_sabnzbd_sickbeard.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'Configuring SABnzbd for Sickbeard - post-processing not configured\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sabnzbd_sickbeard.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'Configuring SABnzbd for Sickbeard - post-processing - Completed\n' "$GREEN" $col '[OK]' "$RESET"
fi

#==============================================================================
#=== FORCED EXIT DUE TO TESTING ===============================================
exit
#==============================================================================

#------------------------------------------------------------------------------
# Install CouchPotato
#------------------------------------------------------------------------------
if [ ! -e /Applications/CouchPotato.app ] ; then
    printf 'CouchPotato not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_couchpotato.sh"
    while ( [ ! -e /Applications/CouchPotato.app ] )
    do
        echo "Waiting for CouchPotato to be installed..."
        sleep 15
    done
else
    printf 'CouchPotato found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring CouchPotato for SABnzbd - nzbToMedia"
#------------------------------------------------------------------------------"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_couchpotato_nzbtomedia.sh"

source "$DIR/scripts/install_couchpotato_nzbtomedia.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'CouchPotato: SABnzbd - nzbToMedia not installed\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_couchpotato_nzbtomedia.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'CouchPotato: SABnzbd - nzbToMedia configured\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring SABnzbd for CouchPotato - post-processing"
#------------------------------------------------------------------------------"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_sabnzbd_couchpotato.sh"

source "$DIR/scripts/install_sabnzbd_couchpotato.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'Configuring SABnzbd for CouchPotato - post-processing not configured\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sabnzbd_couchpotato.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'Configuring SABnzbd for CouchPotato - post-processing - Completed\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install Auto-Sub
#------------------------------------------------------------------------------
if [ ! -e /Applications/auto-sub.app ] ; then
    printf 'Auto-Sub not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_autosub.sh"
    while ( [ ! -e /Applications/auto-sub.app ] )
    do
        echo "Waiting for Auto-Sub to be installed..."
        sleep 15
    done
else
    printf 'Auto-Sub found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install NewzDash
#------------------------------------------------------------------------------
## https://github.com/tssgery/newzdash

##?? NewzDash
##?? ensure that the php5-svn module is installed, on ubuntu/debian you can install with 'sudo apt-get install php5-svn'.
##?? NewzDash will function without this but you will not see version information.

sudo mkdir -p /Users/Newzdash/Sites/newzdash/

#git clone https://github.com/mrkipling/maraschino.git
#git clone git@github.com:tssgery/newzdash.git /Users/Newzdash/Sites/
sudo git clone https://github.com/tssgery/newzdash.git /Users/Newzdash/Sites/newzdash
sudo chown -R `whoami`:staff /Users/Newzdash/Sites/newzdash
touch /Users/Newzdash/Sites/newzdash config.php
chmod 777 /Users/Newzdash/Sites/newzdash config.php

sudo ln -s /Users/Newzdash/Sites/newzdash /Library/Server/Web/Data/Sites/Default/newzdash

echo "-----------------------------------------------------------"
echo "| Configuration:"
echo "| NewzNab Directory             : $INST_NEWZNAB_PATH"
echo "| NewzNab URL                   : http://localhost/newznab"
echo "| --------------------"
echo "| Save changes"
open http://localhost/newzdash




#------------------------------------------------------------------------------
# Install Maraschino
#------------------------------------------------------------------------------
cd /Applications
git clone https://github.com/mrkipling/maraschino.git
cd maraschino
sudo python /Applications/maraschino/Maraschino.py

open http://localhost:7000




#------------------------------------------------------------------------------
# Checking system directories
#------------------------------------------------------------------------------
#if [ ! -e /var/log/devicemgr/ ] ; then
#    echo "Creating directory: Sites"
#    sudo mkdir -p /var/log/devicemgr/
#else
#    echo "Directory /var/log/devicemgr/                    [OK]"
#fi

#------------------------------------------------------------------------------
# Colourize terminal
#------------------------------------------------------------------------------
http://blog.likewise.org/2012/04/how-to-set-up-solarized-color-scheme.html
if [ ! -e ~/.bash_profile ] ; then
    echo "Creating default .bash_profile..."
cat >> ~/.bash_profile <<'EOF'
# Tell ls to be colourful
export CLICOLOR=1

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'
EOF
else
    echo ".bash_profile found, please add the following:"

    echo "# Tell ls to be colourful"
    echo "export CLICOLOR=1"

    echo "# Tell grep to highlight matches"
    echo "export GREP_OPTIONS='--color=auto'"
    subl ~/.bash_profile
fi

#------------------------------------------------------------------------------
# Install fonts
#------------------------------------------------------------------------------
#cd ~/Downloads
#wget http://www.levien.com/type/myfonts/Inconsolata.otf
#open Inconsolata.otf
#wget https://dl.dropbox.com/u/4073777/Inconsolata-Powerline.otf
#open Inconsolata-Powerline.otf

#------------------------------------------------------------------------------
# Git config
#------------------------------------------------------------------------------

## git config
# ?? Add a git alias for pretty logs from http://www.jukie.net/bart/blog/pimping-out-git-log
# ?? git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# color everything
# ?? git config --global color.ui true
git config --global user.name "$GIT_FULL_NAME"
git config --global user.email "$GIT_EMAIL"

git config -l | grep user.name
git config -l | grep user.email

## TESTING
#if [ git config -l | grep user.name ] != $GIT_FULL_NAME ; then
#    echo "diff"
#else
#    echo "OK"
#fi


#------------------------------------------------------------------------------
# Set computer name (as done via System Preferences → Sharing)
#------------------------------------------------------------------------------
# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName "$COMPUTER_NAME"
#sudo scutil --set HostName "$COMPUTER_NAME"
#sudo scutil --set LocalHostName "$COMPUTER_NAME"
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

#### ??? REALLY NEEDED ??? ######
##------------------------------------------------------------------------------
## Install Bash Completion
##------------------------------------------------------------------------------
#brew install bash-completion
#
##Add the following lines to your ~/.bash_profile:
##  if [ -f $(brew --prefix)/etc/bash_completion ]; then
##    . $(brew --prefix)/etc/bash_completion
##  fi
#
#sudo ln -s /usr/local/Library/Contributions/brew_bash_completion.sh /usr/local/etc/bash_completion.d
#
##subl ~/.bash_profile
#if [ -e ~/.bash_profile ] ; then
#    echo "File .bash_profile found, please add the following manually:"
#    echo "if [ -f 'brew --prefix'/etc/bash_completion ]; then"
#    echo     "    . 'brew --prefix'/etc/bash_completion"
#    echo "fi"
#    subl ~/.bash_profile
#else
#    cat >> ~/.bash_profile << EOF
#if [ -f 'brew --prefix'/etc/bash_completion ]; then
#    . 'brew --prefix'/etc/bash_completion
#fi
#EOF
#fi


#### ??? REALLY NEEDED ??? ######
##------------------------------------------------------------------------------
## Install Ruby
##------------------------------------------------------------------------------
#cd ~/Github/

## -- Try 1 --
#git clone git://github.com/sstephenson/rbenv.git .rbenv
#?echo 'eval "$(rbenv init -)"' >> ~/.extra
#?source ~/.bashrc
#mkdir -p ~/.rbenv/plugins
#cd ~/.rbenv/plugins
#git clone git://github.com/sstephenson/ruby-build.git
#ERR: rbenv install 1.9.3-p194
#ERR: rbenv global 1.9.3-p194
#ERR: cat "rbenv global 1.9.3-p194" >> .extra
#ruby -v

## -- Try 2 --
#git clone git://github.com/sstephenson/rbenv.git .rbenv
#mkdir -p ~/.rbenv/plugins
#cd ~/.rbenv/plugins
#git clone git://github.com/sstephenson/ruby-build.git
#export PATH="$HOME/.rbenv/bin:$PATH"
#rbenv rehash
#rbenv install 1.9.3-p194
#rbenv rehash
#rbenv global 1.9.3-p194


#------------------------------------------------------------------------------
# Apache - Generic
#------------------------------------------------------------------------------
## /private/etc/apache2/extra/httpd-vhosts.conf
## sudo apachectl -V

sudo apachectl -V

echo "Add/Change the following lines:"
echo "ServerName localhost"
sudo subl /private/etc/apache2/httpd.conf

echo "Modify the <Directory>:"
echo "<Directory />"
echo "    Options FollowSymLinks"
echo "    AllowOverride None"
echo "    #Order deny,allow"
echo "    #Deny from all"
echo "</Directory>"

echo "Modify the <Directory "/Library/WebServer/Documents">"
echo "Options Indexes FollowSymLinks Multiviews -> Options Indexes FollowSymLinks ExecCGI Includes"
echo "AllowOverride None -> AllowOverride All"


## ??? (1)
#echo "Add below the first </Directory>:"
#echo "<Directory />"
#echo "    Options FollowSymLinks"
#echo "    AllowOverride None"
#echo "    Order deny,allow"
#echo "    Allow from all"
#echo "</Directory>"

## ??? (2)
#echo "Add below the first </Directory>:"
#echo "<Directory />"
#echo "    Options FollowSymLinks"
#echo "    AllowOverride All"
#echo "    Order deny,allow"
#echo "    Allow from all"
#echo "</Directory>"

sudo apachectl configtest
sudo apachectl restart

#------------------------------------------------------------------------------
# Enable Apache Virtual Host
#------------------------------------------------------------------------------
## /private/etc/apache2/extra/httpd-vhosts.conf
#
#echo "# Virtual hosts"
#echo "Include /private/etc/apache2/extra/httpd-vhosts.conf"
#sudo subl /private/etc/apache2/extra/httpd-vhosts.conf


# ?????????????????????????????????????????????????????????????????????????????
#------------------------------------------------------------------------------
# Install LazyLibrarian
#------------------------------------------------------------------------------
## https://github.com/itsmegb/LazyLibrarian
