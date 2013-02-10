#!/usr/bin/env bash
##------------------------------------------------------------------------------
## Install Postgresql
##------------------------------------------------------------------------------
## https://support.eapps.com/index.php?/Knowledgebase/Article/View/414/32/user-guide---postgresql-9-and-phppgadmin
## http://scratching.psybermonkey.net/2009/06/postgresql-how-to-reset-user-name.html

## By default, Homebrew builds all available Contrib extensions.  To see a list of all
## available extensions, from the psql command line, run:
##   SELECT * FROM pg_available_extensions;
## 
## To load any of the extension names, navigate to the desired database and run:
##   CREATE EXTENSION [extension name];
## 
## For instance, to load the tablefunc extension in the current database, run:
##   CREATE EXTENSION tablefunc;
##   
## You can manually the database server using:
##    postgres -D /usr/local/var/postgres
##    or
##    pg_ctl -D /usr/local/var/postgres -l logfile start
## 
## WARNING: enabling "trust" authentication for local connections
## You can change this by editing pg_hba.conf or using the option -A, or
## --auth-local and --auth-host, the next time you run initdb.


brew install postgresql --without-ossp-uuid
initdb --locale=en_US.UTF-8 --encoding=UTF8 /usr/local/var/postgres

ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

if [ ! -e /var/pgsql_socket/ ] ; then
    sudo mkdir /var/pgsql_socket/
fi
sudo ln -s /private/tmp/.s.PGSQL.5432 /var/pgsql_socket/

## Create a super user with database
createuser $USER -s -d  -r -P -E -e
createdb $USER

$psql -U postgres
#ALTER USER Andries with password 'secure-password';

#echo "Enter the required role name: postgres"
#createuser $POSTGRESQL_USER ENCRYPTED PASSWORD $POSTGRESQL_PASSWORD

#createuser -s -U $USER
#createuser -s -U $USER

##postgres# CREATE USER geodjango PASSWORD 'my_passwd';
##postgres# CREATE DATABASE geodjango OWNER geodjango TEMPLATE template_postgis ENCODING 'utf8';

#psqlstart
##psqlstop
