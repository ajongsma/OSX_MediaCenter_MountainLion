#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

source ../defaults.sh
clear

if [[ $AGREED == "no" ]]; then
        echo "Please edit the defaults.sh file"
        exit
fi

### EDIT_THESE ###
#export INST_NEWZNAB_PATH="/User/Newznab/Sites/newznab"
export NEWZNAB_SVN_USERID="svnplus"
export NEWZNAB_SVN_PASSWORD="password"

echo svn co --force --username $NEWZNAB_SVN_USERID --password $NEWZNAB_SVN_PASSWORD svn://svn.newznab.com/nn/branches/nnplus $INST_NEWZNAB_PATH/
svn co --force --username $NEWZNAB_SVN_USERID --password $NEWZNAB_SVN_PASSWORD svn://svn.newznab.com/nn/branches/nnplus $INST_NEWZNAB_PATH/

cd $INST_NEWZNAB_PATH"/misc/update_scripts"
#php5 update_database_version.php
php update_database_version.php

#cd $INST_NEWZNAB_PATH"/misc/update_scripts/nix_scripts/tmux/scripts"
./newznab_set_perms.sh
