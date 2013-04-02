#!/usr/bin/env bash


######## PLAY TIME ##############
### Exit the script if any statement returns a non-true return value.
#set -o errexit
##set -e
#
### Check for uninitialised variables
##set -o nounset
#
######## PLAY TIME - END ########


SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [ $HOSTNAME != "pooky.local"]; then
    if [ -L config.sh ]; then
      rm config.sh
    fi
else
    echo "=> Pooky found"
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

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GREY=$(tput setaf 238)
ORANGE=$(tput setaf 172)
BOLD=$(tput bold)
UNDERLINE=$(tput sgr 0 1)
RESET=$(tput sgr0)

######## PLAY TIME ##############
function get_color(){
    document "get_color" "Return a color, either a colorcode or one of the color list" "colorname" && return
    [[ $1 < 254 ]] && { echo $1; } || { echo ${colors[$1]} ; } ; }

function colorize(){
    document "colorize" "Colorize bg and fg for a specific frase" "bg fg frase" && return
    a=($(split $1 ","));
    fg=$(get_color ${a[1]});
    bg=$(get_color ${a[2]});
    ef=$(get_color ${a[0]}); 
    [[ $bg ]] && tput setab $bg
    [[ ${fg} ]] && tput setaf $fg
    [[ ${ef} != "0" ]] && tput $ef
    echo -en "$2"; tput sgr0
}
######## PLAY TIME - END ########


NOTICE=$RESET$BOLD$BLUE
SUCCESS=$RESET$BOLD$GREEN
FAILURE=$RESET$BOLD$RED
ATTENTION=$RESET$BOLD$ORANGE
INFORMATION=$RESET$BOLD$GREY

PRINTF_MASK="%-50s %s %10s %s\n"

TIMESTAMP=`date +%Y%m%d%H%M%S`
LOGFILE=$DIR/install-$TIMESTAMP.log

# Set to non-zero value for debugging
DEBUG=0

##-----------------------------------------------------------------------------
## Functions
##-----------------------------------------------------------------------------
#function log () {
#  echo -e "$1"
#  #echo -e $@ >> $LOGFILE
#}

function log()  {
    printf "$*\n" ;
    return $? ;
}

function handle_error () {
  if [ "$?" != "0" ]; then
    log "${failure}$2 $1"
    exit 1
  fi
}

function fail() {
    log "\nERROR: $*\n" ;
    exit 1 ; 
}

function to_lower()
{
    echo $1 | tr '[A-Z]' '[a-z]'
}
#USER_LC=$(to_lower $curr_user)

function check_system() {
    # Check for supported system
    kernel=`uname -s`
    case $kernel in
        Darwin) ;;
        *) fail "Sorry, $kernel is not supported." ;;
    esac
}

function homebrew_checkinstall_recipe () {
  brew list $1 &> /dev/null
  if [ $? == 0 ]; then
    log "${SUCCESS}Your $package$1 ${SUCCESS}installation is fine. Doing nothing"
  else
    install_homebrew $1
  fi
}

function check_command_dependency () {
  $1 --version &> /dev/null
  handle_error $1 'There was a problem with:'
}

function install_homebrew () {
  log "${notice}Installing ${component}Homebrew ${notice}recipe ${package}$1"
  if [ $DEBUG == 0 ]; then
    HOMEBREW_OUTPUT=`brew install $1 2>&1`
    handle_error $1 "Homebrew had a problem\n($HOMEBREW_OUTPUT):"
  fi
}

function noyes() {
    read "a?$1 [y/N] "
    if [[ $a == "N" || $a == "n" || $a = "" ]]; then
        return 0
    fi
    return 1
}
#noyes "Do you want to bla bla bla?" || \
#                  do_stuff

##-----------------------------------------------------------------------------
## Check OS
##-----------------------------------------------------------------------------
#if [[ "$OSTYPE" =~ ^darwin ]]; then
#  OS="Mac"
#  APP_PATH="/Applications"
#  printf "$PRINTF_MASK" "OS X Detected" "$GREEN" "[OK]" "$RESET"
#else
#  printf "$PRINTF_MASK" "Linux unsupported." "$RED" "[ERR]" "$RESET"
#  exit 1
#fi

check_system

#------------------------------------------------------------------------------
# Keep-alive: update existing sudo time stamp until finished
#------------------------------------------------------------------------------
# Ask for the administrator password upfront
echo "----------------------------------"
echo "| Please enter root password     |"
echo "----------------------------------"
sudo -v
echo "----------------------------------"

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#------------------------------------------------------------------------------
# Checking if system is up-to-date
#------------------------------------------------------------------------------
## Run software update and reboot
#if [[ $INST_OSX_UPDATES == "true" ]]; then
#    sudo softwareupdate --list
#    sudo softwareupdate --install --all
#fi

