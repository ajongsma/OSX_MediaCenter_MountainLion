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

if [ ! -f defaults.sh ]; then
  clear
  echo "Please copy config.sh to defaults.sh"
  exit
fi

source defaults.sh

## Verify that all variables exist
source bin/test_defaults.sh
if [[ $ALLOW_START == "false" ]]; then
  clear
  echo "Please copy config.sh to defaults.sh, your current copy is outdated."
  exit
fi

## ??? eval $( $SED -n "/^define/ { s/.*('\([^']*\)', '*\([^']*\)'*);/export \1=\"\2\"/; p }" "$NEWZPATH"/www/config.php )

if [[ $AGREED == "no" ]]; then
  echo "Please edit the defaults.sh file"
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
  APP_FILE="chrome-mac.zip"
  APP_PATH="/Applications"
  #echo "OS X Detected                               [OK]"
  printf 'OS X Detected' "$GREEN" $col '[OK]' "$RESET"
else
  #echo "Linux unsupported."
  printf 'Linux unsupported.' "$RED" $col '[FAIL]' "$RESET"
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
# Read input
#------------------------------------------------------------------------------
#echo -e "Please enter computer name"
#read COMPUTER_NAME

#### REALLY NEEDED ???
## Install GitX
#wget http://frim.frim.nl/GitXStable.app.zip
#unzip GitXStable.app.zip
#mv GitX.app /Applications/
##open /Applications/GitX.app

#echo -e "Please enter Full Name for GIT"
#read GIT_FULL_NAME
GIT_FULL_NAME='Andries Jongsma'

#echo -e "Please enter e-mail address for GIT"
#read GIT_EMAIL
GIT_EMAIL='a.jongsma@gmail.com'

#echo -e "Please enter the MySQL Password"
#read MYSQL_PASSWORD

#echo "Please enter the required role name: postgres"
#read POSTGRESQL_USER


#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
#APACHE_SYSTEM_WEB_ROOT='/Library/WebServer/Documents/'

#------------------------------------------------------------------------------
# Checking if system is up-to-date
#------------------------------------------------------------------------------
## Run software update and reboot
#sudo softwareupdate --list
#sudo softwareupdate --install --all

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
# Check for installation Xcode
#------------------------------------------------------------------------------
if [ ! -e /Applications/Xcode.app ] ; then
    #echo "Xcode not installed, please install..."
    printf 'Xcode not installed, please install..' "$RED" $col '[FAIL]' "$RESET"

    open http://itunes.apple.com/us/app/xcode/id497799835?mt=12
    while ( [ ! -e /Applications/Xcode.app ] )
    do
        #echo "Waiting for Xcode to be installed..."
        printf 'Waiting for Xcode to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
else
    #echo "Xcode found                               [OK]"
    printf 'Xcode found' "$GREEN" $col '[OK]' "$RESET"
fi


#------------------------------------------------------------------------------
# Check for Command Line Tools via GCC check
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/gcc ] ; then
    #echo "GCC not installed, please install..."
    printf 'GCC not installed, please Command Line tools..' "$RED" $col '[FAIL]' "$RESET"
    while ( [ $(which gcc) == "" ] )
    do
        #echo "Waiting for GCC to be installed..."
        printf 'Waiting for GCC to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    #echo "GCC found                             [OK]"
    printf 'GCC found' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for Java
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/java ] ; then
    #echo "Java not installed, please install..."
    printf 'Java not installed, please install...' "$RED" $col '[FAIL]' "$RESET"
    while ( [ $(which java) == "" ] )
    do
        #echo "Waiting for Java to be installed..."
        printf 'Waiting for Java to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    #echo "Java found                                [OK]"
    printf 'Java found' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for OS X Server 2.0
#------------------------------------------------------------------------------
if [ ! -e /Applications/Server.app ] ; then
    #echo "OS X Server not installed, please install..."
    printf 'OS X Server not installed, please install...' "$RED" $col '[FAIL]' "$RESET"
    open https://itunes.apple.com/nl/app/os-x-server/id537441259?mt=12
    while ( [ ! -e /Applications/Server.app ] )
    do
        #echo "Waiting for OS X Server to be installed..."
        printf 'Waiting for OS X Server to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    #echo "OS X Server found                         [OK]"
    printf 'OS X Server found' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for Sublime Text
#------------------------------------------------------------------------------
if [ ! -e /Applications/Sublime\ Text\ 2.app ] ; then
    #echo "Sublime Text not installed, please install..."
    printf 'Sublime Text not installed, please install...' "$RED" $col '[FAIL]' "$RESET"
    open http://www.sublimetext.com
    while ( [ ! -e /Applications/Sublime\ Text\ 2.app ] )
    do
        #echo "Waiting for Sublime Text to be installed..."
        printf 'Waiting for Sublime Text to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    echo "Sublime Text found                            [OK]"
fi
if [ ! -e /usr/local/bin/subl ] ; then
    #echo "Creating link to Sublime Text..."
    printf 'Symbolic link to Sublime Text not found, creating...' "$RED" $col '[FAIL]' "$RESET"
    sudo mkdir -p /usr/local/bin/ 
    sudo ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
else
    #echo "Sublime Text link found                       [OK]"
    printf 'Sublime Text link found' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for iTerm 2
#------------------------------------------------------------------------------
if [ ! -e /Applications/iTerm.app ] ; then
    #echo "iTerm not installed, please install..."
    printf 'iTerm not installed, please install...' "$RED" $col '[FAIL]' "$RESET"
    open http://http://www.iterm2.com
    while ( [ ! -e /Applications/iTerm.app ] )
    do
        #echo "Waiting for iTerm to be installed..."
        printf 'Waiting for iTerm to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    echo "iTerm found                            [OK]"
    printf 'iTerm found' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Check for Xlog
#------------------------------------------------------------------------------
#https://itunes.apple.com/nl/app/xlog/id430304898?l=en&mt=12
if [ ! -e /Applications/Xlog.app ] ; then
    #echo "Xlog not installed, please install..."
    printf 'Xlog not installed, please install...' "$RED" $col '[FAIL]' "$RESET"
    open https://itunes.apple.com/us/app/xlog/id430304898?mt=12&ls=1
    while ( [ ! -e /Applications/Xlog.app ] )
    do
        #echo "Waiting for Xlog to be installed..."
        printf 'Waiting for Xlog to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    #echo "Xlog found                         [OK]"
    printf 'Xlog found' "$GREEN" $col '[OK]' "$RESET"
fi

