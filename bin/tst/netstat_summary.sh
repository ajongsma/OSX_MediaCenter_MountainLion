#!/bin/sh
# 
# Shows network bandwidth usage.
# 
# Copyright (c) 2009 by alexyu.se. All rights reserved.
#
# This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#

function printHeader ()
{
  printf "Uptime `uptime | awk '{if ($4 == "days," || $4 == "day,") print $3,$4,$5; else if ($4 == "mins,") print $3,$4; else print $3 " hours "}' | sed s/,//`"
	printf " `date` \n"
	printf "%-5s  " "Iface"
	printf "%10s   " "  Rx Total"
	printf "%10s   " "  Tx Total"
	printf "%10s   " "Rx/day"
	printf "%10s   " "Tx/day"
	printf "%10s   " "Rx/month"
	printf "%10s   " "Tx/month"
	printf "%10s\n" "Rx+Tx/month"
	
	printf "%-5s  " " "
	printf "%10s   " "(GB)"
	printf "%10s   " "(GB)"
	printf "%10s   " "(MB)"
	printf "%10s   " "(MB)"
	printf "%10s   " "(GB)"
	printf "%10s   " "(GB)"
	printf "%10s\n" "(GB)"	
}

function printSummary ()
{
	printf "%-5s  " $INTERFACE_NAME
	printf "%10s   " $(echo "scale=2; $TOTAL_IN/1000000000" | bc) 
	printf "%10s   " $(echo "scale=2; $TOTAL_OUT/1000000000" | bc) 
	printf "%10s   " $(echo "scale=2; $TOTAL_IN*86400/$UPTIME_SECS/1000000" | bc)  
	printf "%10s   " $(echo "scale=2; $TOTAL_OUT*86400/$UPTIME_SECS/1000000" | bc) 
	printf "%10s   " $(echo "scale=2; $TOTAL_IN*86400*30/$UPTIME_SECS/1000000000" | bc) 
	printf "%10s   " $(echo "scale=2; $TOTAL_OUT*86400*30/$UPTIME_SECS/1000000000" | bc) 
	printf "%10s\n" $(echo "scale=2; ($TOTAL_OUT+$TOTAL_IN)*86400*30/$UPTIME_SECS/1000000000" | bc)	
}

UPTIME_SECS=`uptime | awk '{ split($3,b,":"); split($5,a,":"); if (a[2] == 0) print b[1]*86400+(a[1]*60); else print b[1]*86400+a[1]*3600+a[2]*60}'`
INTERFACES=`netstat -b -i | awk '{if ($5 > 0 && $8 > 0) print $1,$7,$10}' | grep -i -v name | uniq`

printHeader

for i in $INTERFACES
do
	(( count++ ))
	if (($count % 3 == 1))
	then
		INTERFACE_NAME=$i
	elif (($count % 3 == 2));
	then
		TOTAL_IN=$i
	elif (($count % 3 == 0));
	then
		TOTAL_OUT=$i
	printSummary $INTERFACE_NAME $TOTAL_IN $TOTAL_OUT
	fi
done
