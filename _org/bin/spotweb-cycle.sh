#!/bin/sh
# call this script from within screen to get binaries, processes releases and
# every half day get tv/theatre info and optimise the database

set -e

export SPOTWEB_PATH="/Users/Spotweb/Sites/spotweb"
export SPOTWEB_SLEEP_TIME="600" # in seconds
LASTOPTIMIZE=`date +%s`

BOLD=$(tput bold)
BLACK=$(tput setaf 0) #   0  Black
RED=$(tput setaf 1)  #  1   Red
GREEN=$(tput setaf 2)  #    2   Green
YELLOW=$(tput setaf 3)  #   3   Yellow
BLUE=$(tput setaf 4)  #     4   Blue
MAGENTA=$(tput setaf 5)  #  5   Magenta
CYAN=$(tput setaf 6)  #     6   Cyan
WHITE=$(tput setaf 7)  #    7   White
RESET=$(tput sgr0)
col=40

while :
 do
	CURRTIME=`date +%s`
	cd ${SPOTWEB_PATH}
	php ${SPOTWEB_PATH}/retrieve.php

	#php ${SPOTWEB_PATH}/update_releases.php
	#php /var/www/newznab/www/admin/nzb-importmodified.php 
	#/var/www/newznab/tempnzbs/ true
	#php ${SPOTWEB_PATH}/update_releases.php

#	DIFF=$(($CURRTIME-$LASTOPTIMIZE))
#	if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]
#	then
#	        LASTOPTIMIZE=`date +%s`
#	        php ${SPOTWEB_PATH}/optimise_db.php
#	        php ${SPOTWEB_PATH}/update_tvschedule.php
#	        php ${SPOTWEB_PATH}/update_theaters.php
#	fi
	echo ""
	echo "${GREEN} $(date) - Spotweb update waiting for ${SPOTWEB_SLEEP_TIME} seconds...${RESET}"
	sleep ${SPOTWEB_SLEEP_TIME}
done