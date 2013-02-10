#!/bin/sh
# call this script from within screen to get binaries, processes releases and
# every half day get tv/theatre info and optimise the database

set -e

export NEWZNAB_PATH="/Users/Newznab/Sites/newznab"
export NEWZNAB_PATH_UPDATE_SCRIPTS="${NEWZNAB_PATH}/misc/update_scripts"
export NEWZNAB_PATH_NIX_SCRIPTS="${NEWZNAB_PATH}/misc/update_scripts/nix_scripts"
export NEWZNAB_SLEEP_TIME="600" # in seconds

while :
 do
	CURRTIME=`date +%s`
#	cd ${NEWZNAB_PATH_NIX_SCRIPTS}
	./newznab_local.sh

#	#cd ${NEWZNAB_PATH}
#	#php ${NEWZNAB_PATH}/retrieve.php
#
#	#php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/update_releases.php
#	#php /var/www/newznab/www/admin/nzb-importmodified.php 
#	#/var/www/newznab/tempnzbs/ true
#	cd ${NEWZNAB_PATH_UPDATE_SCRIPTS}
#	php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/update_releases.php
#
#	DIFF=$(($CURRTIME-$LASTOPTIMIZE))
#	if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]
#	then
#	        LASTOPTIMIZE=`date +%s`
#	        php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/optimise_db.php
#	        php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/update_tvschedule.php
#	        php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/update_theaters.php
#	fi
#
#	echo "$(date) - waiting ${NEWZNAB_SLEEP_TIME} seconds..."
#	sleep ${NEWZNAB_SLEEP_TIME}
done
