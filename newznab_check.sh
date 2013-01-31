#!/bin/sh

## http://www.howtogeek.com/120285/how-to-build-your-own-usenet-indexer/

PHP_INI_1=/etc/php.ini
PHP_INI_2=/etc/php5/apache2/php.ini
APACHE2_CONF=/etc/apache2/httpd.conf
MYSQL_CONF=/etc/my.cnf

PATH_TO_SPOTWEB=/volume1/web/spotweb
PATH_TO_PHP=/usr/bin/php



echo "======================"
echo -n `date +%Y-%m-%d\ %H:%M`
echo ": Starting check"
echo ""

echo "======================"
echo "APACHE2"
echo "----------------------"
echo "=> ${APACHE2_CONF} :" 
echo ""
echo "??? mod_rewrite"

echo "======================"
echo "PHP"
echo "----------------------"
echo "memory_limit =  -1"
echo "max_execution_time = 120"
echo "date.timezone =  Europe/Amsterdam"
echo "----------------------"

echo "=> ${PHP_INI_1} : "
echo ""
cat PHP_INI_1 | grep "memory_limit"
cat PHP_INI_1 | grep "max_execution_time"
cat PHP_INI_1 | grep "date.timezone"

echo "----------------------"
echo "=> ${PHP_INI_2} :" 
echo ""
cat PHP_INI_1 | grep "memory_limit"
cat PHP_INI_2 | grep "max_execution_time"
cat PHP_INI_2 | grep "date.timezone"


MYSQL_CONF

