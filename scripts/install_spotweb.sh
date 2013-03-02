#------------------------------------------------------------------------------
# Install Spotweb
#------------------------------------------------------------------------------
#export PATH=$PATH:/usr/local/opt/postgresql/bin

source ../config.sh

#sudo -u andries psql postgres -c "create database spotweb_db"
#sudo -u andries psql postgres -c "create user spotweb_user with password 'spotweb_user'"
#sudo -u andries psql postgres -c "grant all privileges on database spotweb_db to spotweb_user"

sudo -u andries psql postgres -c "create database $INST_NEWZNAB_PSQL_DB"
sudo -u andries psql postgres -c "create user $INST_NEWZNAB_PSQL_UID with password '"$INST_NEWZNAB_PSQL_PW"'"
sudo -u andries psql postgres -c "grant all privileges on database $INST_NEWZNAB_PSQL_DB to $INST_NEWZNAB_PSQL_UID"

### ERROR:  syntax error at or near "'mini_spotweb'"
### sudo -u andries psql -c ALTER USER spotweb_usr SET PASSWORD 'mini_spotweb';
sudo -u andries psql -c "ALTER USER $INST_NEWZNAB_PSQL_UID SET PASSWORD '"$INST_NEWZNAB_PSQL_PW"';"

#?? open /Applications/pgAdmin3.app
#?? echo "Open pgAdmin and set the password of user: spotweb_user"

#cd /Library/WebServer/Documents/
#sudo git clone https://github.com/spotweb/spotweb.git
#subl /Library/WebServer/Documents/spotweb/dbsettings.inc.php

if [ ! -d $INST_SPOTWEB_PATH ] ; then
    sudo mkdir -p $INST_SPOTWEB_PATH    
fi
cd $INST_SPOTWEB_PATH/../
sudo rmdir spotweb

sudo git clone https://github.com/spotweb/spotweb.git
sudo chown `whoami` $INST_SPOTWEB_PATH

#echo "----------------------------------------------------------"
#echo "| Add an alias and enable htaccess for NewzNAB to the default website:"
#echo "| Create alias in Server Website"
#echo "|   Path                        : /spotweb"
#echo "|   Folder                      : $INST_SPOTWEB_PATH"
#echo "| Enable overrides using .htaccess files"
#echo "-----------------------------------------------------------"
#open /Applications/Server.app
#echo " --- press any key to continue ---"
#read -n 1 -s

sudo ln -s /Users/Spotweb/Sites/spotweb /Library/Server/Web/Data/Sites/Default/spotweb
#sudo ln -s /Users/Spotweb/Sites/spotweb/ /Library/WebServer/Documents/spotweb

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Type                          : PostgreSQL"
echo "| Server                        : localhost"
echo "| Database                      : $INST_NEWZNAB_PSQL_DB"
echo "| Username                      : $INST_NEWZNAB_PSQL_UID"
echo "| Password                      : $INST_NEWZNAB_PSQL_PW"
echo "-----------------------------------------------------------"
echo "| Usenet Server                 : $INST_NEWSSERVER_NAME"
echo "| User Name                     : $INST_NEWSSERVER_SERVER_UID"
echo "-----------------------------------------------------------"
open http://localhost/spotweb/install.php
echo " --- press any key to continue ---"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| After finishing all steps, copy/paste the information as during the last phase"
sudo touch $INST_SPOTWEB_PATH/dbsettings.inc.php
sudo subl $INST_SPOTWEB_PATH/dbsettings.inc.php
echo " --- press any key to continue ---"
read -n 1 -s

#/Library/WebServer/Documents/spotweb/retrieve.php
#sh php /Library/WebServer/Documents/spotweb/retrieve.php
#/bin/bash php /Library/WebServer/Documents/spotweb/retrieve.php

echo "-----------------------------------------------------------"
echo "| Click on the Cogwheel top-right and enter the following settings:"
echo "| "
echo "| NZB Handeling"
echo "| What shall we do with NZB files           : Call SABnzbd through HTTP by Spotweb"
echo "| What shall we do with multiple NZB files? : Merge NZB files"
echo "| URL to SABnzbd                            : localhost:$INST_SABNZBD_PORT"
echo "| API key for SABnzbd                       : $INST_SABNZBD_KEY_API"
echo "-----------------------------------------------------------"
echo "| Change"
echo "-----------------------------------------------------------"
open http://localhost/spotweb

echo " --- press any key to continue ---"
read -n 1 -s

#osascript -e 'tell app "Terminal"
#    do script "php /Users/Spotweb/Sites/spotweb/retrieve.php"
#end tell'

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
