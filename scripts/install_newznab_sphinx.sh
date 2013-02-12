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

echo "#------------------------------------------------------------------------------"
echo "# Install Sphinx for NewzNAB complete."
echo "#------------------------------------------------------------------------------"