check_system

#------------------------------------------------------------------------------
# Show the ~/Library folder
#------------------------------------------------------------------------------
chflags nohidden ~/Library

#------------------------------------------------------------------------------
# Enable Tap to Click for this user and for the login screen
#------------------------------------------------------------------------------
if [[ $ENABLE_MOUSE_TAPTOCLICK == "true" ]]; then
    source "$DIR/scripts/osx_mouse_taptoclick_enable.sh"
fi

#------------------------------------------------------------------------------
# Checking existence directories
#------------------------------------------------------------------------------
if [ ! -d ~/Sites/ ] ; then
    printf "$PRINTF_MASK" "Creating directory ~/Sites…" "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p ~/Sites/
    if [ "$?"-ne 0]; then
        printf "$PRINTF_MASK" "Directory ~/Sites found" "$GREEN" "[OK]" "$RESET"
    else
        printf "$PRINTF_MASK" "Creating directory ~/Sites failed!" "$RED" "[FAIL]" "$RESET"
    fi
else
    printf "$PRINTF_MASK" "Directory ~/Sites found" "$GREEN" "[OK]" "$RESET"
fi

if [ ! -d ~/Github/ ] ; then
    printf "$PRINTF_MASK" "Creating directory ~/Github…" "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p ~/Github/
    if [ "$?"-ne 0]; then
        printf "$PRINTF_MASK" "Directory ~/Github found" "$GREEN" "[OK]" "$RESET"
    else
        printf "$PRINTF_MASK" "Creating directory ~/Github failed!" "$RED" "[ERR]" "$RESET"
    fi
else
    printf "$PRINTF_MASK" "Directory ~/Github found" "$GREEN" "[OK]" "$RESET"
fi

if [ ! -d ~/Applications/ ] ; then
    printf "$PRINTF_MASK" "Creating directory ~/Applications" "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p ~/Applications/
    if [ "$?"-ne 0]; then
        printf "$PRINTF_MASK" "Directory ~/Applications found" "$GREEN" "[OK]" "$RESET"
    else
        printf "$PRINTF_MASK" "Creating directory ~/Applications failed!" "$RED" "[ERR]" "$RESET"
    fi
else
    printf "$PRINTF_MASK" "Directory ~/Applications found" "$GREEN" "[OK]" "$RESET"
fi

#------------------------------------------------------------------------------
# Dotfiles
#------------------------------------------------------------------------------
for file in ~/.{bash_profile,bashrc,extra,bash_prompt,exports,aliases,functions}; do
  if [ ! -f ~/$file ] ; then
    #echo "~/$file not found. Copying..."
    printf "$PRINTF_MASK" "File ~/$file not found. Copying..." "$YELLOW" "[WAIT]" "$RESET"
    cp $DIR/conf/user/$file $HOME/$file
    if [ "$?" != "0" ]; then
        printf "$PRINTF_MASK" "Copying file ~/$file failed!" "$RED" "[ERR]" "$RESET"
    else
        printf "$PRINTF_MASK" "File ~/$file copied." "$GREEN" "[OK]" "$RESET"
    fi
  else
    #echo "~/$file found."
    printf "$PRINTF_MASK" "File ~/$file found" "$GREEN" "[OK]" "$RESET"
  fi
done
unset file

source ~/.bash_profile

#------------------------------------------------------------------------------
# Check for installation Xcode
#------------------------------------------------------------------------------
if [ ! -e /Applications/Xcode.app ] ; then
    printf "$PRINTF_MASK" "Xcode not installed, please install..." "$RED" "[FAIL]" "$RESET"
    open http://itunes.apple.com/nl/app/xcode/id497799835?mt=12
    while ( [ ! -e /Applications/Xcode.app ] )
    do
        printf "$PRINTF_MASK" "Waiting for Xcode to be installed…" "$YELLOW" "[WAIT]" "$RESET"
        sleep 15
    done
    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

    echo -e "${BLUE} --- Enable command line tools via Xcode      --- ${RESET}"
    echo -e "${BLUE} --- (or install seperate package)            --- ${RESET}"
    read -n 1 -s
else
    printf "$PRINTF_MASK" "Xcode found" "$GREEN" "[OK]" "$RESET"
fi

