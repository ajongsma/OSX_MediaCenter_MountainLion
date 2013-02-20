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


command -v brew >/dev/null 2>&1 || { echo >&2 "I require Homebrew but it's not installed.     [ERR]"; } && { echo >&2 "Homebrew installed      [OK]"; }

cd ${NEWZNAB_PATH}
printf "$PRINTF_MASK" "Starting process" "$YELLOW" "111" "$RESET"
php ${NEWZNAB_PATH}/update_binaries1.php
#if [ "$?"-ne 0]; then
if [ $? == 0 ] ; then
    printf "$PRINTF_MASK" "Processing complete" "$GREEN" "aaa" "$RESET"
else
    printf "$PRINTF_MASK" "Processing failed!" "$ERROR" "bbb" "$RESET"
fi