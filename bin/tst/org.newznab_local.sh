#!/bin/sh
# call this script from within screen to get binaries, processes releases and 
# every half day get tv/theatre info and optimise the database

set -e

export NEWZNAB_PATH="/Users/Newznab/Sites/newznab"
export NEWZNAB_PATH_UPDATE_SCRIPTS="${NEWZNAB_PATH}/misc/update_scripts"
export NEWZNAB_PATH_TEST_SCRIPTS="${NEWZNAB_PATH}/misc/testing"
export NEWZNAB_SLEEP_TIME="600" # in seconds
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
	cd ${NEWZNAB_PATH_UPDATE_SCRIPTS}
	echo "${RED}==> ${BLUE}Updating Binaries... ${RESET}"
	echo "    ${BLUE}Updating Releases... ${RESET}"
	echo "    ${BLUE}Updating Parsing... ${RESET}"
	echo "    ${BLUE}Updating Release Groups... ${RESET}"
	/usr/local/Cellar/php54/5.4.11/bin/php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/update_binaries.php
	echo "    ${BLUE}Updating Binaries... ${RESET}"
	echo "${RED}==> ${BLUE}Updating Releases... ${RESET}"
	echo "    ${BLUE}Updating Parsing... ${RESET}"
	echo "    ${BLUE}Updating Release Groups... ${RESET}"
	/usr/local/Cellar/php54/5.4.11/bin/php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/update_releases.php

	# TESTING
	echo "    ${BLUE}Updating Binaries... ${RESET}"
	echo "    ${BLUE}Updating Releases... ${RESET}"
	echo "${RED}==> ${BLUE}Updating Parsing... ${RESET}"
	echo "    ${BLUE}Updating Release Groups... ${RESET}"
	cd ${NEWZNAB_PATH_TEST_SCRIPTS}
	/usr/local/Cellar/php54/5.4.11/bin/php ${NEWZNAB_PATH_TEST_SCRIPTS}/update_parsing.php
	echo "    ${BLUE}Updating Binaries... ${RESET}"
	echo "    ${BLUE}Updating Releases... ${RESET}"
	echo "    ${BLUE}Updating Parsing... ${RESET}"
	echo "${RED}==> ${BLUE}Updating Release Groups... ${RESET}"
	cd ${NEWZNAB_PATH_UPDATE_SCRIPTS}
	/usr/local/Cellar/php54/5.4.11/bin/php ${NEWZNAB_PATH_UPDATE_SCRIPTS}/update_release_groups.php

		DIFF=$(($CURRTIME-$LASTOPTIMIZE))
		if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]
		then
			LASTOPTIMIZE=`date +%s`
			/usr/local/Cellar/php54/5.4.11/bin/php ${NEWZNAB_PATH}/misc/update_scripts/optimise_db.php
			/usr/local/Cellar/php54/5.4.11/bin/php ${NEWZNAB_PATH}/misc/update_scripts/update_tvschedule.php
			/usr/local/Cellar/php54/5.4.11/bin/php ${NEWZNAB_PATH}/misc/update_scripts/update_theaters.php
		fi

	echo ""
	echo "${GREEN} $(date) - NewzNAB update waiting for ${NEWZNAB_SLEEP_TIME} seconds...${RESET}"
	sleep ${NEWZNAB_SLEEP_TIME}
done