#------------------------------------------------------------------------------
# Check for Command Line Tools via GCC check
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/gcc ] ; then
    printf "$PRINTF_MASK" "GCC not installed, please install..." "$RED" "[FAIL]" "$RESET"
    open https://developer.apple.com/downloads/index.action#
    while ( [ ! -e /usr/bin/gcc ] )
    do
        printf "$PRINTF_MASK" "Waiting for GCC to be installed…" "$YELLOW" "[WAIT]" "$RESET"
        sleep 15
    done
else
    printf "$PRINTF_MASK" "GCC found" "$GREEN" "[OK]" "$RESET"
fi

#------------------------------------------------------------------------------
# Check for XQuartz
#------------------------------------------------------------------------------
if [ ! -d /opt/X11/ ] ; then
    printf "$PRINTF_MASK" "XQuartz not installed, please install..." "$RED" "[FAIL]" "$RESET"
    open http://xquartz.macosforge.org/landing/
    while ( [ ! -d /opt/X11/ ] )
    do
        printf "$PRINTF_MASK" "Waiting for XQuartz to be installed…" "$YELLOW" "[WAIT]" "$RESET"
        sleep 15
    done

    echo -e "${BLUE} ---      Restart needed       --- ${RESET}"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    echo -e "${BLUE} --- or press CTRC+C to abort  --- ${RESET}"
    read -n 1 -s
    sudo shutdown -r +1 "Rebooting in 1 minute..."
else
    printf "$PRINTF_MASK" "XQuartz found" "$GREEN" "[OK]" "$RESET"
fi

#------------------------------------------------------------------------------
# Check for Java
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/java ] ; then
    printf "$PRINTF_MASK" "Java not installed, please install..." "$RED" "[FAIL]" "$RESET"
    while ( [ ! -e /usr/bin/java ] )
    do
        printf "$PRINTF_MASK" "Waiting for Java to be installed…" "$YELLOW" "[WAIT]" "$RESET"
        sleep 15
    done
else
    printf "$PRINTF_MASK" "Java found" "$GREEN" "[OK]" "$RESET"
fi

#------------------------------------------------------------------------------
# Check for OS X Server 2.0
#------------------------------------------------------------------------------
if [ ! -e /Applications/Server.app ] ; then
    printf "$PRINTF_MASK" "OS X Server not installed, please install..." "$RED" "[FAIL]" "$RESET"
    open https://itunes.apple.com/nl/app/os-x-server/id537441259?mt=12
    while ( [ ! -e /Applications/Server.app ] )
    do
        printf "$PRINTF_MASK" "Waiting for OS X Server to be installed…" "$YELLOW" "[WAIT]" "$RESET"
        sleep 15
    done
    printf "$PRINTF_MASK" "Please enable:" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- Websites…" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- PHP Web Applications…" "$YELLOW" "[WAIT]" "$RESET"
    open /Applications/Server.app

    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
else
    printf "$PRINTF_MASK" "OS X Server found" "$GREEN" "[OK]" "$RESET"
fi

SERVICE='httpd'
if ps ax | grep -v grep | grep $SERVICE > /dev/null ; then
    printf "$PRINTF_MASK" "$SERVICE' is running" "$GREEN" "[OK]" "$RESET"
else
    printf "$PRINTF_MASK" "$SERVICE' is not running" "$RED" "[FAIL]" "$RESET"

    printf "$PRINTF_MASK" "Please enable:" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- Websites…" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- PHP Web Applications…" "$YELLOW" "[WAIT]" "$RESET"

    echo -e "${BLUE} --- press any key to abort --- ${RESET}"
    read -n 1 -s

    open /Applications/Server.app
    exit 1
fi

#------------------------------------------------------------------------------
# Copy original libphp5 file
#------------------------------------------------------------------------------
#sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
if [ ! -e /usr/libexec/apache2/libphp5.so.org ] ; then
    printf "$PRINTF_MASK" "Backup file libphp5.org not found, copying file…" "$YELLOW" "[WAIT]" "$RESET"
    sudo cp /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
    if [ -e /usr/libexec/apache2/libphp5.so.org ] ; then
        printf "$PRINTF_MASK" "Backup file libphp5.org found" "$GREEN" "[OK]" "$RESET"
    else
        printf "$PRINTF_MASK" "No backup of file libphp5.so found" "$RED" "[FAIL]" "$RESET"
    fi
else
    printf "$PRINTF_MASK" "Backup file libphp5.org found" "$GREEN" "[OK]" "$RESET"
fi

