#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd - Apache webapp"
echo "#------------------------------------------------------------------------------"

source ../config.sh

if [ -d /Library/Server/Web/Config/apache2/webapps ] ; then
	echo "Apache WebApp directory found. Copying SABnzbd webapp config file"
    cp conf/webapps/org.sabnzbd.plist /Library/Server/Web/Config/apache2/webapps/
    if [ ! -f /Library/Server/Web/Config/apache2/webapps/org.sabnzbd.plist ] ; then

	    echo "SABnzbd webapp config file found. Enabling..."
	    sudo webappctl start /Library/Server/Web/Config/apache2/webapps/org.sabnzbd.plist
	else
		echo "SABnzbd webapp config file not found. Failed!"
	fi
fi

echo "#------------------------------------------------------------------------------"
echo "# Install SABnzbd - Apache webapp - Complete"
echo "#------------------------------------------------------------------------------"