#------------------------------------------------------------------------------
# Install pgAdmin (http://www.pgadmin.org/download/macosx.php)
#------------------------------------------------------------------------------
if [ ! -e /Applications/pgAdmin3.app ] ; then
    #echo "pgAdmin not installed, please install..."
    printf 'pgAdmin not installed, please install...' "$RED" $col '[FAIL]' "$RESET"
    open http://www.pgadmin.org/download/macosx.php
    while ( [ ! -e /Applications/pgAdmin3.app ] )
    do
        #echo "Waiting for pgAdmin to be installed..."
        printf 'Waiting for pgAdmin to be installed...' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
    done
else
    echo "pgAdmin found                                [OK]"
fi


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
# Show the ~/Library folder
#------------------------------------------------------------------------------
chflags nohidden ~/Library

#------------------------------------------------------------------------------
# Install fonts
#------------------------------------------------------------------------------
#cd ~/Downloads
#wget http://www.levien.com/type/myfonts/Inconsolata.otf
#open Inconsolata.otf
#wget https://dl.dropbox.com/u/4073777/Inconsolata-Powerline.otf
#open Inconsolata-Powerline.otf

#------------------------------------------------------------------------------
# Checking existance custom user directories
#------------------------------------------------------------------------------
if [ ! -e ~/Sites/ ] ; then
    #echo "Creating directory: Sites"
    printf 'Creating directory ~/Sites...' "YELLOW" $col '[WAIT]' "$RESET"
    mkdir -p ~/Sites/
else
    #echo "Directory ~/Sites/                        [OK]"
    printf 'Directory ~/Sites/ found' "$GREEN" $col '[OK]' "$RESET"
fi
if [ ! -e ~/Github/ ] ; then
    #echo "Creating directory: Github"
    printf 'Creating directory ~/Github...' "YELLOW" $col '[WAIT]' "$RESET"
    mkdir -p ~/Github/
else
    #echo "Directory ~/Github/                       [OK]"
    printf 'Directory ~/Github/ found' "$GREEN" $col '[OK]' "$RESET"
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

#------------------------------------------------------------------------------
# Copy original libphp5 file
#------------------------------------------------------------------------------
#sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
if [ -e /usr/libexec/apache2/libphp5.so ] ; then
    echo "Original libphp5-file found, copying file..."
    sudo cp /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
else
    if [ -e /usr/libexec/apache2/libphp5.so.org ] ; then
        echo "Copied file libphp5 found                     [OK]"
    else
        echo "No file libphp5 found                             [ERR]"
    fi
fi

##==============================================================================
## INSTALL SCRIPTS
##------------------------------------------------------------------------------
##------------------------------------------------------------------------------
## Install HomeBrew
##------------------------------------------------------------------------------
## This will install:
## /usr/local/bin/brew
## /usr/local/Library/...
## /usr/local/share/man/man1/brew.1
## Consider amending your PATH so that /usr/local/bin occurs before /usr/bin in your PATH.

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
brew update
brew tap homebrew/dupes
#?? brew install homebrew/dupes/grep
brew upgrade
brew doctor

## PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash

brew install apple-gcc42

#?? brew install {zsh,git,wget}
#?? brew install {ack,tmux,colordiff,ssh-copy-id,irssi,ffmpeg,gist,imagemagick,svn,hg}
brew install wget
brew install tmux

# Remove outdated versions from the cellar
brew cleanup


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


##------------------------------------------------------------------------------
## Install MySQL
##------------------------------------------------------------------------------
## http://hivelogic.com/articles/installing-mysql-on-mac-os-x/
## http://theablefew.com/blog/very-simple-homebrew-mysql-and-rails
## --------------------

## /usr/local/opt/mysql/bin/mysqladmin -u root password 'new-password'
## /usr/local/opt/mysql/bin/mysqladmin -u root -h Pooky.local password 'new-password'
##
## Alternatively you can run:
## /usr/local/opt/mysql/bin/mysql_secure_installation
##
## You can start the MySQL daemon with:
## cd /usr/local/opt/mysql ; /usr/local/opt/mysql/bin/mysqld_safe &
##
## You can test the MySQL daemon with mysql-test-run.pl
## cd /usr/local/opt/mysql/mysql-test ; perl mysql-test-run.pl

#/usr/local/Cellar/mysql/5.5.29/bin/mysqladmin -u root password 'YOUR_NEW_PASSWORD'
#/usr/local/Cellar/mysql/5.5.29/bin/mysqladmin -u root password '$MYSQL_PASSWORD'

if [ ! -e /usr/local/Cellar/mysql ] ; then
    echo "MySQL not found, installing..."
    #sudo port install mysql55 mysql55-server
    #sudo port clean --all

    brew install mysql
    unset TMPDIR
    mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
    mkdir -p ~/Library/LaunchAgents
    cp /usr/local/Cellar/mysql/5.5.29/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
    /usr/local/Cellar/mysql/5.5.29/bin/mysql_secure_installation

    #?? plutil -lint ~/Library/LaunchAgents/*.plist
    #?? sudo plutil ~/Library/LaunchAgents/*.plist -s

    mysql.server start

    sudo mkdir /var/mysql
    sudo ln -s /private/tmp/mysql.sock /var/mysql/mysql.sock
    #mysql -u root -p
else
    echo "MySQL found                               [OK]"
fi

if [ ! -e /etc/my.cfg ] ; then
    #sudo cp $(brew --prefix mysql)/support-files/my-small.cnf /etc/my.cnf
    sudo cp $(brew --prefix mysql)/support-files/my-medium.cnf /etc/my.cnf

    # https://newznab.readthedocs.org/en/latest/install/
    echo "-----------------------------------------------------------"
    echo "| Change the following information:"
    echo "| [mysqld]"
    echo "| ;max_allowed_packet = 1M"
    echo "| max_allowed_packet = 12582912"
    echo "| "
    echo "| ?? group_concat_max_len = 8192 ??"
    sudo subl /etc/my.cnf
    mysql.server restart
else
fi

##------------------------------------------------------------------------------
## Install Postgresql
##------------------------------------------------------------------------------
## You can now start the database server using:
##    postgres -D /usr/local/var/postgres
##    or
##    pg_ctl -D /usr/local/var/postgres -l logfile start

brew install postgresql --without-ossp-uuid
initdb --locale=en_US.UTF-8 --encoding=UTF8 /usr/local/var/postgres
mkdir -p ~/Library/LaunchAgents
cp /usr/local/Cellar/postgresql/9.2.2/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

if [ ! -e /var/pgsql_socket/ ] ; then
    sudo mkdir /var/pgsql_socket/
fi
sudo ln -s /private/tmp/.s.PGSQL.5432 /var/pgsql_socket/