#------------------------------------------------------------------------------
# Check for iTerm 2
#------------------------------------------------------------------------------
if [[ $INST_ITERM2 == "true" ]]; then
    if [ ! -e /Applications/iTerm.app ] ; then
        printf "$PRINTF_MASK" "iTerm not found, please install…" "$RED" "[FAIL]" "$RESET"
        open http://www.iterm2.com
        while ( [ ! -e /Applications/iTerm.app ] )
        do
            printf "$PRINTF_MASK" "Waiting for iTerm to be installed…" "$YELLOW" "[WAIT]" "$RESET"
            sleep 15
        done
        open /Applications/iTerm.app
    else
        printf "$PRINTF_MASK" "iTerm found" "$GREEN" "[OK]" "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for Sublime Text
#------------------------------------------------------------------------------
if [[ $INST_SUBLIMETEXT == "true" ]]; then
    if [ ! -e /Applications/Sublime\ Text\ 2.app ] ; then
        printf "$PRINTF_MASK" "Sublime Text not found, please install…" "$RED" "[FAIL]" "$RESET"
        open http://www.sublimetext.com
        while ( [ ! -e /Applications/Sublime\ Text\ 2.app ] )
        do
            printf "$PRINTF_MASK" "Waiting for Sublime Text to be installed…" "$YELLOW" "[WAIT]" "$RESET"
            sleep 15
        done
        open /Applications/Sublime\ Text\ 2.app
    else
        printf "$PRINTF_MASK" "Sublime Text found" "$GREEN" "[OK]" "$RESET"
    fi
    if [ ! -L /usr/local/bin/subl ] ; then
        printf "$PRINTF_MASK" "Symbolic link to Sublime Text not found, creating…" "$YELLOW" "[WAIT]" "$RESET"
        if [ ! -d /usr/local/bin ] ; then
            printf "$PRINTF_MASK" "Directory /usr/local/bin/ does not exist, creating…" "$YELLOW" "[WAIT]" "$RESET"
            sudo mkdir -p /usr/local/bin/
            if [ "$?"-ne 0]; then
                printf "$PRINTF_MASK" "Directory /usr/local/bin found" "$GREEN" "[OK]" "$RESET"
            else
                printf "$PRINTF_MASK" "Creating directory /usr/local/bin failed!" "$RED" "[FAIL]" "$RESET"
            fi
        else
            printf "$PRINTF_MASK" "Directory /usr/local/bin/ exist" "$GREEN" "[OK]" "$RESET"
        fi
        sudo ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
        if [ "$?"-ne 0]; then
            printf "$PRINTF_MASK" "Symbolic link created" "$GREEN" "[OK]" "$RESET"
        else
            printf "$PRINTF_MASK" "Symbolic link creation failed!" "$RED" "[FAIL]" "$RESET"
        fi
    else
        printf "$PRINTF_MASK" "Sublime Text link found" "$GREEN" "[OK]" "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for Xlog
#------------------------------------------------------------------------------
#https://itunes.apple.com/nl/app/xlog/id430304898?l=en&mt=12
if [[ $INST_XLOG == "true" ]]; then
    if [ ! -e /Applications/Xlog.app ] ; then
        printf "$PRINTF_MASK" "Xlog not found, please install…" "$RED" "[FAIL]" "$RESET"
        open https://itunes.apple.com/us/app/xlog/id430304898?mt=12&ls=1
        while ( [ ! -e /Applications/Xlog.app ] )
        do
            printf "$PRINTF_MASK" "Waiting for Xlog to be installed…" "$YELLOW" "[WAIT]" "$RESET"
            sleep 15
        done
        open /Applications/Xlog.app
    else
        printf "$PRINTF_MASK" "Xlog found" "$GREEN" "[OK]" "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for GitHub for Mac
#------------------------------------------------------------------------------
if [[ $INST_MACGITHUB == "true" ]]; then
    if [ ! -e /Applications/GitHub.app ] ; then
        printf "$PRINTF_MASK" "Github not found, please install…" "$RED" "[FAIL]" "$RESET"
        open http://mac.github.com
        while ( [ ! -e /Applications/GitHub.app ] )
        do
            printf "$PRINTF_MASK" "Waiting for Github to be installed…" "$YELLOW" "[WAIT]" "$RESET"
            sleep 15
        done
        #open /Applications/GitHub.app
    else
        printf "$PRINTF_MASK" "GitHub found" "$GREEN" "[OK]" "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for Dropbox
