#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Install NewzNAB Custom Update Scripts
#------------------------------------------------------------------------------
## https://github.com/NNScripts/nn-custom-scripts

source ../config.sh

if [ ! -d $INST_NEWZNAB_PATH/misc/custom ] ; then
    mkdir -p $INST_NEWZNAB_PATH/misc/custom
fi

#git clone https://github.com/NNScripts/nn-custom-scripts.git /Users/Newznab/Sites/newznab/misc/custom
git clone https://github.com/NNScripts/nn-custom-scripts.git $INST_NEWZNAB_PATH/misc/custom

echo "-----------------------------------------------------------"
echo "| Change the following settings:"
echo "| define('REMOVE', false);           : define('REMOVE', true);"
echo "-----------------------------------------------------------"
subl /Users/Newznab/Sites/newznab/misc/custom/remove_blacklist_releases.php

echo "Completed - NewzNAB Custom Update Scripts"
