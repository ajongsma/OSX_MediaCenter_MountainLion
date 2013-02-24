

function log()  {
	printf "$*\n" ;
	return $? ;
}

function handle_error () {
  if [ "$?" != "0" ]; then
    log "${failure}$2 $1"
    exit 1
  fi
}

function fail() {
	log "\nERROR: $*\n" ;
	exit 1 ; 
}

function check_system() {
    # Check for supported system
    kernel=`uname -s`
    case $kernel in
        Linux) ;;
        *) fail "Sorry, $kernel is not supported." ;;
    
    esac
}

check_system