#------------------------------------------------------------------------------
if [[ $INST_DROPBOX == "true" ]]; then
    if [ ! -d /Library/DropboxHelperTools ] ; then
        printf "$PRINTF_MASK" "Dropbox not found, please install…" "$RED" "[FAIL]" "$RESET"
        open https://www.dropbox.com/download?plat=mac
        while ( [ ! -d /Library/DropboxHelperTools ] )
        do
            printf "$PRINTF_MASK" "Waiting for Dropbox to be installed…" "$YELLOW" "[WAIT]" "$RESET"
            sleep 15
        done
    else
        printf "$PRINTF_MASK" "Dropbox found" "$GREEN" "[OK]" "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Check for Transmission
#------------------------------------------------------------------------------
if [[ $INST_TRANSMISSION == "true" ]]; then
    if [ ! -e /Applications/Transmission.app ] ; then
        printf 'Transmission not found, please install…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_transmission.sh"
    else
        printf 'Transmission found\n' "$GREEN" $col '[OK]' "$RESET"
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
    printf "$PRINTF_MASK" "HomeBrew not found, please install…" "$RED" "[FAIL]" "$RESET"
    source "$DIR/scripts/install_brew.sh"
    while ( [ ! -e /usr/local/bin/brew ] )
    do
        printf "$PRINTF_MASK" "Waiting for HomeBrew to be installed…" "$YELLOW" "[WAIT]" "$RESET"
        sleep 15
    done
else
    printf "$PRINTF_MASK" "HomeBrew found" "$GREEN" "[OK]" "$RESET"
fi

##------------------------------------------------------------------------------
## Install several tools via Brew
##------------------------------------------------------------------------------
### Consider amending your PATH so that /usr/local/bin occurs before /usr/bin in your PATH.

#brew tap homebrew/dupes
#brew install apple-gcc42
#brew install gnu-sed
#brew install coreutils
#brew install autoconf
#brew install automake
#brew install findutils
#brew install bash
#brew install wget
#brew install tmux
#brew install texi2html
#brew install yasm
#brew install x264
#brew install faac
#brew install lame
#brew install xvid
#brew install ffmpeg
#brew install mediainfo

check_command_dependency brew

INSTALL="apple-gcc42 \
        gnu-sed \
        coreutils \
        autoconf \
        automake \
        findutils \
        bash \
        bash-completion \
        wget \
        ack \
        ifstat \
        macvim --env-std --override-system-vim \
        --use-gcc fontforge \
        texi2html \
        yasm \
        x264 \
        faac \
        lame \
        xvid \
        ffmpeg \
        mediainfo \
        "

#brew install --use-gcc fontforge
#brew install https://raw.github.com/Homebrew/homebrew-dupes/master/grep.rb
#brew install 
brew linkapps

for i in $INSTALL
do
        # command -v will return >0 when the $i is not found
    homebrew_checkinstall_recipe $i || { echo "$i command not found."; exit 1; }
done

echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
echo "# homebrew"
echo "PATH=/usr/local/bin:/usr/local/sbin:$PATH"
echo "# GNU coreutils"
echo "PATH=/opt/local/libexec/gnubin/:$PATH"

#if [ ! -f ~/.bashrc ] ; then
#    echo "Copying default .bashrc..."
#    cp conf/bashrc ~/.bashrc
#else
#    echo "File ~/.bashrc found, please add the following manually..."
#    echo "# Tell ls to be colourful"
#    echo "export CLICOLOR=1"
#    echo ""
#    echo "# Tell grep to highlight matches"
#    echo "export GREP_OPTIONS='--color=auto'"
#    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#    read -n 1 -s
#    nano ~/.bashrc
#fi
#source ~/.bashrc

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
    printf 'Sphinx found\n' "$GREEN" $col '[OK]' "$RESET"
fi

##------------------------------------------------------------------------------
## Install Tmux
##------------------------------------------------------------------------------
if [ ! -e /usr/bin/tmux ] ; then
    printf 'Tmux not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_tmux.sh"
else
    printf 'Tmux found\n' "$GREEN" $col '[OK]' "$RESET"
fi

##------------------------------------------------------------------------------
## Install Powerline Tmux
##------------------------------------------------------------------------------
if [[ $INST_POWERLINE_TMUX == "true" ]]; then
    if [ ! -d /usr/local/share/tmux-powerline ] ; then
        printf 'Powerline not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_powerline_tmux.sh"
    else
        printf 'Powerline found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

##------------------------------------------------------------------------------
## Install Powerline for Bash
##------------------------------------------------------------------------------
if [[ $INST_POWERLINE_SHELL == "true" ]]; then
    if [ ! -e /usr/local/bin/powerline-shell.py ] ; then
        printf 'Powerline for Bash not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_powerline_bash.sh"
    else
        printf 'Powerline for Bash found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Install NewzNAB