#echo "Enter the required role name: postgres"
#createuser $POSTGRESQL_USER ENCRYPTED PASSWORD $POSTGRESQL_PASSWORD

#createuser -s -U $USER
#createuser -s -U $USER

#psqlstart
##psqlstop


##------------------------------------------------------------------------------
## Install PHP
##------------------------------------------------------------------------------
## The php.ini file can be found in:
##    /usr/local/etc/php/5.4/php.ini
## If PEAR complains about permissions, 'fix' the default PEAR permissions and config:
##    chmod -R ug+w /usr/local/Cellar/php54/5.4.11/lib/php
##    pear config-set php_ini /usr/local/etc/php/5.4/php.ini
## If you are having issues with custom extension compiling, ensure that this php is in your PATH:
##    PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
##
## To finish installing apc for PHP 5.4:
##  * /usr/local/etc/php/5.4/conf.d/ext-apc.ini was created,
## To have launchd start memcached at login:
##   ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents
## Then to load memcached now:
##    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
## Or, if you don't want/need launchctl, you can just run:
##    /usr/local/opt/memcached/bin/memcached

#brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php
brew upgrade

#??brew install php54 --with-mysql --with-pgsql --with-fpm
brew install php54 --with-pgsql --with-mysql --with-tidy --with-intl --with-gmp
brew install php54-intl
brew install php54-apc
brew install php54-memcached
brew install php54-inclued
brew install php54-http
brew install php54-oauth
brew install php54-ssh2
brew install php54-xdebug
brew install php54-mcrypt
brew install php54-imagick
#brew install gmp
#brew install php54-uploadprogress


## TESTING PHP 5.3
## To enable PHP in Apache add the following to httpd.conf and restart Apache:
##    LoadModule php5_module    /usr/local/Cellar/php53/5.3.21/libexec/apache2/libphp5.so
## The php.ini file can be found in:
##    /usr/local/etc/php/5.3/php.ini
## If you are having issues with custom extension compiling, ensure that this php is in your PATH:
##    PATH="$(brew --prefix josegonzalez/php/php53)/bin:$PATH"

brew install php53 --with-pgsql --with-mysql --with-tidy --with-intl --with-gmp
brew unlink php54 && link php53
brew install php53-intl
brew install php53-apc
brew install php53-memcached
brew install php53-inclued
brew install php53-http
brew install php53-oauth
brew install php53-ssh2
brew install php53-xdebug
brew install php53-mcrypt
brew install php53-imagick

#brew unlink php53 && brew link php54

##ERR cp /usr/local/Cellar/php54/5.4.11/homebrew-php.josegonzalez.php54.plist ~/Library/LaunchAgents/
##ERR launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php54.plist

ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist

##??sudo cp /usr/local/etc/php/5.4/php.ini.default /usr/local/etc/php/5.4/php.ini
if [ ! -f /usr/local/etc/php/5.4/php.ini ] ; then
    sudo cp /usr/local/etc/php/5.4/php.ini.default /usr/local/etc/php/5.4/php.ini
fi

if [ ! -f /private/etc/php.ini ] ; then
    sudo cp /private/etc/php.ini.default /private/etc/php.ini
fi
echo "Add/Change the following lines:"
echo "date.timezone = Europe/Amsterdam"
echo "register_globals = Off"
echo "max_execution_time = 120"
echo "memory_limit = 256M"
echo "error_reporting = E_ALL ^ E_STRICT"

echo "TESTING"
echo "serialize_precision = 100"
echo "Doesn't work: error_reporting  =  E_ALL & ~E_NOTICE"
echo "error_reporting = E_ALL & ~E_STRICT"
echo "display_startup_errors = Off"
echo "track_errors = Off"
echo "variables_order = "EGPCS""
echo "post_max_size = 128M"

sudo subl /usr/local/etc/php/5.4/php.ini
sudo subl /usr/local/etc/php/5.3/php.ini
sudo subl /private/etc/php.ini

#/usr/libexec/apache2/libphp5.so
#/usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so
#sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp53.so
#sudo ln -s /usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so

echo "Add/Change the following lines:"
echo "LoadModule php5_module /usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so"

echo "?? sudo /opt/local/apache2/bin/apxs -a -e -n "php5" mod_php54.so"
echo "?? sudo /opt/local/apache2/bin/apxs -a -e -n "php54" libphp54.so"
#sudo subl /private/etc/apache2/httpd.conf

if [ ! -e /Applications/Server.app ] ; then
    sudo subl /private/etc/apache2/httpd.conf
else
    sudo subl /private/etc/apache2/httpd.conf
    sudo subl /Library/Server/Web/Config/apache2/httpd_server_app.conf
fi

# Test apache config
/usr/sbin/httpd -t

# sudo apachectl restart
sudo apachectl start
open http://localhost

#?? sudo nano /usr/local/etc/php/5.4/php.ini

##PATH="$(brew --prefix php54)/bin:$PATH"

if [ ! -e ~/.bashrc ] ; then
cat >> ~/.bashrc << EOF
PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
EOF
else
    echo "Add the following to ~/.bashrc"
    echo "PATH="$(brew --prefix josegonzalez/php54)/bin:$PATH""
fi
source ~/.bashrc

#cat >> ~/.bashrc << EOF
#PATH="$(brew --prefix php54)/bin:$PATH"
#EOF
#PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"


##------------------------------------------------------------------------------
## Install PEAR
##------------------------------------------------------------------------------
sudo php /usr/lib/php/install-pear-nozlib.phar

echo "Change the following line"
#echo 'include_path = ".:/usr/lib/php/pear"'
echo "include_path=".:/usr/local/Cellar/php54/5.4.11/lib/php:/usr/local/Cellar/php54/5.4.11/lib/php/PEAR""
sudo subl /usr/local/etc/php/5.4/php.ini
#sudo subl /etc/php.ini

pear config-set php_ini /usr/local/etc/php/5.4/php.ini
pecl config-set php_ini /usr/local/etc/php/5.4/php.ini
sudo pear upgrade-all

#pear config-set php_ini /etc/php.ini
#pecl config-set php_ini /etc/php.ini
#sudo pear upgrade-all

#if [ ! -f ~/.profile ] ; then
#    cat >> ~/.profile <<'EOF'
### Add PHP 5.4 to the path
#PHP_PATH="$(brew --prefix php54)/bin"
#export PATH=$PHP_PATH:$PATH
#EOF
#else
#    echo 'Add/Change the following lines:'
#    echo '## Add PHP 5.4 to the path'
#    echo 'PHP_PATH="$(brew --prefix php54)/bin'
#    echo 'export PATH=$PHP_PATH:$PATH'
#    subl ~/.profile
#fi

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


