#!/usr/bin/env bash

## Would you like to alter php.ini </usr/local/etc/php/5.4/php.ini>? [Y/n] : 
##  php.ini </usr/local/etc/php/5.4/php.ini> include_path updated.
## Current include path           : .:/usr/local/Cellar/php54/5.4.11/lib/php
## Configured directory           : /usr/local/share/pear/share/pear
## Currently used php.ini (guess) : /usr/local/etc/php/5.4/php.ini
## 
## /usr/local/etc/php/5.4/php.ini
## ;***** Added by go-pear
## include_path=".:/usr/local/share/pear/share/pear"
## ;*****

cd ~/Downloads
wget http://pear.php.net/go-pear.phar

echo "1) Change Installation Base     : /usr/local/share/pear"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

sudo php -d detect_unicode=0 go-pear.phar

#sudo php /usr/lib/php/install-pear-nozlib.phar
#pear config-set php_ini /etc/php.ini
#pecl config-set php_ini /etc/php.ini
#sudo pear upgrade-all

sudo apachectl restart

echo "Install Pear complete."