#------------------------------------------------------------------------------
## http://mar2zz.tweakblogs.net/blog/6947/newznab.html#more
if [[ $INST_NEWZNAB == "true" ]]; then
    if [ ! -d /Users/Newznab/Sites/newznab ] ; then
        printf 'NewzNAB not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_newznab.sh"
    else
        printf 'NewzNAB found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Installing additional NewzNAB themes
#------------------------------------------------------------------------------
if [[ $$INST_NEWZNAB_THEMES == "true" ]]; then
    for another_newznab_theme in \
        $INST_NEWZNAB_PATH/www/templates/simple \
        $INST_NEWZNAB_PATH/www/templates/bootstrapped \
        $INST_NEWZNAB_PATH/www/templates/carbon \
        $INST_NEWZNAB_PATH/www/templates/dusplic
    do
        [[ -e $another_newznab_theme ]] && echo "Found theme: $another_newznab_theme" && [[ $INST_NEWZNAB_THEME != "false" ]] && export INST_NEWZNAB_THEME="true" || export INST_NEWZNAB_THEME="true"
    done
    
    if [[ $INST_NEWZNAB_THEME == "true" ]]; then
        printf 'NewzNAB thems not all installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_newznab_themes.sh"
    else
        printf 'NewzNAB themes found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Configure Sphinx for NewzNAB
#------------------------------------------------------------------------------
if [[ $INST_NEWZNAB == "true" ]]; then
    if [ ! -f $INST_NEWZNAB_PATH/db/sphinxdata/sphinx.conf ] ; then
        printf 'NewzNAB Sphinx config found, installing...\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_newznab_sphinx.sh"
    else
        printf 'NewzNAB Sphinx config found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Install NewzNAB - jonnyboy/newznab-tmux
#------------------------------------------------------------------------------
if [[ $INST_NEWZNAB == "true" ]]; then
    if [ ! -d $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux ] ; then
        printf 'NewzNAB jonnyboy Tmux not found, installing...\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_newznab_tmux.sh"
    else
        printf 'NewzNAB jonnyboy Tmux scripts found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Install NewzNAB - Custom Scripts
#------------------------------------------------------------------------------
if [[ $INST_NEWZNAB == "true" ]]; then
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
fi

#------------------------------------------------------------------------------
# Install NewzDash
#------------------------------------------------------------------------------
if [[ $INST_NEWZNAB_NEWZDASH == "true" ]]; then
    if [ ! -d /Library/Server/Web/Data/Sites/Default/newzdash ] ; then
        printf 'NewzDash not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_newzdash.sh"
    else
        printf 'NewzDash found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

#------------------------------------------------------------------------------
# Install SABnzbd+
#------------------------------------------------------------------------------
if [[ $INST_SABNZBD == "true" ]]; then
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
fi

#------------------------------------------------------------------------------
# Install SABnzbd+ - nzbToMedia
#------------------------------------------------------------------------------
if [[ $INST_SABNZBD_NZBTOMEDIA == "true" ]]; then
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
fi

#------------------------------------------------------------------------------
# Install Spotweb
#------------------------------------------------------------------------------
if [ ! -d /Users/Spotweb/Sites/spotweb ] ; then
    printf 'Spotweb not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_spotweb.sh"
else
    printf 'Spotweb found\n' "$GREEN" $col '[OK]' "$RESET"
fi

osascript -e 'tell app "Terminal"
    do script "php $INST_SPOTWEB_PATH/retrieve.php"
end tell'

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
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO:"
echo " - Autostart Python Sickbeard script via Screen ??"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ??? TODO: Screen the Sickbeard.py ???
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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

#------------------------------------------------------------------------------"
# Configuring NewzNAB as provider for Sickbeard"
#------------------------------------------------------------------------------"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_sickbeard_newznab.sh"

source "$DIR/scripts/install_sickbeard_newznab.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'NewzNAB as provider for Sickbeard not configured\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sickbeard_newznab.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'NewzNAB as provider for Sickbeard configured\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring Spotweb as provider for Sickbeard"
#------------------------------------------------------------------------------"
if [[ -z $INST_SPOTWEB_KEY_API_SICKBEARD ]]; then
    printf 'Spotweb as provider for Sickbeard not configured\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_sickbeard_spotweb.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'Spotweb as provider for Sickbeard configured\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring Sickbeard to support Trakt.TV"