#------------------------------------------------------------------------------
# Create and open phpinfo.php
#------------------------------------------------------------------------------
## /Library/Server/Web/Config/apache2/httpd_server_app.conf
#sudo subl /Library/Server/Web/Config/apache2/httpd_server_app.conf
#echo "Add/Change the following lines:"
#echo 'DocumentRoot "/Library/WebServer/Documents"'

#SUDO_EDITOR="open -FWne" sudo -e /etc/apache2/httpd.conf
cat >> /tmp/php_info.php <<'EOF'
<?php

// Show all information, defaults to INFO_ALL
phpinfo();

?>
EOF

sudo mv /tmp/php_info.php /Library/WebServer/Documents/
open http://localhost/php_info.php

#------------------------------------------------------------------------------
# Install Spotweb
#------------------------------------------------------------------------------
#export PATH=$PATH:/usr/local/opt/postgresql/bin
sudo -u andries psql postgres -c "create database spotweb_db"
sudo -u andries psql postgres -c "create user spotweb_user with password 'spotweb_user'"
sudo -u andries psql postgres -c "grant all privileges on database spotweb_db to spotweb_user"

open /Applications/pgAdmin3.app
echo "Open pgAdmin and set the password of user: spotweb_user"


## Not used, postgresql instead of MySQL
#echo "-----------------------------------------------------------"
#echo "Enter the following in MySQL:"
#echo "CREATE DATABASE spotweb;"
#echo "CREATE USER spotweb@'localhost' IDENTIFIED BY 'mini_spotweb';"
#echo "GRANT ALL PRIVILEGES ON spotweb.* TO spotweb @'localhost' IDENTIFIED BY 'mini_spotweb';"
#echo "flush privileges;"
#echo "quit"
#echo "-----------------------------------------------------------"

#cd /Library/WebServer/Documents/
#sudo git clone https://github.com/spotweb/spotweb.git
#subl /Library/WebServer/Documents/spotweb/dbsettings.inc.php

sudo mkdir -p /Users/Spotweb/Sites/
sudo mkdir -p /Users/Spotweb/Sites/log/
cd /Users/Spotweb/Sites/
sudo git clone https://github.com/spotweb/spotweb.git

sudo ln -s /Users/Spotweb/Sites/spotweb/ /Library/WebServer/Documents/spotweb
## -------------> TODO

open http://localhost/spotweb/install.php
subl /Users/Spotweb/Sites//spotweb/dbsettings.inc.php

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Type                          : PostgreSQL"
echo "| Server                        : localhost"
echo "| Database                      : spotweb_db"
echo "| Username                      : spotweb_user"
echo "| Password                      : <password>"
echo "-----------------------------------------------------------"
echo "| Usenet Server                 : XsNews"
echo "| User Name                     : 105764"
echo "-----------------------------------------------------------"

sudo touch /Users/Spotweb/Sites/spotweb/dbsettings.inc.php
sudo subl /Users/Spotweb/Sites/spotweb/dbsettings.inc.php

#/Library/WebServer/Documents/spotweb/retrieve.php
#sh php /Library/WebServer/Documents/spotweb/retrieve.php
#/bin/bash php /Library/WebServer/Documents/spotweb/retrieve.php

open http://localhost/spotweb

osascript -e 'tell app "Terminal"
    do script "php /Users/Spotweb/Sites/spotweb/retrieve.php"
end tell'

### FORCED QUIT ####
#exit 1

# ?????????????????????????????????????????????????????????????????????????????
#------------------------------------------------------------------------------
# Configure Spotweb as a Newznab Provider
#------------------------------------------------------------------------------
## !!!  Create normal user(s) in Spotweb for the API calls, not the ADMIN account !!!
##
## --------------------
## http://mar2zz.tweakblogs.net/blog/6724/spotweb-als-provider.html#more
##
## /etc/apache2/sites-enabled/blahdieblah (hier naam van bestand of website invullen)
## <VirtualHost *:8080>
##     ServerAdmin blahblah@gmail.com
## 
##     DocumentRoot /var/www
##     <Directory />
##         Options FollowSymLinks
##         AllowOverride None
##     </Directory>
##     <Directory /var/www/>
##         Options Indexes FollowSymLinks MultiViews
##         AllowOverride None
##         Order allow,deny
##         allow from all
##     </Directory>
##     ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
##     <Directory "/usr/lib/cgi-bin">
##         AllowOverride None
##         Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
##         Order allow,deny
##         Allow from all
##     </Directory>
##
## etc etc etc....
## </VirtualHost>
##
## Add:
## <Directory /Users/Spotweb/Sites/spotweb/>
##    RewriteEngine on
##    RewriteCond %{REQUEST_URI} !api/
##    RewriteRule ^api/?$ index.php?page=newznabapi [QSA,L]
##    Options Indexes FollowSymLinks Multiviews
##    AllowOverride None
##    Order allow,deny
##    allow from all
## </Directory>
##
## sudo a2enmod rewrite
## sudo apachectl restart
##
## Check for XML output:
## open http://localhost/spotweb/api?t=c
##
## --------------------
## https://github.com/spotweb/spotweb/wiki/Spotweb-als-Newznab-Provider
##
## Open the page to your CouchPotato configuration (http://url.to.your.couchpotato/config/) and click Providers.
## The item Newznab is listed on this page, you need to enter both a host and an API-key.
## For Host you'll enter http://localhost/spotweb/?page=newznabapi (please change to match your servername)
## For Apikey you need to enter the API key of Spotweb. You can find it in Spotweb by navigating to "Change user" from the main page.
##
## Enable:
## mod_rewrite
## AllowOverride
## 
## file .htaccess:
## RewriteEngine on
## RewriteCond %{REQUEST_URI} !api/
## RewriteRule api/?$ /spotweb/index.php?page=newznabapi [QSA,L]
## 
## sudo a2enmod rewrite
## sudo apachectl restart
## 
## Check for XML output:
## open http://localhost/spotweb/api?t=c
##
## Sick Beard:
## 1. Bij Provider Name kun je zelf bepalen hoe je het wilt noemen, bijvoorbeeld Spotweb.
## 2. Bij Site URL vul je http://server/spotweb/ in (uiteraard na aanpassing aan de eigen omgeving).
## 3. Bij API Key vul je de API-key van Spotweb in. Deze is in Spotweb te vinden onder Gebruiker wijzigen
## open http://localhost:8081/config/providers/
##
## CouchPotato:
## 1. Bij Host vul je server/spotweb in (uiteraard na aanpassing aan de eigen omgeving).
## 2. Bij Apikey vul je de API-key van Spotweb in. Deze is in Spotweb te vinden onder Gebruiker wijzigen
## Op de pagina http://url.naar.couchpotato/config/ en klik op Providers. Op die pagina staat het onderdeel Newznab. Hier dien je een host en een API-key op te geven.
## open open http://localhost:8081/config
##
## Headphones:
## 1. Vink Newznab aan.
## 2. Bij Newznabhost vul je server/spotweb in.
## 3. Bij API Key vul je de API-key van Spotweb in. Deze is in Spotweb te vinden onder Gebruiker wijzigen
## Op de pagina http://url.naar.headphones/config staat Newznab onder Providers.
## --------------------
## http://patrickscholten.com/spotweb-gebruiken-als-newznab-server/
## --------------------

