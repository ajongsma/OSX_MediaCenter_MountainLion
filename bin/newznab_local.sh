#!/bin/sh
# call this script from within screen to get binaries, processes releases and 
# every half day get tv/theatre info and optimise the database

set -e

export NEWZNAB_PATH="/Users/Newznab/Sites/newznab/misc/update_scripts"
export NEWZNAB_SLEEP_TIME="600" # in seconds
LASTOPTIMIZE=`date +%s`

while :

 do
CURRTIME=`date +%s`
cd ${NEWZNAB_PATH}
php ${NEWZNAB_PATH}/update_binaries.php
php ${NEWZNAB_PATH}/update_releases.php

DIFF=$(($CURRTIME-$LASTOPTIMIZE))
if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]
then
	LASTOPTIMIZE=`date +%s`
	php ${NEWZNAB_PATH}/optimise_db.php
	php ${NEWZNAB_PATH}/update_tvschedule.php
	php ${NEWZNAB_PATH}/update_theaters.php
fi

echo "waiting ${NEWZNAB_SLEEP_TIME} seconds..."
sleep ${NEWZNAB_SLEEP_TIME}

done
