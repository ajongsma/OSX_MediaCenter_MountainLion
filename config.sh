#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

### TESTING GITHUB SYNC

### Copy this file to config.sh
### DO NOT EDIT THIS FILE, BUT EDIT CONFIG.SH INSTEAD

##############################################################
######################### EDIT THESE #########################
##############################################################

## Check and install OS X Updates
export INST_OSX_UPDATES="false"

#-----------------------------------------------------------

## Install optional software
# Install iTerm 2 (http://www.iterm2.com) - (true/false)
export INST_ITERM2="true"
# Install Sublime Text (http://www.sublimetext.com) - (true/false)
export INST_SUBLIMETEXT="true"
# Install Xlog (https://itunes.apple.com/nl/app/xlog/id430304898?l=en&mt=12) - (true/false)
export INST_XLOG="true"
# Install Mac Github (http://mac.github.com) - (true/false)
export INST_MACGITHUB="true"
# Install Dropbox (https://www.dropbox.com/download?plat=mac) - (true/false)
export INST_DROPBOX="true"
# Install MySQL Workbench (http://dev.mysql.com/downloads/workbench) - (true/false)
export INST_MYSQL_WORKBENCH="true"
#Install pgAdmin (http://www.pgadmin.org/download/macosx.php) - (true/false)
export INST_PGADMIN="true"
# Install for InductionApp (http://inductionapp.com) - (true/false)
export INST_INDUCTIONAPP="false"

#-----------------------------------------------------------

#Specify your SED binary
export SED="/usr/local/bin/gsed"

#-----------------------------------------------------------

## NewzNAB
export INST_NEWZNAB_PATH="/Users/Newznab/Sites/newznab"
export INST_NEWZNAB_SVN_UID='svnplus'
export INST_NEWZNAB_SVN_PW='svnplu5'
export INST_NEWZNAB_MYSQL_DB="newznab"
export INST_NEWZNAB_MYSQL_UID="newznab"
export INST_NEWZNAB_MYSQL_PW="mini_newznab"

## NewzNAB API Key - (check NewzNAB)
INST_NEWZNAB_API=''

#-----------------------------------------------------------

## News Server Provider
export INST_NEWSSERVER_NAME='XsNews'
export INST_NEWSSERVER_SERVER='reader.xsnews.nl'
export INST_NEWSSERVER_SERVER_UID='105764'
export INST_NEWSSERVER_SERVER_PW=''
export INST_NEWSSERVER_SERVER_PORT=''
export INST_NEWSSERVER_SERVER_PORT_SSL='563'

#-----------------------------------------------------------

## SpotWeb
export INST_SPOTWEB_PATH="/Users/Spotweb/Sites/spotweb"
export INST_NEWZNAB_PSQL_DB="spotweb_db"
export INST_NEWZNAB_PSQL_UID="spotweb_usr"
export INST_NEWZNAB_PSQL_PW="mini_spotweb"

#-----------------------------------------------------------

## SABnzbd
export INST_SABNZBD_UID="sabnzbd"
export INST_SABNZBD_PW="mini_sabnzbd"
export INST_SABNZBD_KEY_API=""
export INST_SABNZBD_KEY_NZB=""

#-----------------------------------------------------------

## Sick-Beard
export INST_SICKBEARD_UID="sickbeard"
export INST_SICKBEARD_PW="mini_sickbeard"

#-----------------------------------------------------------

## Couchpotato
export INST_COUCHPOTATO_UID="couchpotato"
export INST_COUCHPOTATO_PW="mini_couchpotato"

#-----------------------------------------------------------

## Full User Name for GIT
export INST_GIT_FULL_NAME='Andries Jongsma'

## E-mail address for GIT
export INST_GIT_EMAIL='a.jongsma@gmail.com'

#-----------------------------------------------------------

## Apache
export INST_APACHE_SYSTEM_WEB_ROOT='/Library/WebServer/Documents/'

############################################################

## By using this script you understand that the programmer is not responsible for any loss of data, users, or sanity.
## You also agree that you were smart enough to make a backup of your database and files. Do you agree? yes/no
export AGREED="yes"

##END OF EDITS##



############################################################
############################################################

##Should not need to change
export INST_NEWZNAB_UPDATE_PATH=$NEWZNAB_PATH"/misc/update_scripts"
export INST_NEWZNAB_TESTING_PATH=$NEWZNAB_PATH"/misc/testing"
export INST_NEWZNAB_ADMIN_PATH=$NEWZNAB_PATH"/www/admin"

############################################################