#sudo apachectl restart

#------------------------------------------------------------------------------
# Install Python
#------------------------------------------------------------------------------
## Distribute and Pip have been installed. To update them
##   pip install --upgrade distribute
##   pip install --upgrade pip
## 
## To symlink "Idle" and the "Python Launcher" to ~/Applications
##   `brew linkapps`
## Executable python scripts will be put in:
##  /usr/local/share/python
## so you may want to put "/usr/local/share/python" in your PATH, too.

brew install python
pip install --upgrade distribute
pip install --upgrade pip
brew linkapps
sudo easy_install pip

## Install Powerline
## https://github.com/Lokaltog/powerline-fonts
pip install --user git+git://github.com/Lokaltog/powerline
cd ~/Githug
git clone https://github.com/Lokaltog/powerline-fonts.git

#------------------------------------------------------------------------------
# Install NewzNAB
#------------------------------------------------------------------------------
## Sphinx (http://sphinxsearch.com)

## http://mar2zz.tweakblogs.net/blog/6947/newznab.html#more

#sudo mkdir -p /Library/WebServer/Documents/Newznab/
#cd /Library/WebServer/Documents/Newznab/

## ERR:
#brew install sphinx

brew install unrar

sudo mkdir -p /Users/Newznab/Sites/newznab/
cd /Users/Newznab/Sites/newznab/

echo "-----------------------------------------------------------"
echo "Enter the following inoformation:"
echo "Username              : svnplus"
echo "Password              : svnplu5"
sudo svn co svn://nnplus@svn.newznab.com/nn/branches/nnplus /Users/Newznab/Sites/newznab

sudo mkdir /Users/Newznab/Sites/newznab/nzbfiles/tmpunrar
sudo chmod 777 /Users/Newznab/Sites/newznab/www/lib/smarty/templates_c
sudo chmod 777 /Users/Newznab/Sites/newznab/www/covers/movies
sudo chmod 777 /Users/Newznab/Sites/newznab/www/covers/anime
sudo chmod 777 /Users/Newznab/Sites/newznab/www/covers/music
sudo chmod 777 /Users/Newznab/Sites/newznab/www
sudo chmod 777 /Users/Newznab/Sites/newznab/www/install
sudo chmod -R 777 /Users/Newznab/Sites/newznab/nzbfiles/
sudo chmod 777 /Users/Newznab/Sites/newznab/db
sudo chmod 777 /Users/Newznab/Sites/newznab/nzbfiles/tmpunrar

sudo ln -s /Users/Newznab/Sites/newznab/www/ /Library/WebServer/Documents/newznab

echo "-----------------------------------------------------------"
echo "Enter the httpd.conf:"
echo "<Directory /Library/WebServer/Documents/newznab>"
echo "    Options FollowSymLinks"
echo "    AllowOverride All"
echo "    Order deny,allow"
echo "    Allow from all"
echo "</Directory>"
echo "-----------------------------------------------------------"
sudo subl /etc/apache2/httpd.conf

echo "-----------------------------------------------------------"
echo "Enter the following in MySQL:"
echo "CREATE DATABASE newznab;"
echo "CREATE USER 'newznab'@'localhost' IDENTIFIED BY 'mini_newznab';"
echo "GRANT ALL PRIVILEGES ON newznab.* TO newznab @'localhost' IDENTIFIED BY 'mini_newznab';"
echo "FLUSH PRIVILEGES;"
echo "-----------------------------------------------------------"
open mysql -u root -p

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Hostname                      : localhost"
echo "| Port                          : 3306"
echo "| Username                      : newznab"
echo "| Password                      : <password>"
echo "| Database                      : newznab"
echo "| DB Engine                     : MyISAM"
echo "-----------------------------------------------------------"
echo "| News Server Setup:"
echo "| Server                        : reader.xsnews.nl"
echo "| User Name                     : 105764"
echo "| Password                      : <password>"
echo "| Port                          : 563"
echo "| SSL                           : Enable"
echo "-----------------------------------------------------------"
echo "| Caching Setup:"
echo "| Caching Type                  : Memcache"
echo "-----------------------------------------------------------"
echo "| Admin Setup:"
echo "-----------------------------------------------------------"
echo "| NZB File Path Setup           : /Users/Newznab/Sites/newznab/nzbfiles/"
echo "-----------------------------------------------------------"
open http://localhost/newznab

echo "-----------------------------------------------------------"
echo "| newznab ID                    : <nnplus id>"
echo "| Unrar Path                    : /usr/local/bin/unrar"

echo "|*Integration Type              : Site Wide"
echo "| SABnzbd Url                   : http://localhost:8080/sabnzbd/"
echo "| SABnzbd Api Key               : (http://localhost:8080/config/general/)"
echo "| Api Key Type                  : Full Api Key"

echo "| Minimum Completion Percent    : 90"
echo "| Start new groups              : Days, 1"

echo "| Check For Passworded Releases : Deep"
echo "| Delete Passworded Releases    : Yes"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/site-edit.php

echo "-----------------------------------------------------------"
echo "| Enable categories:"
echo "| a.b.teevee"
echo "|"
echo "| For extended testrun:"
echo "| a.b.multimedia"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/group-list.php


## --- TESTING

cd /Users/Newznab/Sites/newznab/misc/update_scripts
##php update_binaries.php && php update_releases.php
##php update_binaries.php
##php update_releases.php

cp newznab_screen.sh newznab_local.sh

echo "-----------------------------------------------------------"
echo "| Update the following:"
echo "| export NEWZNAB_PATH="/Users/Newznab/Sites/newznab/misc/update_scripts""
echo "| /usr/bin/php5 => /usr/local/Cellar/php54/5.4.11/bin/php"
subl newznab_local.sh

echo "-----------------------------------------------------------"
echo "| Add the following newsgroup:"
echo "| Name                          : alt.binaries.nl"
echo "| Backfill Days                 : 1"
open http://localhost/newznab/admin/group-edit.php

