#!/bin/sh

# call this script from within screen to get binaries, processes releases and 
# every half day get tv/theatre info and optimise the database

#set -e

RUN_PARSING="true"
REMOVESPECIAL="true"

export NEWZNAB_PATH="/Users/Newznab/Sites/newznab/misc/update_scripts"
export NEWZNAB_TESTING_PATH="/Users/Newznab/Sites/newznab/misc/testing"
export NEWZNAB_SLEEP_TIME="600" # in seconds

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

PRINTF_MASK="%-50s %s %10s %s\n"

LASTOPTIMIZE=`date +%s`

while :

 do
CURRTIME=`date +%s`

cd ${NEWZNAB_PATH}
printf "$PRINTF_MASK" "Starting process" "$YELLOW" "[update_binaries]" "$RESET"
php ${NEWZNAB_PATH}/update_binaries.php
if [ $? == 0 ] ; then
    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "[update_binaries]" "$RESET"
else
    printf "$PRINTF_MASK" "Processing failed!" "$ERROR" "[update_binaries]" "$RESET"
fi

echo "---------------------------------------------------------------------------"
printf "$PRINTF_MASK" "Starting process" "$YELLOW" "[update_releases]" "$RESET"
php ${NEWZNAB_PATH}/update_releases.php
if [ "$?"-ne 0]; then
    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "[update_releases]" "$RESET"
else
    printf "$PRINTF_MASK" "Processing failed!" "$RED" "[update_releases]" "$RESET"
fi

cd ${NEWZNAB_TESTING_PATH}

if [[ $RUN_PARSING == "true" ]]; then
	echo "---------------------------------------------------------------------------"
	printf "$PRINTF_MASK" "Starting process" "$YELLOW" "[update_parsing]" "$RESET"
	php ${NEWZNAB_TESTING_PATH}/update_parsing.php
	if [ $? == 0 ] ; then
	    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "[update_releases]" "$RESET"
	else
	    printf "$PRINTF_MASK" "Processing failed!" "$RED" "[update_releases]" "$RESET"
	fi
fi

if [[ $REMOVESPECIAL == "true" ]]; then
	echo "---------------------------------------------------------------------------"
	printf "$PRINTF_MASK" "Starting process" "$YELLOW" "[removespecial" "$RESET"
	php ${NEWZNAB_TESTING_PATH}/removespecial.php
	if [ $? == 0 ] ; then
	    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "[removespecial]" "$RESET"
	else
	    printf "$PRINTF_MASK" "Processing failed!" "$RED" "[removespecial]" "$RESET"
	fi
fi

DIFF=$(($CURRTIME-$LASTOPTIMIZE))
if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]
then
    LASTOPTIMIZE=`date +%s`

	cd ${NEWZNAB_PATH}
	echo "---------------------------------------------------------------------------"
	printf "$PRINTF_MASK" "Starting process" "$YELLOW" "[optimise_db" "$RESET"
	php php ${NEWZNAB_PATH}/optimise_db.php
	if [ $? == 0 ] ; then
	    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "[optimise_db]" "$RESET"
	else
	    printf "$PRINTF_MASK" "Processing failed!" "$RED" "[optimise_db]" "$RESET"
	fi

	echo "---------------------------------------------------------------------------"
	printf "$PRINTF_MASK" "Starting process" "$YELLOW" "[update_tvschedule]" "$RESET"
	php ${NEWZNAB_PATH}/update_tvschedule.php
	if [ $? == 0 ] ; then
	    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "[update_tvschedule]" "$RESET"
	else
	    printf "$PRINTF_MASK" "Processing failed!" "$RED" "[update_tvschedule]" "$RESET"
	fi

	echo "---------------------------------------------------------------------------"
	printf "$PRINTF_MASK" "Starting process" "$YELLOW" "[update_theaters]" "$RESET"
	php ${NEWZNAB_PATH}/update_theaters.php
	if [ $? == 0 ] ; then
	    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "[update_theaters]" "$RESET"
	else
	    printf "$PRINTF_MASK" "Processing failed!" "$RED" "[update_theaters]" "$RESET"
	fi
fi

echo "==========================================================================="
#echo "waiting ${NEWZNAB_SLEEP_TIME} seconds..."
printf "$PRINTF_MASK" "$(date) - NewzNAB update waiting for ${NEWZNAB_SLEEP_TIME} seconds..." "$YELLOW" "[${NEWZNAB_SLEEP_TIME} seconds]" "$RESET"
echo "==========================================================================="
sleep ${NEWZNAB_SLEEP_TIME}

done
