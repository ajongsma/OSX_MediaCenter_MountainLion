#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Install NewzNAB
#------------------------------------------------------------------------------
## http://www.newznabforums.com

source ../config.sh

sudo mkdir -p $INST_NEWZNAB_PATH
sudo chown `whoami` $INST_NEWZNAB_PATH
cd $INST_NEWZNAB_PATH

svn co svn://svn.newznab.com/nn/branches/nnplus/ --username $INST_NEWZNAB_SVN_UID --password $INST_NEWZNAB_SVN_PW $INST_NEWZNAB_PATH

mkdir $INST_NEWZNAB_PATH/nzbfiles/tmpunrar
sudo chmod 777 $INST_NEWZNAB_PATH/www/lib/smarty/templates_c
sudo chmod 777 $INST_NEWZNAB_PATH/www/covers/movies
sudo chmod 777 $INST_NEWZNAB_PATH/www/covers/anime
sudo chmod 777 $INST_NEWZNAB_PATH/www/covers/music
sudo chmod 777 $INST_NEWZNAB_PATH/www
sudo chmod 777 $INST_NEWZNAB_PATH/www/install
sudo chmod 777 $INST_NEWZNAB_PATH/db
sudo chmod -R 777 $INST_NEWZNAB_PATH/nzbfiles/


#echo "-----------------------------------------------------------"
#echo "Enter the httpd.conf:"
#echo "<Directory /Library/WebServer/Documents/newznab>"
#echo "    Options FollowSymLinks"
#echo "    AllowOverride All"
#echo "    Order deny,allow"
#echo "    Allow from all"
#echo "</Directory>"
#echo "-----------------------------------------------------------"
#sudo subl /etc/apache2/httpd.conf

#echo "----------------------------------------------------------"
#echo "| Add an alias and enable htaccess for NewzNAB to the default website:"
#echo "| Create alias in Server Website"
#echo "|   Path                        : /newzab"
#echo "|   Folder                      : $INST_NEWZNAB_PATH/www"
#echo "| Enable overrides using .htaccess files"
#echo "-----------------------------------------------------------"
#open /Applications/Server.app
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s

sudo ln -s /Users/Newznab/Sites/newznab/www /Library/Server/Web/Data/Sites/Default/newznab

## Create the NewzNAB MySQL user and DB
MYSQL=`which mysql`

Q1="CREATE DATABASE IF NOT EXISTS $INST_NEWZNAB_MYSQL_DB;"
Q2="GRANT USAGE ON *.* TO $INST_NEWZNAB_MYSQL_UID@localhost IDENTIFIED BY '$INST_NEWZNAB_MYSQL_PW';"
Q3="GRANT ALL PRIVILEGES ON $INST_NEWZNAB_MYSQL_DB.* TO $INST_NEWZNAB_MYSQL_UID@localhost;"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

MYSQL -u root -p -e "$SQL"

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Hostname                      : localhost"
echo "| Port                          : 3306"
echo "| Username                      : $INST_NEWZNAB_MYSQL_UID"
echo "| Password                      : $INST_NEWZNAB_MYSQL_PW"
echo "| Database                      : $INST_NEWZNAB_MYSQL_DB"
echo "| DB Engine                     : MyISAM"
echo "-----------------------------------------------------------"
echo "| News Server Setup:"
echo "| Server                        : $INST_NEWSSERVER_SERVER"
echo "| User Name                     : $INST_NEWSSERVER_SERVER_UID"
echo "| Password                      : $INST_NEWSSERVER_SERVER_PW"
echo "| Port                          : $INST_NEWSSERVER_SERVER_PORT_SSL"
echo "| SSL                           : Enable"
echo "-----------------------------------------------------------"
echo "| Caching Setup:"
echo "| Caching Type                  : Memcache"
echo "-----------------------------------------------------------"
echo "| Admin Setup:"
echo "-----------------------------------------------------------"
echo "| NZB File Path Setup           : $INST_NEWZNAB_PATH/nzbfiles/"
echo "-----------------------------------------------------------"
open http://localhost/newznab

