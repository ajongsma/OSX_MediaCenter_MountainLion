#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Install NewzNAB
#------------------------------------------------------------------------------

brew install unrar

sudo mkdir -p /Users/Newznab/Sites/newznab/
cd /Users/Newznab/Sites/newznab/

echo "-----------------------------------------------------------"
echo "Enter the following inoformation:"
echo "Username              : svnplus"
echo "Password              : svnplu5"
sudo svn co svn://nnplus@svn.newznab.com/nn/branches/nnplus /Users/Newznab/Sites/newznab

sudo mkdir /Users/Newznab/Sites/newznab/nzbfiles/tmpunrar
sudo chmod 777 /Users/Newznab/Sites/newznab/www/lib/smarty/templates_c
sudo chmod 777 /Users/Newznab/Sites/newznab/www/covers/movies
sudo chmod 777 /Users/Newznab/Sites/newznab/www/covers/anime
sudo chmod 777 /Users/Newznab/Sites/newznab/www/covers/music
sudo chmod 777 /Users/Newznab/Sites/newznab/www
sudo chmod 777 /Users/Newznab/Sites/newznab/www/install
sudo chmod -R 777 /Users/Newznab/Sites/newznab/nzbfiles/
sudo chmod 777 /Users/Newznab/Sites/newznab/db
sudo chmod 777 /Users/Newznab/Sites/newznab/nzbfiles/tmpunrar

sudo ln -s /Users/Newznab/Sites/newznab/www/ /Library/WebServer/Documents/newznab

echo "-----------------------------------------------------------"
echo "Enter the httpd.conf:"
echo "<Directory /Library/WebServer/Documents/newznab>"
echo "    Options FollowSymLinks"
echo "    AllowOverride All"
echo "    Order deny,allow"
echo "    Allow from all"
echo "</Directory>"
echo "-----------------------------------------------------------"
sudo subl /etc/apache2/httpd.conf

echo "-----------------------------------------------------------"
echo "Enter the following in MySQL:"
echo "CREATE DATABASE newznab;"
echo "CREATE USER 'newznab'@'localhost' IDENTIFIED BY 'mini_newznab';"
echo "GRANT ALL PRIVILEGES ON newznab.* TO newznab @'localhost' IDENTIFIED BY 'mini_newznab';"
echo "FLUSH PRIVILEGES;"
echo "-----------------------------------------------------------"
open mysql -u root -p

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Hostname                      : localhost"
echo "| Port                          : 3306"
echo "| Username                      : newznab"
echo "| Password                      : <password>"
echo "| Database                      : newznab"
echo "| DB Engine                     : MyISAM"
echo "-----------------------------------------------------------"
echo "| News Server Setup:"
echo "| Server                        : reader.xsnews.nl"
echo "| User Name                     : 105764"
echo "| Password                      : <password>"
echo "| Port                          : 563"
echo "| SSL                           : Enable"
echo "-----------------------------------------------------------"
echo "| Caching Setup:"
echo "| Caching Type                  : Memcache"
echo "-----------------------------------------------------------"
echo "| Admin Setup:"
echo "-----------------------------------------------------------"
echo "| NZB File Path Setup           : /Users/Newznab/Sites/newznab/nzbfiles/"
echo "-----------------------------------------------------------"
open http://localhost/newznab

echo "-----------------------------------------------------------"
echo "| newznab ID                    : <nnplus id>"
echo "| Unrar Path                    : /usr/local/bin/unrar"

echo "|*Integration Type              : Site Wide"
echo "| SABnzbd Url                   : http://localhost:8080/sabnzbd/"
echo "| SABnzbd Api Key               : (http://localhost:8080/config/general/)"
echo "| Api Key Type                  : Full Api Key"

echo "| Minimum Completion Percent    : 90"
echo "| Start new groups              : Days, 1"

echo "| Check For Passworded Releases : Deep"
echo "| Delete Passworded Releases    : Yes"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/site-edit.php