echo "-----------------------------------------------------------"
echo "| Add the following RegEx:"
echo "| Group                         : alt.binaries.nl"
echo "| RegEx                         : /^.*?"(?P<name>.*?)\.(sample|mkv|Avi|mp4|vol|ogm|par|rar|sfv|nfo|nzb|web|rmvb|srt|ass|mpg|txt|zip|wmv|ssa|r\d{1,3}|7z|tar|cbr|cbz|mov|divx|m2ts|rmvb|iso|dmg|sub|idx|rm|t\d{1,2}|u\d{1,3})/iS""
echo "| Ordinal                       : 5"
open http://localhost/newznab/admin/group-edit.php

chmod +x newznab_local.sh
cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/
./newznab_local.sh

# screen bash
#screen
#./newznab_local.sh
#echo "ctrl-ad to detach screen"


## Additional custom NewzNAB Themes
mkdir -p ~/Github/
cd ~/Github/
git clone https://github.com/jonnyboy/Newznab-Simple-Theme.git
cp -r Newznab-Simple-Theme/simple /Users/Newznab/Sites/newznab/www/templates/simple
git clone https://github.com/sinfuljosh/bootstrapped.git
cp -r bootstrapped /Users/Newznab/Sites/newznab/www/templates/bootstrapped

## Install custom NewzNAB Update Script
## - https://github.com/NNScripts/nn-custom-scripts
mkdir -p /Users/Newznab/Sites/newznab/misc/custom
git clone https://github.com/NNScripts/nn-custom-scripts.git /Users/Newznab/Sites/newznab/misc/custom
echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| define('REMOVE', false);           : define('REMOVE', true);"
echo "-----------------------------------------------------------"
subl /Users/Newznab/Sites/newznab/misc/custom/remove_blacklist_releases.php

echo "-----------------------------------------------------------"
echo "| Install jonnyboy/newznab-tmux"
echo "-----------------------------------------------------------"
## https://github.com/jonnyboy/newznab-tmux.git

brew install htop
brew install iftop
brew install watch

cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/
git clone https://github.com/jonnyboy/newznab-tmux.git tmux
cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux

echo "-----------------------------------------------------------"
echo "| Backing up current MySQL database..."
echo "-----------------------------------------------------------"
mysqldump --opt -u root -p newznab > ~/newznab_backup.sql

echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| export NEWZPATH="/var/www/newznab" : export NEWZPATH="/Users/Newznab/Sites/newznab""
echo "| export BINARIES="false"            : export BINARIES="true""
echo "| *export BINARIES_THREADS="false"   : export BINARIES_THREADS="true""
echo "| export RELEASES="false"            : export RELEASES="true""
echo "| export OPTIMIZE="false"            : export OPTIMIZE="true""
echo "| export CLEANUP="false"             : export CLEANUP="true""
echo "| export PARSING="false"             : export PARSING="true""
echo "| export SPHINX="true"               : export SPHINX="true""
echo "| export SED="/bin/sed"              : export SED="/usr/bin/sed""
echo "| "
echo "| TESTING:"
echo "| export USE_HTOP="false"            : export USE_HTOP="true""
echo "| export USE_NMON="false"            : ??" 
echo "| export USE_BWMNG="false"           : ??"
echo "| export USE_IOTOP="false"           : ??"
echo "| export USE_MYTOP="false"           : ??"
echo "| export USE_VNSTAT="false"          : ??"
echo "| export USE_IFTOP="false"           : export USE_IFTOP="true""
echo "| export POWERLINE="false"           : ??"
echo "| "
echo "| Use tmpfs to run postprocessing on true/false"
echo "| export RAMDISK="false"             : ??"

echo "| export AGREED="no"                 : export AGREED="yes""
echo "-----------------------------------------------------------"
cp config.sh defaults.sh
subl defaults.sh

echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| export NEWZPATH="/var/www/newznab" : export NEWZPATH="/Users/Newznab/Sites/newznab""
echo "-----------------------------------------------------------"
subl /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/scripts/check_svn.sh 

echo "-----------------------------------------------------------"
export NEWZPATH="/Users/Newznab/Sites/newznab"
export PASSWORD="<password>"
echo "-----------------------------------------------------------"
subl /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/scripts/update_svn.sh 

cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/scripts
sudo ./set_perms.sh

cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/
./start.sh

### ERR:
## PHP Fatal error:  Call to a member function fetch_assoc() on a non-object in /Users/Newznab/Sites/newznab/www/lib/framework/db.php on line 193
## PHP Stack trace:
## PHP   1. {main}() /Users/Newznab/Sites/newznab/misc/update_scripts/update_releases.php:0
## PHP   2. Sphinx->update() /Users/Newznab/Sites/newznab/misc/update_scripts/update_releases.php:10
## PHP   3. DB->getAssocArray() /Users/Newznab/Sites/newznab/www/lib/sphinx.php:322
##
## Fatal error: Call to a member function fetch_assoc() on a non-object in /Users/Newznab/Sites/newznab/www/lib/framework/db.php on line 193
########


#------------------------------------------------------------------------------
# Install Sphinx
#------------------------------------------------------------------------------
## http://newznab.readthedocs.org/en/latest/misc/sphinx/

## ?? brew install sphinx
## /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf

echo "Download latest Sphinx from http://sphinxsearch.com"
#open http://sphinxsearch.com/

curl -O http://sphinxsearch.com/files/sphinx-2.0.6-release.tar
tar xvzf sphinx-2.0.6-release.tar
cd sphinx-2.0.6-release

./configure -prefix=/usr/local/bin --with-pgsql --with-mysql
make
make install

#### Not needed due to brew install apple-gcc42 ??
#gcc -v
#cd /usr/bin
#sudo ln -s gcc gcc-4.2
####

## which searchd
## /usr/local/bin/searchd
## which indexer
## /usr/local/bin/indexer

cd /Users/Newznab/Sites/newznab/misc/sphinx
./nnindexer.php generate

echo "Creating Lauch Agent file:"
cat >> /tmp/com.nnindexer.nnindexer.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.nnindexer.nnindexer</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/php</string>
        <string>nnindexer.php</string>
        <string>--daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/Users/Newznab/Sites/newznab/misc/sphinx</string>
</dict>
</plist>
EOF
mv /tmp/com.nnindexer.nnindexer.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.nnindexer.nnindexer.plist

./nnindexer.php daemon
./nnindexer.php index full all
./nnindexer.php index delta all
./nnindexer.php daemon --stop
./nnindexer.php daemon

#### ERR:
## WARNING: index 'releases': preload: failed to open /Users/Newznab/Sites/newznab/db/sphinxdata/releases.sph: No such file or directory; NOT SERVING
## precaching index 'releases_delta'

