#!/bin/bash

# usage: $0 source_dir [source_dir] ...
# where source_dir args are directories containing git repositories

red="\033[00;31m"
green="\033[00;32m"
yellow="\033[00;33m"
blue="\033[00;34m"
purple="\033[00;35m"
cyan="\033[00;36m"

reset="\033[00m"


if [ $# -eq 0 ] ; then
  ARGS="."
else
  ARGS=$@
fi

for i in $ARGS ; do
  for gitdir in `find $i -name .git` ; do
    ( working=$(dirname $gitdir)
      cd $working
      RES=$(git status | grep -E '^# (Changes|Untracked|Your branch)')
      STAT=""
      grep -e 'Untracked' <<<${RES} >/dev/null 2>&1
      if [ $? -eq 0 ] ; then
        STAT=" $red[Untracked]$reset"
      fi
      grep -e 'Changes not staged for commit' <<<${RES} >/dev/null 2>&1
      if [ $? -eq 0 ] ; then
        STAT="$STAT $red[Modified]$reset"
      fi
      grep -e 'Changes to be committed' <<<${RES} >/dev/null 2>&1
      if [ $? -eq 0 ] ; then
        STAT="$STAT $green[Staged]$reset"
      fi
      grep -e 'Your branch is ahead' <<<${RES} >/dev/null 2>&1
      if [ $? -eq 0 ] ; then
        STAT="$STAT $yellow[Unpushed]$reset"
      fi
      grep -e 'Your branch is behind' <<<${RES} >/dev/null 2>&1
      if [ $? -eq 0 ] ; then
        STAT="$STAT $cyan[Unmerged]$reset"
      fi

      if [ -n "$STAT" ] ; then
        echo -e "$working :$STAT"
      fi
    )
  done
done