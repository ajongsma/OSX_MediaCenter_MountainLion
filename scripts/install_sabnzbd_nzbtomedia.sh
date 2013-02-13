#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd - nzbToMedia"
echo "#------------------------------------------------------------------------------"
## https://github.com/clinton-hall/nzbToMedia

source ../config.sh

[ -d ~/Github ] || mkdir -p ~/Github

cd ~/Github/
git clone https://github.com/clinton-hall/nzbToMedia
cp -R ~/Github/nzbToMedia/* ~/Library/Application\ Support/SABnzbd/scripts/
#cp /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/

cd ~/Library/Application\ Support/SABnzbd/scripts/
if [ ! -f autoProcessMedia.cfg ] ; then
    cp autoProcessMedia.cfg.sample autoProcessMedia.cfg
fi

#cp autoProcessTV.cfg.sample autoProcessTV.cfg
#cp autoProcessMovie.cfg.sample autoProcessMovie.cfg
#echo "-----------------------------------------------------------"
#echo "| Modify the following:"
#echo "| port=8081"
#echo "| username=couchpotato"
#echo "| password=<password>"
#echo "| web_root="
#echo "-----------------------------------------------------------"
#subl autoProcessTV.cfg

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd - nzbToMedia - Complete"
echo "#------------------------------------------------------------------------------"

