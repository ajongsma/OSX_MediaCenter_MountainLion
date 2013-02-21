#!/bin/bash

if [ -z $1 ] ; then
  echo "Usage: $0 [start|stop|restart] "
  exit 1
fi

# Source the common setup functions for startup scripts
test -r /etc/rc.common || exit 1
. /etc/rc.common

# Set up some defaults
TST_PATH_PID='/var/log/test.log'
PATH_LOG='/var/log/test.log'
TST_PORT=80

StartService(){
  /usr/local/bin/<something><something> run --logpath=$PATH_LOG --port $TST_PORT > /dev/null 2>&1 &
}

StopService() {
	pidfile=$TST_PATH_PID/test.lock

	# If the lockfile exists, it contains the PID
	if [ -e $pidfile ]; then
		pid=`cat $pidfile`
	fi

	# If we don't have a PID, check for it
	if [ "$pid" == "" ]; then
		pid=`/usr/sbin/lsof -i tcp:$TST_PORT | tail -1 | awk '{print $2}'`
	fi

	# If we've found a PID, let's kill it
	if [ "$pid" != "" ]; then
		kill -15 $pid
	fi
}

RestartService() {
	StopService
	sleep 3
	StartService
}

RunService $1
