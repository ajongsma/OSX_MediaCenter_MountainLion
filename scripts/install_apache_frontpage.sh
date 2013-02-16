#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Apache Frontpage"
echo "#------------------------------------------------------------------------------"
## /Library/Server/Web/Data/Sites/Default/index.html

source ../config.sh

sudo cp -v $DIR/www/* $INST_APACHE_SYSTEM_WEB_ROOT/


if [ -e /usr/local/bin/searchd ] ; then
    printf 'local found\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'Sphinx not installed, exiting...\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi


echo "#------------------------------------------------------------------------------"
echo "# Install Apache Frontpage complete."
echo "#------------------------------------------------------------------------------"
