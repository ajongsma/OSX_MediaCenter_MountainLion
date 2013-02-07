#!/usr/bin/env bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

### EDIT_THESE ###
export NEWZNAB_PATH="/User/Newznab/Sites/newznab"
export NEWZNAB_SVN_USERID="svnplus"
export NEWZNAB_SVN_PASSWORD="password"

svn co --force --username $NEWZNAB_SVN_USERID --password $NEWZNAB_SVN_PASSWORD svn://svn.newznab.com/nn/branches/nnplus $NEWZNAB_PATH/

cd $NEWZNAB_PATH"/misc/update_scripts"
#php5 update_database_version.php
php update_database_version.php

cd $NEWZNAB_PATH"/misc/update_scripts/nix_scripts/tmux/scripts"
./set_perms.sh
