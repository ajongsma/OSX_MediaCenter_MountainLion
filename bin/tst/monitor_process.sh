#!bin/sh

PROCCHECKDELAY=1
RUNCHECKDELAY=2
PROCNORUN=
PAGEROWS=80
PROCNAME=$1
PROCID=

if [ $# -ne 1 ]
then
 echo give program name to watch;
 exit 1;
fi

stat_process()
{
 PROCID=
 _mypid=
 while [ true ]
 do
   _mypid=`ps -e 2>/dev/null|grep $1|head -n1|awk '{ print $1 }'`;
   if [ ! -z "$_mypid" ]
   then
     PROCNORUN=
     break;
   fi
   if [ -z "$PROCNORUN" ] ;
   then
     PROCNORUN=yes
     echo "$1 is not running"
     echo "recheck after $RUNCHECKDELAY seconds";
     sleep $RUNCHECKDELAY;
   fi
 done
 PROCID=$_mypid;
}

i=$PAGEROWS;
while true;
do
stat_process $PROCNAME;

if [ $i -eq $PAGEROWS ] ;
then
 i=0;
 UNIX95= ps -p $PROCID -o vsz,pid,ruser,rss,pcpu,pmem,args 2>/dev/null
else
 UNIX95= ps -p $PROCID -o vsz,pid,ruser,rss,pcpu,pmem,args 2>/dev/null|tail +2
fi
if [ ! -z "$PROCID" ]
then
   i=`expr $i + 1`;
fi
sleep $PROCCHECKDELAY;
done;
