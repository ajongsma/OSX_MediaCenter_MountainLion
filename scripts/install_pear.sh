#!/usr/bin/env bash

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
