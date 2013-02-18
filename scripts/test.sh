source ../config.sh

## TESTING: Aligned printing

echo "#----------------------------------------------------------\n"

$mask = "%20s %20.20s %20.20s\n";
printf("\033[1;33m\n");
printf($mask, "Category", "State", "Reason");
printf($mask, "==================", "==================", "==================");
printf("\033[38;5;214m");
printf($mask, "aaaa", "123123", "[OK]");
printf($mask, "bbbbbbbbbbbbb", "234", "[ERR]");
printf($mask, "cc", "34567", "[FAIL]");
printf($mask, "d", "4567890", "[PROCESSING");

echo "#----------------------------------------------------------\n"


shell_exec("./check_process.sh mediainfo {$array['KILL_PROCESS']}");
shell_exec("./check_process.sh ffmpeg {$array['KILL_PROCESS']}");


check_process.sh:

#!/usr/bin/env bash
source ../config.sh
source ../defaults.sh

threshold=$2
process=$1

#set path
export alienx="$DIR/alienx"

#commands for start/stop newzdash tracking
export ds1="cd $alienx && $PHP tmux_to_newzdash.php";
export ds4="killed";

time=($(ps -eao "%C %U %c %t" | awk "/$process/"'{print $4}' | awk -F":" '{{a=$1*60} {b=a+$2}; if ( NF != 2 ) print b ; else print $1 }'))
real_time=($(ps -eao "%C %U %c %t" | awk "/$process/"'{print $4}'))
pid=($(ps -eao "%P %C %U %c %t" | awk "/$process/"'{print $1}'))

i=0
for proc in "${time[@]}"
do
  if [ $proc -ge $threshold ]; then
    if [ ${pid[$i]} -gt "1000" ]; then
      echo "\033[1;31m $process pid ${pid[$i]} has been running for ${real_time[$i]} and will be killed.\033[0m && $ds1 $ds4"
      kill -s 9 ${pid[$i]}
    fi
  fi
  i=$i+1
done