#------------------------------------------------------------------------------"
if [[ $INST_INTEGRATION_TRAKT == "true" ]]; then

    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo " TODO: Check for specific variables"
    echo " Till then, forced run:"
    echo "   $DIR/scripts/install_sickbeard_trakttv.sh"

    source "$DIR/scripts/install_sickbeard_trakttv.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

fi

#------------------------------------------------------------------------------
# Install Auto-Sub
#------------------------------------------------------------------------------
if [[ $INST_AUTO_SUB == "true" ]]; then
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
fi
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

#------------------------------------------------------------------------------"
# Configuring NewzNAB as provider for CouchPotato"
#------------------------------------------------------------------------------"
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_couchpotato_newznab.sh"

source "$DIR/scripts/install_sickbeard_newznab.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
#    printf 'NewzNAB as provider for CouchPotato not configured\n' "$RED" $col '[FAIL]' "$RESET"
#    source "$DIR/scripts/install_couchpotato_newznab.sh"
#    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#    read -n 1 -s
#    exit    
#else
#    printf 'NewzNAB as provider for CouchPotato configured\n' "$GREEN" $col '[OK]' "$RESET"
#fi

#------------------------------------------------------------------------------"
# Configuring CouchPotato as provider for Sickbeard"
#------------------------------------------------------------------------------"
if [[ -z $INST_SPOTWEB_KEY_API_COUCHPOTATO ]]; then
    printf 'Spotweb as provider for CouchPotato not configured\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_couchpotato_spotweb.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'Spotweb as provider for CouchPotato configured\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring CouchPotato to support Trakt.TV"
#------------------------------------------------------------------------------"
if [[ $INST_INTEGRATION_TRAKT == "true" ]]; then

    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo " TODO: Check for specific variables"
    echo " Till then, forced run:"
    echo "   $DIR/scripts/install_couchpotato_trakttv.sh"

    source "$DIR/scripts/install_couchpotato_trakttv.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
fi

#if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
#    printf 'CouchPotato support for Trakt.TV is not configured\n' "$RED" $col '[FAIL]' "$RESET"
#    source "$DIR/scripts/install_couchpotato_trakttv.sh"
#    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#    read -n 1 -s
#    exit    
#else
#    printf 'CouchPotato support for Trakt.TV is configured\n' "$GREEN" $col '[OK]' "$RESET"
#fi

#------------------------------------------------------------------------------
# Install Headphones
#------------------------------------------------------------------------------
if [ ! -d $INST_HEADPHONES_PATH ] ; then
    printf 'Headphones not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_headphones.sh"
    while ( [ ! -d $INST_HEADPHONES_PATH ] )
    do
        echo "Waiting for Headphones to be installed..."
        sleep 15
    done
else
    printf 'Headphones found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------"
# Configuring NewzNAB as provider for Headphones"
#------------------------------------------------------------------------------"
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_headphones_newznab.sh"

source "$DIR/scripts/install_headphones_newznab.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# /Users/Headphones/Sites/headphones/config.ini
#  [SABnzbd]
#  sab_host = http://localhost/8080
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
#    printf 'NewzNAB as provider for Headphones not configured\n' "$RED" $col '[FAIL]' "$RESET"
#    source "$DIR/scripts/install_headphones_newznab.sh"
#    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#    read -n 1 -s
#    exit    
#else
#    printf 'NewzNAB as provider for Headphones configured\n' "$GREEN" $col '[OK]' "$RESET"
#fi

#------------------------------------------------------------------------------"
# Configuring Headphones for SABnzbd"
# "
# Perhaps even:"
# Configuring Headphones for SABnzbd - nzbToMedia"
#------------------------------------------------------------------------------"
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_headphones_nzbtomedia.sh"

source "$DIR/scripts/install_headphones_nzbtomedia.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf 'Headphones: SABnzbd - nzbToMedia not installed\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_headphones_nzbtomedia.sh"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit    
else
    printf 'Headphones: SABnzbd - nzbToMedia configured\n' "$GREEN" $col '[OK]' "$RESET"
fi


##------------------------------------------------------------------------------
## Install Periscope
##------------------------------------------------------------------------------
if [[ $INST_PERISCOPE == "true" ]]; then
    if [ ! -e /usr/local/bin/periscope ] ; then
        printf 'Periscope not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_periscope.sh"
        while ( [ ! -e /usr/local/bin/periscope ] )
        do
    	echo "Waiting for Periscope to be installed..."
	    sleep 15
        done
    else
        printf 'Periscope found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