## /Users/Newznab/Sites/newznab/db/sphinxdata
## indexer --config /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf --all

## ./nnindexer.php search --index releases "some search term"


echo "-----------------------------------------------------------"
echo "| Configure Sphinx:"
echo "| Use Sphinx                 : Yes"
echo "| Sphinx Configuration Path  : <full path to sphinx.conf>"
echo "| Sphinx Binaries Path       : /usr/local/bin/"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin


#------------------------------------------------------------------------------
# Install SABnzbd+
#------------------------------------------------------------------------------

mkdir -p ~/Downloads/Usenet/Incomplete
mkdir -p ~/Downloads/Usenet/Complete
mkdir -p ~/Downloads/Usenet/Watch

if [ ! -e /Applications/SABnzbd.app ] ; then
    echo "SABnzbd not installed, please install..."
    open http://sabnzbd.org/
    while ( [ ! -e /Applications/SABnzbd.app ] )
    do
        echo "Waiting for SABnzbd to be installed..."
        sleep 15
    done
else
    echo "SABnzbd found                               [OK]"
fi

echo "-----------------------------------------------------------"
echo "| News Server Setup:"
echo "| Server            : reader.xsnews.nl"
echo "| Port              : 563"
echo "| User Name         : 105764"
echo "| Password          : <password>"
echo "| SSL               : Enable"
echo "-----------------------------------------------------------"
echo "| Step 2"
echo "| Access            : I want SABnzbd to be viewable by any pc on my network."
echo "| Password          : Enable"
echo "| HTTPS             : Enable"
echo "| Launch            : Disable"
echo "-----------------------------------------------------------"

open https://localhost:8080/sabnzbd/ 

echo "-----------------------------------------------------------"
echo "| Folders:"
echo "1G"
echo "/Users/Andries/Downloads/Usenet/Incomplete"
echo "/Users/Andries/Downloads/Usenet/Complete"
echo "/Users/Andries/Downloads/Usenet/Watch"
echo "300"
echo "/Users/Andries/Library/Application Support/SABnzbd/scripts"
echo "-----------------------------------------------------------"
echo "| Categories:"
echo "| anime, Default, Default, Default"
echo "| apps, Default, Default, Default"
echo "| books, Default, Default, Default"
echo "| consoles, Default, Default, Default"
echo "| games, Default, Default, Default"
echo "| movies, Default, Default, Default"
echo "| music, Default, Default, Default"
echo "| pda, Default, Default, Default"
echo "| tv, Default, Default, Default"
echo "-----------------------------------------------------------"

echo "Creating Lauch Agent file:"
cat >> /tmp/com.sabnzbd.SABnzbd.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.sabnzbd.SABnzbd</string>
  <key>ProgramArguments</key>
  <array>
     <string>/usr/bin/open</string>
     <string>-a</string>
      <string>/Applications/SABnzbd.app</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF

mv /tmp/com.sabnzbd.SABnzbd.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.sabnzbd.SABnzbd.plist

#------------------------------------------------------------------------------
# Install Cheetah
#------------------------------------------------------------------------------
echo "Download latest Cheetah:"
open http://www.cheetahtemplate.org/download

tar xvzf Cheetah-2.4.4.tar
cd Cheetah-2.4.4.tar
sudo python setup.py install

#------------------------------------------------------------------------------
# Install Sick-Beard
#------------------------------------------------------------------------------
### ----------------------------------------
### http://jetshred.com/2012/07/26/installing-sickbeard-on-os-x-10-dot-8/
### Since daemon mode is what’s not working all that’s necessary to get around the bug is to not use daemon mode. Here it is:
### --------------------
### This script starts SickBeard and suppressed the output so
### that it runs as if in daemon mode while avoiding the daemon mode
### issue. Once you have changed the settings
### save this script as an Application and add it to your Login Items.
##
###Change the following line to the path to your SickBeard folder
##set pathToSickBeard to "~/Development/Sick-Beard"
##
###You probably don't want to change anything below here
##do shell script "python " & pathToSickBeard & "/SickBeard.py > /dev/null 2>&1 &"
### ----------------------------------------

echo "Install latest Sick-Beard:"

