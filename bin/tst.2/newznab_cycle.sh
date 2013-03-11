#!/bin/sh

# call this script from within screen to get binaries, processes releases and 
# every half day get tv/theatre info and optimise the database

#set -e

RUN_PARSING="true"
REMOVESPECIAL="true"

export NEWZNAB_PATH="/Users/Newznab/Sites/newznab/misc/update_scripts"
export NEWZNAB_TESTING_PATH="/Users/Newznab/Sites/newznab/misc/testing"
export NEWZNAB_SLEEP_TIME="600" # in seconds

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GREY=$(tput setaf 238)
ORANGE=$(tput setaf 172)
BOLD=$(tput bold)
UNDERLINE=$(tput sgr 0 1)
RESET=$(tput sgr0)

NOTICE=$RESET$BOLD$BLUE
SUCCESS=$RESET$BOLD$GREEN
FAILURE=$RESET$BOLD$RED
ATTENTION=$RESET$BOLD$ORANGE
INFORMATION=$RESET$BOLD$GREY

PRINTF_MASK="%-50s %s %10s %s\n"

TIMESTAMP=`date +%Y%m%d%H%M%S`
LASTOPTIMIZE=`date +%s`

while :

 do
	CURRTIME=`date +%s`

	cd ${NEWZNAB_PATH}
	printf "$PRINTF_MASK" "Starting process $BOLD[update_binaries]$RESET" "$YELLOW" "[WAIT]" "$RESET"
	php ${NEWZNAB_PATH}/update_binaries.php
	if [ $? == 0 ] ; then
	    printf "$PRINTF_MASK" "Processing $BOLD[update_binaries]$RESET complete" "$GREEN" "[OK]" "$RESET"
	else
	    printf "$PRINTF_MASK" "Processing $BOLD[update_binaries]$RESET failed!" "$ERROR" "[ERR]" "$RESET"
	fi

	echo "---------------------------------------------------------------------------"
	printf "$PRINTF_MASK" "Starting process $BOLD[update_releases]$RESET" "$YELLOW" "[WAIT]" "$RESET"
	php ${NEWZNAB_PATH}/update_releases.php
	if [ $? == 0 ] ; then
	    printf "$PRINTF_MASK" "Processing $BOLD[update_releases]$RESET complete" "$GREEN" "[OK]" "$RESET"
	else
	    printf "$PRINTF_MASK" "Processing $BOLD[update_releases]$RESET failed!" "$RED" "[ERR]" "$RESET"
	fi

	cd ${NEWZNAB_TESTING_PATH}

	if [[ $RUN_PARSING == "true" ]]; then
		echo "---------------------------------------------------------------------------"
		printf "$PRINTF_MASK" "Starting process $BOLD[update_parsing]$RESET" "$YELLOW" "[WAIT]" "$RESET"
		php ${NEWZNAB_TESTING_PATH}/update_parsing.php
		if [ $? == 0 ] ; then
		    printf "$PRINTF_MASK" "Processing $BOLD[update_parsing]$RESET complete" "$GREEN" "[OK]" "$RESET"
		else
		    printf "$PRINTF_MASK" "Processing $BOLD[update_parsing]$RESET failed!" "$RED" "[ERR]" "$RESET"
		fi
	fi

	if [[ $REMOVESPECIAL == "true" ]]; then
		echo "---------------------------------------------------------------------------"
		printf "$PRINTF_MASK" "Starting process $BOLD[removespecial]$RESET" "$YELLOW" "[WAIT]" "$RESET"
		php ${NEWZNAB_TESTING_PATH}/removespecial.php
		if [ $? == 0 ] ; then
		    printf "$PRINTF_MASK" "Processing $BOLD[removespecial]$RESET complete" "$GREEN" "[OK]" "$RESET"
		else
		    printf "$PRINTF_MASK" "Processing $BOLD[removespecial]$RESET failed!" "$RED" "[ERR]" "$RESET"
		fi
	fi

	DIFF=$(($CURRTIME-$LASTOPTIMIZE))
	if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]
	then
	    LASTOPTIMIZE=`date +%s`

		cd ${NEWZNAB_PATH}
		echo "---------------------------------------------------------------------------"
		printf "$PRINTF_MASK" "Starting process $BOLD[optimise_db]$RESET" "$YELLOW" "[WAIT]" "$RESET"
		php ${NEWZNAB_PATH}/optimise_db.php
		if [ $? == 0 ] ; then
		    printf "$PRINTF_MASK" "Processing $BOLD[optimise_db]$RESET complete" "$GREEN" "[OK]" "$RESET"
		else
		    printf "$PRINTF_MASK" "Processing $BOLD[optimise_db]$RESET failed!" "$RED" "[ERR]" "$RESET"
		fi

		echo "---------------------------------------------------------------------------"
		printf "$PRINTF_MASK" "Starting process $BOLD[update_tvschedule]$RESET" "$YELLOW" "[WAIT]" "$RESET"
		php ${NEWZNAB_PATH}/update_tvschedule.php
		if [ $? == 0 ] ; then
		    printf "$PRINTF_MASK" "Processing $BOLD[update_tvschedule]$RESET complete" "$GREEN" "[OK]" "$RESET"
		else
		    printf "$PRINTF_MASK" "Processing $BOLD[update_tvschedule]$RESET failed!" "$RED" "[ERR]" "$RESET"
		fi

		echo "---------------------------------------------------------------------------"
		printf "$PRINTF_MASK" "Starting process $BOLD[update_theaters]$RESET" "$YELLOW" "[WAIT]" "$RESET"
		php ${NEWZNAB_PATH}/update_theaters.php
		if [ $? == 0 ] ; then
		    printf "$PRINTF_MASK" "Processing $BOLD[update_theaters]$RESET complete" "$GREEN" "[OK]" "$RESET"
		else
		    printf "$PRINTF_MASK" "Processing $BOLD[update_theaters]$RESET failed!" "$RED" "[ERR]" "$RESET"
		fi
	fi

    echo ""
	echo "==========================================================================="
	#echo "waiting ${NEWZNAB_SLEEP_TIME} seconds..."
	printf "$PRINTF_MASK" "$(date) - NewzNAB update waiting for ${NEWZNAB_SLEEP_TIME} seconds..." "$YELLOW" "[${NEWZNAB_SLEEP_TIME} seconds]" "$RESET"
	echo "==========================================================================="
	sleep ${NEWZNAB_SLEEP_TIME}

done