echo "-----------------------------------------------------------"
echo "| Main Site Settings, HTML Layout, Tags"
echo "| newznab ID                    : <nnplus id>"
echo "| "
echo "| 3rd Party Application Paths"
echo "| Unrar Path                    : /usr/local/bin/unrar"

echo "| Usenet Settings"
echo "| Minimum Completion Percent    : 95"
echo "| Start new groups              : Days, 1"

echo "| Check For Passworded Releases : Deep"
echo "| Delete Passworded Releases    : Yes"
echo "| Show Passworded Releases      : Show everything"
echo "-----------------------------------------------------------"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
open http://localhost/newznab/admin/site-edit.php


## --- TESTING

echo "-----------------------------------------------------------"
echo "| Enable categories:"
echo "| a.b.teevee"
echo "|"
echo "| For extended testrun:"
echo "| a.b.multimedia"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/group-list.php

echo "-----------------------------------------------------------"
echo "| Add the following newsgroup:"
echo "| Name                          : alt.binaries.nl"
echo "| Backfill Days                 : 1"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/group-edit.php

echo "-----------------------------------------------------------"
echo "| Add the following RegEx:"
echo "| Group                         : alt.binaries.nl"
echo "| RegEx                         : /^.*?"(?P<name>.*?)\.(sample|mkv|Avi|mp4|vol|ogm|par|rar|sfv|nfo|nzb|web|rmvb|srt|ass|mpg|txt|zip|wmv|ssa|r\d{1,3}|7z|tar|cbr|cbz|mov|divx|m2ts|rmvb|iso|dmg|sub|idx|rm|t\d{1,2}|u\d{1,3})/iS""
echo "| Ordinal                       : 5"
echo "-----------------------------------------------------------"
http://localhost/newznab/admin/regex-edit.php?action=add

## Lost API Reference - prob SabNZBD
#source ../config.sh
#if [[ $INST_NEWZNAB_API == "" ]]; then
#    echo "| Main Site Settings, API:"
#    echo "| Please add the NewzNAB API key to config.sh"
#    echo "-----------------------------------------------------------"
#    open  http://localhost/newznab/admin/site-edit.php
#    while ( [[ $INST_NEWZNAB_API == "" ]] )
#    do
#        printf 'Waiting for NewzNAB API key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
#        sleep 15
#        source ../config.sh
#    done
#fi

if [ -f $DIR/bin/newznab_local.sh ] ; then
    sudo cp $DIR/bin/newznab_local.sh $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/
else
    echo "-----------------------------------------------------------"
    echo "| Update the following:"
    echo "| export NEWZNAB_PATH="$INST_NEWZNAB_PATH/misc/update_scripts""

    echo "| Modify all PHP5 references"
    echo "| /usr/bin/php5 ... => php ..."
    cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/
    cp newznab_screen.sh newznab_local.sh
    chmod +x newznab_local.sh
    subl newznab_local.sh
fi

cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/
sh ./newznab_local.sh
#bash ./newznab_local.sh


## Additional custom NewzNAB Themes
echo "-----------------------------------------------------------"
echo "| Installing additional NewzNAB themes..."
echo "-----------------------------------------------------------"
#git clone https://github.com/jonnyboy/Newznab-Simple-Theme.git $INST_NEWZNAB_PATH/www/templates/simple
#git clone https://github.com/sinfuljosh/bootstrapped.git $INST_NEWZNAB_PATH/www/templates/bootstrapped

#mkdir -p ~/Github/
cd ~/Github/
git clone https://github.com/jonnyboy/Newznab-Simple-Theme.git
cp -r Newznab-Simple-Theme/simple $INST_NEWZNAB_PATH/www/templates/simple
git clone https://github.com/sinfuljosh/bootstrapped.git
cp -r bootstrapped $INST_NEWZNAB_PATH/www/templates/bootstrapped


#cd /Users/Newznab/Sites/newznab/misc/update_scripts
##php update_binaries.php && php update_releases.php
##php update_binaries.php
##php update_releases.php

# screen bash
#screen
#./newznab_local.sh
#echo "ctrl-ad to detach screen"


echo "Install NewzNAB complete."

