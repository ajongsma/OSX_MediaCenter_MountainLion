#!/usr/bin/env bash

cd $HOME/Library/LaunchAgents/
for _file in `ls *.plist`; do
  #t=`echo $_file | sed 's/\.xml$/.txt/'`; 
  #mv $_file $t && echo "moved $x -> $t"

  echo "Found file: $_file"
  [[ ! -z $_file ]] && echo "Checking availability of $_file: Ok"
done
unset _file
