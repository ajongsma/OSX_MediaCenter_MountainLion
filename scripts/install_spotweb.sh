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

[ -d /usr/local/share/spotweb ] || mkdir -p /usr/local/share/spotweb
cp /Users/Andries/Github/OSX_NewBox/bin/share/tmux_sync_spotweb.sh /usr/local/share/spotweb
cp /Users/Andries/Github/OSX_NewBox/bin/share/spotweb_cycle.sh /usr/local/share/spotweb
ln -s /usr/local/share/spotweb/tmux_sync_spotweb.sh /usr/local/bin/

[ -d /var/log/spotweb ] || sudo mkdir -p /var/log/spotweb && sudo chown `whoami` /var/log/spotweb

INST_FILE_LAUNCHAGENT="com.tmux.spotweb.plist"
if [ -f $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
    echo "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT"
    cp $DIR/launchctl/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
    if [ "$?" != "0" ]; then
        echo -e "${RED}  ============================================== ${RESET}"
        echo -e "${RED} | ERROR ${RESET}"
        echo -e "${RED} | Copy failed: ${RESET}"
        echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
        echo -e "${RED} | --- press any key to continue --- ${RESET}"
        echo -e "${RED}  ============================================== ${RESET}"
        read -n 1 -s
        exit 1
    fi
    launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
else
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | LaunchAgent file not found: ${RESET}"
    echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
    echo -e "${RED} | --- press any key to continue --- ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
    exit 1
fi

#------------------------------------------------------------------------------
# Install Spotweb - Complete
#------------------------------------------------------------------------------