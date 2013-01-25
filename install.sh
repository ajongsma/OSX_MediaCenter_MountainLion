if [[ "$OSTYPE" =~ ^darwin ]]; then
  os="Mac"
  app_file="chrome-mac.zip"
  app_path="/Applications"
  echo "OS X Detected								[OK]"
else
  echo "Linux unsupported (for now)."
  exit 1
fi

#------------------------------------------------------------------------------
# Checking if system is up-to-date
#------------------------------------------------------------------------------
# run software update and reboot
#sudo softwareupdate --list
#sudo softwareupdate --install --all

#------------------------------------------------------------------------------
# Checking existance mandatory directories
#------------------------------------------------------------------------------
if [ ! -e ~/Sites/ ] ; then
    echo "Creating directory: Sites"
    mkdir -p ~/Sites/
else
    echo "Directory ~/Sites/ 	    				[OK]"
fi
if [ ! -e ~/Github/ ] ; then
    echo "Creating directory: Github"
    mkdir -p ~/Github/
else
    echo "Directory ~/Github/ 	    				[OK]"
fi

#------------------------------------------------------------------------------
# Check for installation Xcode
#------------------------------------------------------------------------------
if [ ! -e /Applications/Xcode.app ] ; then
    echo "Xcode not installed, please install..."
    open http://itunes.apple.com/us/app/xcode/id497799835?mt=12
	while ( [ ! -e /Applications/Xcode.app ] )
	do
    	echo "Waiting for Xcode to be installed..."
		sleep 15
	done
	sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
else
    echo "Xcode found								[OK]"
fi

#------------------------------------------------------------------------------
# Check for Command Line Tools via GCC
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/gcc ] ; then
    echo "GCC not installed, please install..."
	while ( [ $(which gcc) == "" ] )
	do
    	echo "Waiting for GCC to be installed..."
		sleep 15
	done
else
    echo "GCC found								[OK]"
fi

#------------------------------------------------------------------------------
# Check for Java
#------------------------------------------------------------------------------
if [ ! -e /usr/bin/java ] ; then
    echo "Java not installed, please install..."
	while ( [ $(which java) == "" ] )
	do
    	echo "Waiting for Java to be installed..."
		sleep 15
	done
else
    echo "Java found								[OK]"
fi

#------------------------------------------------------------------------------
# Check for OS X Server 2.0
#------------------------------------------------------------------------------
if [ ! -e /Applications/Server.app ] ; then
    echo "OS X Server not installed, please install..."
    open https://itunes.apple.com/nl/app/os-x-server/id537441259?mt=12
	while ( [ ! -e /Applications/Server.app ] )
	do
    	echo "Waiting for OS X Server to be installed..."
		sleep 15
	done
else
    echo "OS X Server found							[OK]"
fi

#------------------------------------------------------------------------------
# Check for Sublime Text
#------------------------------------------------------------------------------
if [ ! -e /Applications/Sublime\ Text\ 2.app ] ; then
    echo "Sublime Text not installed, please install..."
    open http://www.sublimetext.com
	while ( [ ! -e /Applications/Sublime\ Text\ 2.app ] )
	do
    	echo "Waiting for Sublime Text to be installed..."
		sleep 15
	done
else
    echo "Sublime Text found							[OK]"
fi
if [ ! -e /usr/local/bin/subl ] ; then
	echo "Creating link to Sublime Text..."
	mkdir /usr/local/bin/
	ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
else
    echo "Sublime Text link found						[OK]"
fi

#------------------------------------------------------------------------------
# Git config
#------------------------------------------------------------------------------
git config --global user.name "Andries Jongsma"
git config --global user.email "a.jongsma@gmail.com"

#------------------------------------------------------------------------------
# Check for install HomeBrew (http://mxcl.github.com/homebrew/)
#------------------------------------------------------------------------------
while ( [ $(which gcc) == "" ] )
do
    echo "Waiting for HomeBrew to be installed..."
    sleep 15
done