##------------------------------------------------------------------------------
## Install Subliminal
##------------------------------------------------------------------------------
#if [[ $INST_INST_SUBLIMINAL == "true" ]]; then
#    if [ ! -e /Applications/auto-sub.app ] ; then
#        printf 'Periscope not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
#        source "$DIR/scripts/install_hmm_subliminal.sh"
#        while ( [ ! -e /Applications/auto-sub.app ] )
#        do
#            echo "Waiting for Periscope to be installed..."
#            sleep 15
#        done
#    else
#        printf 'Periscope found\n' "$GREEN" $col '[OK]' "$RESET"
#    fi
#fi

#------------------------------------------------------------------------------
# Install Maraschino
#------------------------------------------------------------------------------
if [[ $INST_MARASCHINO == "true" ]]; then
	if [ ! -d /Applications/maraschino ] ; then
	    printf 'Maraschino not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
	    source "$DIR/scripts/install_marachino.sh"
	    while ( [ ! -d /Applications/maraschino ] )
	    do
	        echo "Waiting for Maraschino to be installed..."
	        sleep 15
	    done
	else
	    printf 'Maraschino found\n' "$GREEN" $col '[OK]' "$RESET"
	fi
fi
#------------------------------------------------------------------------------
# Install Plex Server
#------------------------------------------------------------------------------
if [ ! -e /Applications/Plex\ Media\ Server.app ] ; then
    printf 'Plex Server not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_plex_server.sh"
    while ( [ ! -e /Applications/Plex\ Media\ Server.app ] )
    do
        echo "Waiting for Plex Server to be installed..."
        sleep 15
    done
else
    printf 'Plex Server found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install Plex Client
#------------------------------------------------------------------------------
## http://wiki.plexapp.com/index.php/Keyboard
if [ ! -e /Applications/Plex.app ] ; then
    printf 'Plex Client not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_plex_client.sh"
    while ( [ ! -d /Applications/Plex.app ] )
    do
        echo "Waiting for Plex Client to be installed..."
        sleep 15
    done
else
    printf 'Plex Client found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install Plex Themes
#------------------------------------------------------------------------------
for another_plex_theme in \
    ~/Library/Application\ Support/Plex/addons/Blur \
    ~/Library/Application\ Support/Plex/addons/Carbon \
    ~/Library/Application\ Support/Plex/addons/Metropolis \
    ~/Library/Application\ Support/Plex/addons/PlexAeon \
    ~/Library/Application\ Support/Plex/addons/Quicksilver \
    ~/Library/Application\ Support/Plex/addons/Retroplex
do
    [[ -e $another_plex_theme ]] && echo "Found theme: $another_plex_theme" && [[ $INST_PLEX_THEMES != "false" ]] && export INST_PLEX_THEMES="true" || export INST_PLEX_THEMES="true"
done

if [[ $INST_PLEX_THEMES == "true" ]]; then
    printf 'Plex themes not all installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
    source "$DIR/scripts/install_plex_themes.sh"
else
    printf 'Plex themes found\n' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install Trakt.TV scrobbler for Plex
#------------------------------------------------------------------------------
if [ ! -e /Applications/Plex.app ] ; then
    printf 'Plex Client not installed\n' "$RED" $col '[FAIL]' "$RESET"
else
    printf 'Plex Client found\n' "$GREEN" $col '[OK]' "$RESET"
    source "$DIR/scripts/install_plex_trakttv.sh"
fi

##------------------------------------------------------------------------------
## Install Apache Frontpage
##------------------------------------------------------------------------------
if [[ $INST_APACHE_WWW_FRONTPAGE == "true" ]]; then
    if [ ! -f $INST_APACHE_SYSTEM_WEB_ROOT/menubar.html ] ; then
        printf 'Apache Frontpage not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_apache_frontpage.sh"
    else
        printf 'Apache Frontpage found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi

##------------------------------------------------------------------------------
## Install Apache Frontpage
##------------------------------------------------------------------------------
echo " TODO: Check for specific variables"
echo " Till then, forced run:"
echo "   $DIR/scripts/install_logitech_harmony.sh"

source "$DIR/scripts/install_logitech_harmony.sh"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if [[ $INST_HARMONY_PLEX == "true" ]]; then
    if [ ! -f $INST_HARMONY_PATH/menubar.html ] ; then
        printf 'Harmony Software not installed, installing…\n' "$RED" $col '[FAIL]' "$RESET"
        source "$DIR/scripts/install_logitech_harmony.sh"
    else
        printf 'Harmony Software found\n' "$GREEN" $col '[OK]' "$RESET"
    fi
fi



#==============================================================================
#=== FORCED EXIT DUE TO TESTING ===============================================
exit
#==============================================================================


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
