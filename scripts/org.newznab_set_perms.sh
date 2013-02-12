#!/usr/bin/env bash

## SOURCE="${BASH_SOURCE[0]}"
## DIR="$( dirname "$SOURCE" )"
## while [ -h "$SOURCE" ]
## do
##   SOURCE="$(readlink "$SOURCE")"
##   [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
##   DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
## done
## DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
## 

## Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

source ../defaults.sh
## clear

if [[ $AGREED == "no" ]]; then
        echo "Please edit the defaults.sh file"
        exit
fi

sudo mkdir $INST_NEWZNAB_PATH/nzbfiles/tmpunrar

echo "Fixing permisions, this can take some time if you have a large set of releases"
sudo chmod 777 $INST_NEWZNAB_PATH/lib/smarty/templates_c
sudo chmod -R 777 $INST_NEWZNAB_PATH/covers
sudo chmod 777 $INST_NEWZNAB_PATH
sudo chmod 777 $INST_NEWZNAB_PATH/install
sudo chmod -R 777 $INST_NEWZNAB_PATH/nzbfiles/
sudo chmod 777 $INST_NEWZNAB_PATH/db

echo -e "\033[38;5;160mCompleted\033[39m"

exit
