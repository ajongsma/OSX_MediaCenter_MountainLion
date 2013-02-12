#!/usr/bin/env bash

source ../config.sh

echo "-----------------------------------------------------------"
echo "| Install NewzNAB jonnyboy/newznab-tmux"
echo "-----------------------------------------------------------"
## https://github.com/jonnyboy/newznab-tmux.git

brew install htop
brew install iftop
brew install watch

#cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/
git clone https://github.com/jonnyboy/newznab-tmux.git $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux
cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux

#echo "-----------------------------------------------------------"
#echo "| Backing up current MySQL database..."
#echo "-----------------------------------------------------------"
#mysqldump --opt -u root -p newznab > ~/newznab_backup.sql

echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| export NEWZPATH="/var/www/newznab" : export NEWZPATH="$INST_NEWZNAB_PATH/newznab""
echo "| export BINARIES="false"            : export BINARIES="true""
echo "| export RELEASES="false"            : export RELEASES="true""
echo "| export OPTIMIZE="false"            : export OPTIMIZE="true""
echo "| export CLEANUP="false"             : export CLEANUP="true""
echo "| export PARSING="false"             : export PARSING="true""
echo "| export SPHINX="true"               : export SPHINX="true""
echo "| export SED="/bin/sed"              : export SED="/usr/local/bin/gsed""
echo "| export USE_HTOP="false"            : export USE_HTOP="true""
echo "| export USE_IFTOP="false"           : export USE_IFTOP="true""

echo "| "
echo "| TESTING:"
echo "| *export BINARIES_THREADS="false"   : export BINARIES_THREADS="true""
echo "| export USE_NMON="false"            : ??" 
echo "| export USE_BWMNG="false"           : ??"
echo "| export USE_IOTOP="false"           : ??"
echo "| export USE_MYTOP="false"           : ??"
echo "| export USE_VNSTAT="false"          : ??"
echo "| export POWERLINE="false"           : ??"
echo "| "
echo "| Use tmpfs to run postprocessing on true/false"
echo "| export RAMDISK="false"             : ??"
echo "| export AGREED="no"                 : export AGREED="yes""
echo "-----------------------------------------------------------"
cp config.sh defaults.sh
subl defaults.sh
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| export NEWZPATH="/var/www/newznab" : export NEWZPATH="$INST_NEWZNAB_PATH""
echo "-----------------------------------------------------------"
subl $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux/scripts/check_svn.sh 
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
export NEWZPATH="/Users/Newznab/Sites/newznab"
export PASSWORD="<nnplus password>"
echo "-----------------------------------------------------------"
subl $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux/scripts/update_svn.sh 
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux/scripts
sudo ./set_perms.sh

cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/tmux/
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