echo "-----------------------------------------------------------"
echo "| Enable categories:"
echo "| a.b.teevee"
echo "|"
echo "| For extended testrun:"
echo "| a.b.multimedia"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/group-list.php


## --- TESTING

cd /Users/Newznab/Sites/newznab/misc/update_scripts
##php update_binaries.php && php update_releases.php
##php update_binaries.php
##php update_releases.php

cp newznab_screen.sh newznab_local.sh

echo "-----------------------------------------------------------"
echo "| Update the following:"
echo "| export NEWZNAB_PATH="/Users/Newznab/Sites/newznab/misc/update_scripts""
echo "| /usr/bin/php5 => /usr/local/Cellar/php54/5.4.11/bin/php"
subl newznab_local.sh

echo "-----------------------------------------------------------"
echo "| Add the following newsgroup:"
echo "| Name                          : alt.binaries.nl"
echo "| Backfill Days                 : 1"
open http://localhost/newznab/admin/group-edit.php

echo "-----------------------------------------------------------"
echo "| Add the following RegEx:"
echo "| Group                         : alt.binaries.nl"
echo "| RegEx                         : /^.*?"(?P<name>.*?)\.(sample|mkv|Avi|mp4|vol|ogm|par|rar|sfv|nfo|nzb|web|rmvb|srt|ass|mpg|txt|zip|wmv|ssa|r\d{1,3}|7z|tar|cbr|cbz|mov|divx|m2ts|rmvb|iso|dmg|sub|idx|rm|t\d{1,2}|u\d{1,3})/iS""
echo "| Ordinal                       : 5"
open http://localhost/newznab/admin/group-edit.php

chmod +x newznab_local.sh
cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/
./newznab_local.sh

# screen bash
#screen
#./newznab_local.sh
#echo "ctrl-ad to detach screen"


## Additional custom NewzNAB Themes
mkdir -p ~/Github/
cd ~/Github/
git clone https://github.com/jonnyboy/Newznab-Simple-Theme.git
cp -r Newznab-Simple-Theme/simple /Users/Newznab/Sites/newznab/www/templates/simple
git clone https://github.com/sinfuljosh/bootstrapped.git
cp -r bootstrapped /Users/Newznab/Sites/newznab/www/templates/bootstrapped

## Install custom NewzNAB Update Script
## - https://github.com/NNScripts/nn-custom-scripts
mkdir -p /Users/Newznab/Sites/newznab/misc/custom
git clone https://github.com/NNScripts/nn-custom-scripts.git /Users/Newznab/Sites/newznab/misc/custom
echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| define('REMOVE', false);           : define('REMOVE', true);"
echo "-----------------------------------------------------------"
subl /Users/Newznab/Sites/newznab/misc/custom/remove_blacklist_releases.php

echo "-----------------------------------------------------------"
echo "| Install jonnyboy/newznab-tmux"
echo "-----------------------------------------------------------"
## https://github.com/jonnyboy/newznab-tmux.git

brew install htop
brew install iftop
brew install watch

cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/
git clone https://github.com/jonnyboy/newznab-tmux.git tmux
cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux

echo "-----------------------------------------------------------"
echo "| Backing up current MySQL database..."
echo "-----------------------------------------------------------"
mysqldump --opt -u root -p newznab > ~/newznab_backup.sql

echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| export NEWZPATH="/var/www/newznab" : export NEWZPATH="/Users/Newznab/Sites/newznab""
echo "| export BINARIES="false"            : export BINARIES="true""
echo "| *export BINARIES_THREADS="false"   : export BINARIES_THREADS="true""
echo "| export RELEASES="false"            : export RELEASES="true""
echo "| export OPTIMIZE="false"            : export OPTIMIZE="true""
echo "| export CLEANUP="false"             : export CLEANUP="true""
echo "| export PARSING="false"             : export PARSING="true""
echo "| export SPHINX="true"               : export SPHINX="true""
echo "| export SED="/bin/sed"              : export SED="/usr/local/bin/gsed""
echo "| "
echo "| TESTING:"
echo "| export USE_HTOP="false"            : export USE_HTOP="true""
echo "| export USE_NMON="false"            : ??" 
echo "| export USE_BWMNG="false"           : ??"
echo "| export USE_IOTOP="false"           : ??"
echo "| export USE_MYTOP="false"           : ??"
echo "| export USE_VNSTAT="false"          : ??"
echo "| export USE_IFTOP="false"           : export USE_IFTOP="true""
echo "| export POWERLINE="false"           : ??"
echo "| "
echo "| Use tmpfs to run postprocessing on true/false"
echo "| export RAMDISK="false"             : ??"

echo "| export AGREED="no"                 : export AGREED="yes""
echo "-----------------------------------------------------------"
cp config.sh defaults.sh
subl defaults.sh

echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| export NEWZPATH="/var/www/newznab" : export NEWZPATH="/Users/Newznab/Sites/newznab""
echo "-----------------------------------------------------------"
subl /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/scripts/check_svn.sh 

echo "-----------------------------------------------------------"
export NEWZPATH="/Users/Newznab/Sites/newznab"
export PASSWORD="<password>"
echo "-----------------------------------------------------------"
subl /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/scripts/update_svn.sh 

cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/scripts
sudo ./set_perms.sh

cd /Users/Newznab/Sites/newznab/misc/update_scripts/nix_scripts/tmux/
./start.sh

### ERR:
## PHP Fatal error:  Call to a member function fetch_assoc() on a non-object in /Users/Newznab/Sites/newznab/www/lib/framework/db.php on line 193
## PHP Stack trace:
## PHP   1. {main}() /Users/Newznab/Sites/newznab/misc/update_scripts/update_releases.php:0
## PHP   2. Sphinx->update() /Users/Newznab/Sites/newznab/misc/update_scripts/update_releases.php:10
## PHP   3. DB->getAssocArray() /Users/Newznab/Sites/newznab/www/lib/sphinx.php:322
##
## Fatal error: Call to a member function fetch_assoc() on a non-object in /Users/Newznab/Sites/newznab/www/lib/framework/db.php on line 193
########






## http://newznab.readthedocs.org/en/latest/misc/sphinx/

## ?? brew install sphinx
## /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf

echo "Download latest Sphinx from http://sphinxsearch.com"
#open http://sphinxsearch.com/

## which searchd
## /usr/local/bin/searchd
## which indexer
## /usr/local/bin/indexer

cd /Users/Newznab/Sites/newznab/misc/sphinx
./nnindexer.php generate

echo "Creating Lauch Agent file:"
cat >> /tmp/com.nnindexer.nnindexer.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.nnindexer.nnindexer</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/php</string>
        <string>nnindexer.php</string>
        <string>--daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/Users/Newznab/Sites/newznab/misc/sphinx</string>
</dict>
</plist>
EOF
mv /tmp/com.nnindexer.nnindexer.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.nnindexer.nnindexer.plist

./nnindexer.php daemon
./nnindexer.php index full all
./nnindexer.php index delta all
./nnindexer.php daemon --stop
./nnindexer.php daemon

#### ERR:
## WARNING: index 'releases': preload: failed to open /Users/Newznab/Sites/newznab/db/sphinxdata/releases.sph: No such file or directory; NOT SERVING
## precaching index 'releases_delta'

## /Users/Newznab/Sites/newznab/db/sphinxdata
## indexer --config /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf --all

## ./nnindexer.php search --index releases "some search term"


echo "-----------------------------------------------------------"
echo "| Configure Sphinx:"
echo "| Use Sphinx                 : Yes"
echo "| Sphinx Configuration Path  : <full path to sphinx.conf>"
echo "| Sphinx Binaries Path       : /usr/local/bin/"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin












echo "Install NewzNAB complete."

