#!/bin/sh

## http://www.howtogeek.com/120285/how-to-build-your-own-usenet-indexer/

PHP_INI_1=/private/etc/php.ini
PHP_INI_2=/usr/local/etc/php/5.4/php.ini
APACHE2_CONF=/private/etc/apache2/httpd.conf
MYSQL_CONF=/etc/my.cnf

PATH_TO_SPOTWEB=/User/Spotweb/Sites/spotweb
PATH_TO_PHP_1=/usr/bin/php
PATH_TO_PHP_2=(brew --prefix josegonzalez/php/php54)/bin

## http://forum.qnap.com/viewtopic.php?p=306612
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
col=40

echo $PID > ${NN_PID_PATH}${PIDFILE}
if [ -f ${NN_PID_PATH}${PIDFILE} ]
then
 printf '%s%*s%s\n' "$GREEN" $col '[OK]' "$NORMAL"
else
 printf '%s%*s%s\n' "$RED" $col '[FAIL]' "$NORMAL"
fi
## -----------------------------------------------

echo "============================================"
echo "`date +%Y-%m-%d\ %H:%M` : Starting check"
echo "============================================"
echo ".BASH_PROFILE (source ~/.bash_profile)"
echo "--------------------------------------------"
echo "=> PATH PHP:"
cat ~/.bash_profile | grep php
echo "$(brew --prefix josegonzalez/php/php54)/bin:$PATH"

echo "======================"
echo "APACHE2 => ${APACHE2_CONF}"
echo "----------------------"
echo "??? mod_rewrite"
cat $APACHE2_CONF | grep "proxy_http_module"
cat $APACHE2_CONF | grep "proxy_module"

echo "======================"
echo "PHP"
echo "----------------------"
echo "Add/Change the following lines:"
echo "date.timezone = Europe/Amsterdam"
echo "register_globals = Off"
echo "max_execution_time = 120"
echo "memory_limit = 256M"
echo "error_reporting = E_ALL ^ E_STRICT"
echo "----------------------"
echo "=> ${PHP_INI_1} : "
echo ""
cat $PHP_INI_1 | grep "^date.timezone"
cat $PHP_INI_1 | grep "^register_globals"
cat $PHP_INI_1 | grep "^max_execution_time"
cat $PHP_INI_1 | grep "^memory_limit"
cat $PHP_INI_1 | grep "^error_reporting"
echo "----------------------"
echo "=> ${PHP_INI_2} :" 
echo ""
cat $PHP_INI_2 | grep "^date.timezone"
cat $PHP_INI_2 | grep "^register_globals"
cat $PHP_INI_2 | grep "^max_execution_time"
cat $PHP_INI_2 | grep "^memory_limit"
cat $PHP_INI_2 | grep "^error_reporting"

if [ -e $MYSQL_CONF ] ; then
  # https://newznab.readthedocs.org/en/latest/install/
	echo "======================"
	echo "MYSQL => ${MYSQL_CONF}"
	echo "----------------------"
	echo "[mysqld]"
	echo "max_allowed_packet = 12582912"
	echo ""
	cat $MYSQL_CONF | grep "max_allowed_packet"
else
	echo "Missing file : ${MYSQL_CONF}   [ERR]"
fi
