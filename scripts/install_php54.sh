#!/usr/bin/env bash

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

## brew unlink php53 && brew link php54

#?? error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT

brew tap josegonzalez/homebrew-php
brew update
brew upgrade
brew cleanup

#??brew install php54 --with-mysql --with-pgsql --with-fpm
brew install php54 --with-pgsql --with-mysql --with-tidy --with-intl --with-gmp
brew install php54-intl
brew install php54-apc
brew install php54-inclued
brew install php54-http
brew install php54-oauth
brew install php54-ssh2
brew install php54-xdebug
brew install php54-mcrypt
## ERR: brew install php54-imagick

brew install php54-memcached
ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist

if [ -d /var/log/php ] ; then
    sudo mkdir /var/log/php
fi

if [ -f /usr/local/etc/php/5.4/php.ini ] ; then
    sudo mv /usr/local/etc/php/5.4/php.ini /usr/local/etc/php/5.4/php.ini.org
    sudo cp $DIR/conf/php54.ini /usr/local/etc/php/5.4/php.ini
else
	sudo cp $DIR/conf/php54.ini /usr/local/etc/php/5.4/php.ini
fi

if [ -f /private/etc/php.ini ] ; then
    sudo mv /private/etc/php.ini /private/etc/php.ini.org
    sudo cp $DIR/conf/php.ini /private/etc/php.ini
else
	sudo cp $DIR/conf/php.ini /private/etc/php.ini
fi


echo "Change as soon as possible:"
echo "File:"
echo "/private/etc/php.ini"
echo "/usr/local/etc/php/5.4/php.ini"
echo "  display_startup_errors = On"
echo "  to"
echo "  display_startup_errors = Off"

## echo "Add/Change the following lines:"
## echo "date.timezone = Europe/Amsterdam"
## echo "register_globals = Off"
## echo "max_execution_time = 120"
## echo "memory_limit = 256M"
## echo "error_reporting = E_ALL ^ E_STRICT"
##
## echo "TESTING"
## echo "memory_limit = 512M"
## echo "serialize_precision = 100"
## echo "Doesn't work: error_reporting  =  E_ALL & ~E_NOTICE"
## echo "error_reporting = E_ALL & ~E_STRICT"
## echo "display_startup_errors = Off"
## echo "track_errors = Off"
## echo "variables_order = "EGPCS""
## echo "post_max_size = 128M"
##
## sudo subl /usr/local/etc/php/5.4/php.ini
## #sudo subl /usr/local/etc/php/5.3/php.ini
## sudo subl /private/etc/php.ini
##
## 
## #/usr/libexec/apache2/libphp5.so
## #/usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so
## #sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp53.so
## #sudo ln -s /usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so
## 
## echo "Add/Change the following lines:"
## echo "LoadModule php5_module /usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so"
## 
## echo "?? sudo /opt/local/apache2/bin/apxs -a -e -n "php5" mod_php54.so"
## echo "?? sudo /opt/local/apache2/bin/apxs -a -e -n "php54" libphp54.so"
## #sudo subl /private/etc/apache2/httpd.conf
## 
## if [ ! -e /Applications/Server.app ] ; then
##     sudo subl /private/etc/apache2/httpd.conf
## else
##     sudo subl /private/etc/apache2/httpd.conf
##     sudo subl /Library/Server/Web/Config/apache2/httpd_server_app.conf
## fi
## 
## # Test apache config
## /usr/sbin/httpd -t
## 
## # sudo apachectl restart
## sudo apachectl start
## open http://localhost
## 
## #?? sudo nano /usr/local/etc/php/5.4/php.ini
## 
## ##PATH="$(brew --prefix php54)/bin:$PATH"
## 
## if [ ! -e ~/.bashrc ] ; then
## cat >> ~/.bashrc << EOF
## PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
## EOF
## else
##     echo "Add the following to ~/.bashrc"
##     echo "PATH="$(brew --prefix josegonzalez/php54)/bin:$PATH""
## fi
## source ~/.bashrc
## 
## #cat >> ~/.bashrc << EOF
## #PATH="$(brew --prefix php54)/bin:$PATH"
## #EOF
## #PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"

echo "Don’t forget to add the PATH:"
echo "PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH.""

cat >> ~/.bashrc <<'EOF'
# PHP 5.4
PATH="$(brew --prefix josegonzalez/php/php54)/bin":$PATH
EOF
source ~/.bashrc

sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp53.so
sudo ln -sv /usr/local/Cellar/php54/5.4.11/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so

cat >> /tmp/php_info.php <<'EOF'
<?php

// Show all information, defaults to INFO_ALL
phpinfo();

?>
EOF
sudo mv /tmp/php_info.php /Library/Server/Web/Data/Sites/Default/

/usr/sbin/httpd -t
sudo apachectl restart

open http://localhost/php_info.php

echo "Install PHP 5.4 complete.\n"