mkdir -p ~/Andries/Github/
cd ~/Andries/Github/
git clone https://github.com/clinton-hall/nzbToMedia
cp -R ~/Andries/Github/nzbToMedia/* ~/Library/Application\ Support/SABnzbd/scripts/
#cp /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/

cd ~/Library/Application\ Support/SABnzbd/scripts/
cp autoProcessTV.cfg.sample autoProcessTV.cfg 
cp autoProcessMovie.cfg.sample autoProcessMovie.cfg
echo "-----------------------------------------------------------"
echo "| Modify the following:"
echo "| port=8081"
echo "| username=couchpotato"
echo "| password=<password>"
echo "| web_root="
echo "-----------------------------------------------------------"
subl autoProcessTV.cfg 

cd /Applications
sudo git clone git://github.com/midgetspy/Sick-Beard.git
sudo chown -R andries:staff /Applications/Sick-Beard/
cd Sick-Beard
#?? python /Applications/Sick-Beard/CouchPotato.py sickbeard.py  -d -q
python /Applications/Sick-Beard/sickbeard.py

#open http://localhost:8081

echo "-----------------------------------------------------------"
echo "| Menu, Config, General:"
echo "| Launch Browser    : disable"
echo "| User Name         : sickbeard"
echo "| Password          : <password>"
echo "| Enable API        : enable"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Search Settings:"
echo "| Enable API        : enable"
echo "| Search Frequency  : 15"
echo "| Usenet Retention  : 1000"
echo "| NZB Search        : enable"
echo "| NZBMethod         : SABnzbd"
echo "| SABnzbd URL       : http://localhost:8080"
echo "| SABnzbd Username  : sabnzbd"
echo "| SABnzbd Password  : <password>"
echo "| SABnzbd API Key   : (from SABnzb (http://localhost:8080/config/general/)"
echo "| SABnzbd Category  : tv"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Search Providers"
echo "| Sick Beard Index  : Enable"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Post Processing"
echo "| Keep original files : Uncheck"
echo "| Name Pattern      : Season %0S/%SN S%0SE%0E %QN-%RG"
echo "| Multi-Episode     : Extend"
echo "-----------------------------------------------------------"
echo "| Menu, Config, Categories:"
echo "| tv, Default, Default, nzbToSickBeard.py"
echo "-----------------------------------------------------------"
open http://localhost:8080/config/switches/

##### ????
## http://jetshred.com/2012/07/31/configuring-sickbeard-to-work-with-sabnzbd-plus/
## tv, Default, Default, sabToSickBeard.py, /Users/Andries/Media/Series
##### ????

#sudo python /Applications/Sick-Beard/sickbeard.py –d
#sudo python /Applications/Sick-Beard/sickbeard.py -q --nolaunch

echo "Creating Lauch Agent file:"
cat >> /tmp/com.sickbeard.sickbeard.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>Label</key>
    <string>com.sickbeard.sickbeard</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python</string>
        <string>SickBeard.py</string>
        <string>-q</string>
        <string>--nolaunch</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/Applications/Sick-Beard</string>
</dict>
</plist>
EOF

mv /tmp/com.sickbeard.sickbeard.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.sickbeard.sickbeard.plist

#------------------------------------------------------------------------------
# Install CouchPotato
#------------------------------------------------------------------------------
## http://christopher-williams.net/2011/02/automating-your-movie-downloads-with-sabnzbd-and-couchpotato/

echo "Download latest CouchPotato:"
#open http://couchpotatoapp.com
open https://couchpota.to/updates/latest/osx/

sudo mv ~/Downloads/CouchPotato.app /Applications
open /Applications/CouchPotato.app

#?? python ~/Downloads/CouchPotato.app/CouchPotato.py -d

echo "-----------------------------------------------------------"
echo "| Enter the following settings:"
echo "| username          : couchpotato"
echo "| password          : <password>"
echo "| port              : 8082"
echo "| Lauch Browser     : Uncheck"
echo "-----------------------------------------------------------"
echo "| Download Apps:"
echo "| SABNnzbd:"
echo "| SABnzbd URL       : localhost:8080"
echo "| SABnzbd API Key   : (from SABnzb (http://localhost:8080/config/general/)"
echo "| SABnzbd Category  : movies"
echo "-----------------------------------------------------------"

## --- MODIFIED ---
echo "-----------------------------------------------------------"
echo " Settings, Searcher :"
echo " Preferrd Words     : dutch"
echo " Ignored Words      : <remove dutch>"
echo " Retention          : 1000"
echo "-----------------------------------------------------------"
open http://localhost:8082

echo "-----------------------------------------------------------"
echo "| Modify the following:"
echo "| port=8082"
echo "| username=couchpotato"
echo "| password=<password>"
echo "| apikey = <Couchpotato API Key>"
echo "-----------------------------------------------------------"
subl autoProcessMovie.cfg 

echo "-----------------------------------------------------------"
echo "| Menu, Config, Categories:"
echo "| movies, Default, Default, nzbToCouchpotato.py"
echo "-----------------------------------------------------------"
open http://localhost:8080/config/switches/


### --- TESTING ---
#echo "Creating Lauch Agent file:"
#cat >> /tmp/com.couchpotato.couchpotato.plist <<'EOF'
#<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#<plist version="1.0">
#<dict>
#  <key>Label</key>
#  <string>com.couchpotato.couchpotato</string>
#  <key>ProgramArguments</key>
#  <array>
#      <string>/usr/local/bin/python</string>
#      <string>/Applications/CouchPotato.app/CouchPotato.py</string>
#  </array>
#  <key>RunAtLoad</key>
#  <true/>
#</dict>
#</plist>
#EOF

#cat >> /tmp/com.couchpotato.couchpotato.plist <<'EOF'
#<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#<plist version="1.0">
#<dict>
#    <key>Label</key>
#    <string>com.couchpotato.couchpotato</string>
#    <key>ProgramArguments</key>
#    <array>
#        <string>/usr/bin/python</string>
#        <string>CouchPotato.py</string>
#        <string>--quiet</string>
#        <string>--daemon</string>
#    </array>
#    <key>RunAtLoad</key>
#    <true/>
#    <key>WorkingDirectory</key>
#    <string>/Applications/CouchPotato.app</string>
#</dict>
#</plist>
#EOF

#
#<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#<plist version="1.0">
#<dict>
#    <key>Label</key>
#    <string>com.couchpotato.couchpotato</string>
#    <key>OnDemand</key>
#    <false/>
#    <key>ProgramArguments</key>
#    <array>
#    <string>python</string>
#    <string>/Applications/CouchPotato.app/CouchPotato.py</string>
#    </array>
#    <key>RunAtLoad</key>
#    <true/>
#    <key>WorkingDirectory</key>
#    <string>/Applications/CouchPotato.app/</string>
#    <key>ServiceDescription</key>
#    <string>CouchPotato</string>
#</dict>
#</plist>

#<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#<plist version="1.0">
#<dict>
#  <key>Label</key>
#  <string>com.couchpotato.couchpotato</string>
#  <key>ProgramArguments</key>
#  <array>
#     <string>/usr/local/bin/python</string>
#     <string>/Applications/CouchPotato.app/CouchPotato.py</string>
#  </array>
#  <key>RunAtLoad</key>
#  <true/>
#</dict>
#</plist>
#

#mv /tmp/com.couchpotato.couchpotato.plist ~/Library/LaunchAgents/
#launchctl load ~/Library/LaunchAgents/com.couchpotato.couchpotato.plist
#
#launchctl start ~/Library/LaunchAgents/com.couchpotatoserver.couchpotato.plist

#------------------------------------------------------------------------------
# Install Auto-Sub
#------------------------------------------------------------------------------
echo "Download latest Auto-Sub:"
#open http://couchpotatoapp.com
open http://code.google.com/p/auto-sub/

sudo mv ~/Downloads/auto-sub /Applications/
sudo python /Applications/auto-sub/AutoSub.py

echo "-----------------------------------------------------------"
echo "| Click main menu item Config (niet sub-menu item(s)), General:"
echo "| Rootpath          : /TV/Series"
echo "| Subtitle English  : nl"

echo "Creating Lauch Agent file:"
cat >> /tmp/com.autosub.autosub.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.autosub.autosub</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python</string>
        <string>AutoSub.py</string>
        <string>--config</string>
        <string>/Applications/auto-sub/config.properties</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/Applications/auto-sub</string>
</dict>
</plist>
EOF

sudo mv /tmp/com.autosub.autosub.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.autosub.autosub.plist
#launchctl start ~/Library/LaunchAgents/com.autosub.autosub.plist

#------------------------------------------------------------------------------
# Install Maraschino
#------------------------------------------------------------------------------
cd /Applications
git clone https://github.com/mrkipling/maraschino.git
cd maraschino
sudo python /Applications/maraschino/Maraschino.py

open http://localhost:7000











# ?????????????????????????????????????????????????????????????????????????????
#------------------------------------------------------------------------------
# Install LazyLibrarian
#------------------------------------------------------------------------------
## https://github.com/itsmegb/LazyLibrarian
