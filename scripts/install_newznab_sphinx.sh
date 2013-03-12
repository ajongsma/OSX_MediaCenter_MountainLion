#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Install Sphinx for NewzNAB
#------------------------------------------------------------------------------
## http://newznab.readthedocs.org/en/latest/misc/sphinx/
## /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf

source ../config.sh

if [ -e /usr/local/bin/searchd ] ; then
    printf 'local found\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'Sphinx not installed, exiting...\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit
fi

cd $INST_NEWZNAB_PATH/misc/sphinx
./nnindexer.php generate

./nnindexer.php daemon
./nnindexer.php index full all
./nnindexer.php index delta all
./nnindexer.php daemon --stop
./nnindexer.php daemon

#### ERR: ###
## WARNING: index 'releases': preload: failed to open /Users/Newznab/Sites/newznab/db/sphinxdata/releases.sph: No such file or directory; NOT SERVING
## precaching index 'releases_delta'
##   /Users/Newznab/Sites/newznab/db/sphinxdata
## indexer --config /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf --all
## ./nnindexer.php search --index releases "some search term"
##   /Users/Newznab/Sites/newznab/db/sphinxdata/releases.sph
#############

if [ -e /Users/Newznab/Sites/newznab/db/sphinxdata/releases.sph ] ; then
    printf 'Sphinx data releases.sph found\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'Sphinx data releases.sph not found, initializing full indexing\n' "$YELLOW" $col '[WAIT]' "$RESET"
    indexer --config /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf --all
    ./nnindexer.php index full all
    ./nnindexer.php index delta all
    ./nnindexer.php daemon --stop
    ./nnindexer.php daemon
fi

echo "-----------------------------------------------------------"
echo "| Sphinx Settings:"
echo "| Use Sphinx                 : Yes"
#echo "| Sphinx Configuration Path  : /Users/Newznab/Sites/newznab/db/sphinxdata/sphinx.conf"
echo "| Sphinx Configuration Path  : $INST_NEWZNAB_PATH/db/sphinxdata/sphinx.conf"
echo "| Sphinx Binaries Path       : /usr/local/bin/"
echo "-----------------------------------------------------------"
open http://localhost/newznab/admin/site-edit.php

INST_FILE_LAUNCHAGENT="com.sphinxsearch.searchd.plist"
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
else
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | LaunchAgent file not found: ${RESET}"
    echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
    echo -e "${RED} | --- press any key to continue --- ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
    sudo mv /tmp/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
fi
launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT

echo "#------------------------------------------------------------------------------"
echo "# Install Sphinx for NewzNAB complete."
echo "#------------------------------------------------------------------------------"
