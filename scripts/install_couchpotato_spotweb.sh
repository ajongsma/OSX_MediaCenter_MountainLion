echo "#------------------------------------------------------------------------------"
echo "# Configuring Spotweb as provider for Couchpotato"
echo "#------------------------------------------------------------------------------"
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
## CouchPotato:
## 1. Bij Host vul je server/spotweb in (uiteraard na aanpassing aan de eigen omgeving).
## 2. Bij Apikey vul je de API-key van Spotweb in. Deze is in Spotweb te vinden onder Gebruiker wijzigen
## Op de pagina http://url.naar.couchpotato/config/ en klik op Providers. Op die pagina staat het onderdeel Newznab. Hier dien je een host en een API-key op te geven.
##  open http://localhost:8081/config
##
## Headphones:
## 1. Vink Newznab aan.
## 2. Bij Newznabhost vul je server/spotweb in.
## 3. Bij API Key vul je de API-key van Spotweb in. Deze is in Spotweb te vinden onder Gebruiker wijzigen
## Op de pagina http://url.naar.headphones/config staat Newznab onder Providers.
## --------------------
## http://patrickscholten.com/spotweb-gebruiken-als-newznab-server/
## --------------------

source ../config.sh

URL="http://localhost/spotweb/api?t=c"
TMPFILE=`mktemp /tmp/spotweb.XXXXXX`
curl -s -o ${TMPFILE} ${URL} 2>/dev/null
if [ "$?" -ne "0" ];
then
  echo "Unable to connect to ${URL}"
  exit 2
fi
RES=`grep -i "Spotweb API Index" ${TMPFILE}`
if [ "$?" -ne "0" ];
then
  echo "Spotweb API Index not found in ${URL}, check if the Spotweb API is working"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  exit 1;
else
  echo "Spotweb API Index found"
fi

echo "-----------------------------------------------------------------|"
echo "| Check if the API Grouplist exists. If not, click the plus icon |"
echo "-----------------------------------------------------------------|"
echo "| Tab Grouplist, click the plus icon"
echo "| Name                                    : API"
echo "|-------------------"
echo "| Add"
echo "|-------------------"
echo "|"
echo "| Click Permissions pencil - grouplist API:"
echo "| Display overview of spots               : Add"
echo "| Perform a search                        : Add"
echo "| Retrieve NZB file                       : Add"
echo "| Download manager integration            : Add"
echo "| RSS feed                                : Add"
echo "| Use downloads manager API               : Add"
echo "| Use Spotweb using an API key            : Add"
echo "| Send notifications (per service)        : Add"
echo "| Send notifications (per type)           : Add"
echo "|-------------------"
echo "| Add"
echo "-----------------------------------------------------------"
http://localhost/spotweb/?page=render&tplname=usermanagement
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| In the top-right corner, user icon, add user"
echo "|"
echo "| Username                                : $INST_COUCHPOTATO_UID""_api" 
echo "| First Name                              : $INST_COUCHPOTATO_UID"
echo "| Last Name                               : API"
echo "| E-mail address                          : $INST_COUCHPOTATO_UID@localhost.local"
echo "-----------------------------------------------------------"
open http://localhost/spotweb
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| Config, User and Group Management:"
echo "| Tab Userlist, select Username $INST_COUCHPOTATO_UID""_api"
echo "|"
echo "| GROUP                                     MEMBER"
echo "| -----                                     --------"
echo "| Anonymous user - closed system          : disabled"
echo "| Anonymous user - open system            : disabled"
echo "| Authenticated users                     : enabled"
echo "| Trusted users                           : disabled"
echo "| Administrators                          : disabled"
echo "| API                                     : enabled"
echo "|-------------------------------"
echo "| Save changes"
echo "|-------------------------------"
echo "|"
echo "| Add the shown API Key to config.sh      : INST_SPOTWEB_KEY_API_SICKBEARD"
echo "-----------------------------------------------------------"
#994afffb2c109cad9b13ceeda9be02f1

http://localhost/spotweb/?page=render&tplname=usermanagement
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

source ../config.sh
if [[ -z $INST_SPOTWEB_KEY_API_COUCHPOTATO ]]; then
    echo "-----------------------------------------------------------"
    echo "| Please add the Sickbeard Spotweb API key to config.sh"
    echo "| API Key                              : INST_SPOTWEB_KEY_API_COUCHPOTATO <paste value> "
    echo "-----------------------------------------------------------"
    #open http://localhost/newznab/admin/site-edit.php
    http://localhost/spotweb/?page=render&tplname=usermanagement
    subl ../config.sh

    while ( [[ $INST_SPOTWEB_KEY_API_COUCHPOTATO == "" ]] )
    do
        printf 'Waiting for Couchpotato Spotweb API be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 2
        source ../config.sh
    done
fi

echo "-----------------------------------------------------------"
echo "| Config, Settings, Searcher, Providers:"
echo "| "
echo "| Newznab:"
echo "| Host                                    : http://localhost/spotweb/"
echo "| API Key                                 : $INST_SPOTWEB_KEY_API_COUCHPOTATO"
echo "-------------------------------"
echo "| Save changes"
echo "-----------------------------------------------------------"
http://localhost:8082/settings/searcher/providers/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Configuring Spotweb as provider for Couchpotato - Complete"
echo "#------------------------------------------------------------------------------"