#------------------------------------------------------------------------------
# Moving original libphp5 file
#------------------------------------------------------------------------------
#sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
if [ -e //usr/libexec/apache2/libphp5.so ] ; then
	echo "Original libphp5-file found, renaming file..."
    sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so.org
else
	if [ -e //usr/libexec/apache2/libphp5.so.org ] ; then
		echo "Renamed file libphp5 found						[OK]"
	else
		echo "No file libphp5 found								[ERR]"
	fi
fi

#------------------------------------------------------------------------------
# INSTALL SCRIPTS
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Install HomeBrew
#------------------------------------------------------------------------------
# This will install:
# /usr/local/bin/brew
# /usr/local/Library/...
# /usr/local/share/man/man1/brew.1

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
brew update
brew tap homebrew/dupes
brew upgrade
brew doctor

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash

# Remove outdated versions from the cellar
brew cleanup

#------------------------------------------------------------------------------
# Install Bash Completion
#------------------------------------------------------------------------------
brew install bash-completion git

#Add the following lines to your ~/.bash_profile:
#  if [ -f $(brew --prefix)/etc/bash_completion ]; then
#    . $(brew --prefix)/etc/bash_completion
#  fi

ln -s /usr/local/Library/Contributions/brew_bash_completion.sh /usr/local/etc/bash_completion.d

cat >> ~/.bash_profile << EOF
if [ -f 'brew --prefix'/etc/bash_completion ]; then
    . 'brew --prefix'/etc/bash_completion
fi
EOF

#subl ~/.bash_profile

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash


#### ERROR ######
#------------------------------------------------------------------------------
# Install Ruby
#------------------------------------------------------------------------------
#cd ~/Github/
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

#------------------------------------------------------------------------------
# Install MySQL
#------------------------------------------------------------------------------
#/usr/local/opt/mysql/bin/mysqladmin -u root password 'new-password'
#/usr/local/opt/mysql/bin/mysqladmin -u root -h Pooky.local password 'new-password'
#
#Alternatively you can run:
#/usr/local/opt/mysql/bin/mysql_secure_installation
#
#You can start the MySQL daemon with:
#cd /usr/local/opt/mysql ; /usr/local/opt/mysql/bin/mysqld_safe &
#
#You can test the MySQL daemon with mysql-test-run.pl
#cd /usr/local/opt/mysql/mysql-test ; perl mysql-test-run.pl

#if [ ! -e /opt/local/lib/mysql55 ] ; then
#	echo "MySQL not found, installing..."
#    sudo port install mysql55 mysql55-server
#    sudo port clean --all
#else
#    echo "MySQL found								[OK]"
#fi

brew install mysql
unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
mkdir -p ~/Library/LaunchAgents
cp /usr/local/Cellar/mysql/5.5.29/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
/usr/local/Cellar/mysql/5.5.29/bin/mysql_secure_installation
#/usr/local/Cellar/mysql/5.5.29/bin/mysqladmin -u root password 'YOUR_NEW_PASSWORD'
mysql.server start
#mysql -u root -p

#------------------------------------------------------------------------------
# Install Postgresql
#------------------------------------------------------------------------------
#You can now start the database server using:
#    postgres -D /usr/local/var/postgres
#or
#    pg_ctl -D /usr/local/var/postgres -l logfile start

brew install postgresql --without-ossp-uuid
#?? brew install -dv postgresql
initdb --locale=en_US.UTF-8 --encoding=UTF8 /usr/local/var/postgres
#mkdir -p ~/Library/LaunchAgents
cp /usr/local/Cellar/postgresql/9.2.2/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
sudo mkdir /var/pgsql_socket/
ln -s /private/tmp/.s.PGSQL.5432 /var/pgsql_socket/

echo "Enter the required role name: postgres"
createuser -s -U $USER

#psqlstart
##psqlstop

#------------------------------------------------------------------------------
# Install pgAdmin (http://www.pgadmin.org/download/macosx.php)
#------------------------------------------------------------------------------
if [ ! -e /Applications/pgAdmin3.app ] ; then
    echo "pgAdmin not installed, please install..."
    open http://www.pgadmin.org/download/macosx.php
    while ( [ ! -e /Applications/pgAdmin3.app ] )
    do
        echo "Waiting for pgAdmin to be installed..."
        sleep 15
    done
else
    echo "pgAdmin found                                [OK]"
fi

#------------------------------------------------------------------------------
# Install PHP
#------------------------------------------------------------------------------
#The php.ini file can be found in:
#    /usr/local/etc/php/5.4/php.ini
#If PEAR complains about permissions, 'fix' the default PEAR permissions and config:
#    chmod -R ug+w /usr/local/Cellar/php54/5.4.11/lib/php
#    pear config-set php_ini /usr/local/etc/php/5.4/php.ini
#If you are having issues with custom extension compiling, ensure that this php is in your PATH:
#    PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
    
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php
brew upgrade
brew install php54 --with-pgsql --with-mysql --with-tidy --with-intl
brew install php54-intl
brew install php54-apc
#To finish installing apc for PHP 5.4:
#  * /usr/local/etc/php/5.4/conf.d/ext-apc.ini was created,
#    do not forget to remove it upon extension removal.
brew install php54-memcached
#To have launchd start memcached at login:
#    ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents
#Then to load memcached now:
#    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
#Or, if you don't want/need launchctl, you can just run:
#    /usr/local/opt/memcached/bin/memcached
brew install php54-inclued
brew install php54-http
brew install php54-oauth
brew install php54-ssh2
brew install php54-xdebug
brew install php54-uploadprogress
brew install php54-mcrypt
brew install php54-imagick
#ERR brew install php54-gmp # No available formula
#brew install php54-yaml
#brew install php54-solr
#brew install php54-xhprof

#??brew install php54 --with-mysql --with-pgsql
#??brew install php54 --with-mysql --with-pgsql --with-fpm
#??brew install php54 --with-mysql
#brew install php54-apc php54-memcached php54-inclued php54-http php54-oauth php54-ssh2 php54-xdebug php54-intl php54-uploadprogress php54-xhprof php54-http php54-mcrypt php54-yaml php54-imagick php54-solr
#??brew install php54-apc php54-memcached php54-xdebug php54-imagick
#brew install mysql
##ERR cp /usr/local/Cellar/php54/5.4.11/homebrew-php.josegonzalez.php54.plist ~/Library/LaunchAgents/
##ERR launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php54.plist

##??sudo cp /usr/local/etc/php/5.4/php.ini.default /usr/local/etc/php/5.4/php.ini

sudo cp /private/etc/php.ini.default /private/etc/php.ini
echo "Add/Change the following lines:"
echo "date.timezone = Europe/Amsterdam"
#?? Which One ???
subl /usr/local/etc/php/5.4/php.ini
sudo subl /private/etc/php.ini

echo "Add/Change the following lines:"
echo "LoadModule php5_module /usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so"
sudo subl /private/etc/apache2/httpd.conf

sudo apachectl restart

#?? sudo nano /usr/local/etc/php/5.4/php.ini
#cat >> ~/.bashrc << EOF
#PATH="$(brew --prefix php54)/bin:$PATH"
#EOF


#------------------------------------------------------------------------------
# Create and open phpinfo.php
#------------------------------------------------------------------------------
#SUDO_EDITOR="open -FWne" sudo -e /etc/apache2/httpd.conf
cat >> /tmp/phpinfo.php <<'EOF'
<?php

// Show all information, defaults to INFO_ALL
phpinfo();

?>
EOF

sudo mv /tmp/phpinfo.php /Library/WebServer/Documents/
open http://localhost/phpinfo.php

#------------------------------------------------------------------------------
# Create and open phpinfo.php
#------------------------------------------------------------------------------
cd /Library/WebServer/Documents/
sudo git clone https://github.com/spotweb/spotweb.git
subl /Library/WebServer/Documents/dbsettings.inc.php

#------------------------------------------------------------------------------
# Install Spotweb
#------------------------------------------------------------------------------
#export PATH=$PATH:/usr/local/opt/postgresql/bin
sudo -u andries psql postgres -c "create database spotweb_db"
sudo -u andries psql postgres -c "create user spotweb_user with password 'spotweb_user'"
sudo -u andries psql postgres -c "grant all privileges on database spotweb_db to spotweb_user"

## Not used, postgresql used instead of MySQL
#echo "-----------------------------------------------------------"
#echo "Enter the following in MySQL:"
#echo "CREATE DATABASE spotweb;"
#echo "CREATE USER spotweb@'localhost' IDENTIFIED BY 'mini_spotweb';"
#echo "GRANT ALL PRIVILEGES ON spotweb.* TO spotweb @'localhost' IDENTIFIED BY 'mini_spotweb';"
#echo "flush privileges;"
#echo "quit"
#echo "-----------------------------------------------------------"

cd /Library/WebServer/Documents/
git clone https://github.com/spotweb/spotweb.git
echo "Usenet Server     : XsNews"
echo "User Name         : 105764"
open http://localhost/spotweb/install.php

echo "Paste the information as seen in the installer"
sudo touch /Library/WebServer/Documents/spotweb/dbsettings.inc.php
sudo subl /Library/WebServer/Documents/spotweb/dbsettings.inc.php

php /Library/WebServer/Documents/spotweb/retrieve.php


#------------------------------------------------------------------------------
# Install NewzNAB
#------------------------------------------------------------------------------
sudo mkdir -p /Library/WebServer/Documents/Newznab/
cd /Library/WebServer/Documents/Newznab/

echo "-----------------------------------------------------------"
echo "Enter the following inoformation:"
echo "Username  : svnplus"
echo "Password  : svnplu5"
svn co svn://nnplus@svn.newznab.com/nn/branches/nnplus /Library/WebServer/Documents/Newznab

sudo chmod 777 /Library/WebServer/Documents/Newznab/www/lib/smarty/templates_c
sudo chmod 777 /Library/WebServer/Documents/Newznab/www/covers/movies
sudo chmod 777 /Library/WebServer/Documents/Newznab/www/covers/anime
sudo chmod 777 /Library/WebServer/Documents/Newznab/www/covers/music
sudo chmod 777 /Library/WebServer/Documents/Newznab/www
sudo chmod 777 /Library/WebServer/Documents/Newznab/www/install
sudo chmod -R 777 /Library/WebServer/Documents/Newznab/nzbfiles/
sudo chmod 777 /Library/WebServer/Documents/Newznab/db
#ERR - Does not exist: sudo chmod 777 /Library/WebServer/Documents/Newznab/nzbfiles/tmpunrar

open http://localhost/newznab








echo "-----------------------------------------------------------"
echo "Enter the following in MySQL:"
echo "CREATE DATABASE newznab;"
echo "CREATE USER 'newznab'@'localhost' IDENTIFIED BY 'mini_newznab';"
echo "GRANT ALL PRIVILEGES ON newznab.* TO newznab @'localhost' IDENTIFIED BY 'mini_newznab';"
echo "-----------------------------------------------------------"








