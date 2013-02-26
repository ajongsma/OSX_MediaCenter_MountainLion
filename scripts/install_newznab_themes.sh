#!/usr/bin/env bash

echo "-----------------------------------------------------------"
echo "| Installing additional NewzNAB themes..."
echo "-----------------------------------------------------------"
###  ToAdd ? https://github.com/Frikish/Baffi-Theme--Newznab-

source ../config.sh

[ -d ~/Github ] || mkdir -p ~/Github
cd ~/Github

for another_newznab_theme in \
    $INST_NEWZNAB_PATH/www/templates/simple \
    $INST_NEWZNAB_PATH/www/templates/bootstrapped \
    $INST_NEWZNAB_PATH/www/templates/carbon \
    $INST_NEWZNAB_PATH/www/templates/dusplic
do
    [[ -e $another_newznab_theme ]] && echo "Found theme: $another_newznab_theme" && [[ $INST_NEWZNAB_THEMES != "false" ]] && export INST_NEWZNAB_THEMES="true" || export INST_NEWZNAB_THEMES="true"
done

if [[ $INST_NEWZNAB_THEMES == "true" ]]; then
    if [ ! -d $INST_NEWZNAB_PATH/www/templates/simple ] ; then
        git clone https://github.com/jonnyboy/Newznab-Simple-Theme.git
        cp -r Newznab-Simple-Theme/simple $INST_NEWZNAB_PATH/www/templates/simple
    fi
    if [ ! -d $INST_NEWZNAB_PATH/www/templates/bootstrapped ] ; then
        git clone https://github.com/sinfuljosh/bootstrapped.git
        cp -r bootstrapped $INST_NEWZNAB_PATH/www/templates/bootstrapped
    fi
    if [ ! -d $INST_NEWZNAB_PATH/www/templates/carbon ] && [ ! -d $INST_NEWZNAB_PATH/www/templates/dusplic ]; then
        [ -d ~/Github/Newznab_Themes ] || git clone https://github.com/Xihuitl/Newznab_Themes.git
        cp -r Newznab_Themes/carbon/carbon $INST_NEWZNAB_PATH/www/templates/carbon
        cp -r Newznab_Themes/dusplic $INST_NEWZNAB_PATH/www/templates/dusplic
    fi
fi

#mkdir -p ~/Github/
#cd ~/Github/
#git clone https://github.com/jonnyboy/Newznab-Simple-Theme.git
#cp -r Newznab-Simple-Theme/simple $INST_NEWZNAB_PATH/www/templates/simple
#git clone https://github.com/sinfuljosh/bootstrapped.git
#cp -r bootstrapped $INST_NEWZNAB_PATH/www/templates/bootstrapped

#[Theme: Xihuitl] (https://github.com/Xihuitl/Newznab_Themes) ``` http://www.newznabforums.com/index.php?topic=600.0 ```

#[Theme: Baffi - Blue version] (http://www.newznabforums.com/index.php?topic=376.0)


echo "-----------------------------------------------------------"
echo "| Installing additional NewzNAB themes - Complete"
echo "-----------------------------------------------------------"

