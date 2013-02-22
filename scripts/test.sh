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

function log () {
  echo -e "$1"
  #echo -e $@ >> $LOGFILE
}

function homebrew_checkinstall_recipe () {
  brew list $1 &> /dev/null
  if [ $? == 0 ]; then
    log "${SUCCESS}Your $package$1 ${SUCCESS}installation is fine. Doing nothing"
  else
    install_homebrew $1
  fi
}

function install_homebrew () {
  log "${notice}Installing ${component}Homebrew ${notice}recipe ${package}$1"
  if [ $DEBUG == 0 ]; then
    HOMEBREW_OUTPUT=`brew install $1 2>&1`
    handle_error $1 "Homebrew had a problem\n($HOMEBREW_OUTPUT):"
  fi
}

check_command_dependency brew

