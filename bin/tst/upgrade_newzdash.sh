#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Updating NewzDash"
echo "#------------------------------------------------------------------------------"

set -e

## Example: /Users/NewzDash/Sites/newzdash
export UPD_NEWZDASH_PATH="/Users/Newzdash/Sites/newzdash"

if [ -z "${UPD_NEWZDASH_PATH}" ] || [ ! -d "${UPD_NEWZDASH_PATH}" ]; then
  echo "Directory $NEWZDASH_PATH not found. Aborting ..."
  exit 0
fi

#---------

__vcs_status() {
  if type -p __git_ps1; then
    branch=$(__git_ps1)
  else
    branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  fi
  if [ $branch ]; then
    # not updated
    color="${txtpur}"
    status=$(git status --porcelain 2> /dev/null)
    # if we have non untracked files (blue)
    if $(echo "$status" | grep '?? ' &> /dev/null); then
      color="${txtblu}"
    fi
    #  added to index (green)
    if $(echo "$status" | grep '^A  ' &> /dev/null); then
      color="${txtgrn}"
    fi
    # updated in index (Cyan)
    if $(echo "$status" | grep '^ M ' &> /dev/null); then
      color="${txtcyn}"
    fi
    #  deleted from index (red)
    if $(echo "$status" | grep '^ D ' &> /dev/null); then
      color="${txtred}"
    fi
    echo -e $color
  fi
}
__vcs_branch() {
  _bold=$(tput bold)
  _normal=$(tput sgr0)
  local vcs base_dir sub_dir ref

  git_dir() {
    if type -p __git_ps1; then
      pr=$(__git_ps1)
    else
      pr=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
    fi
    if [ !$pr ]; then
      return 1
    fi
  }

  sub_dir() {
    local sub_dir
    sub_dir=$(stat -f "${PWD}")
    sub_dir=${sub_dir#$1}
    echo ${sub_dir#/}
  }

  svn_dir() {
    [ -d ".svn" ] || return 1
    base_dir="."
    while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
    base_dir=$(stat -f "$base_dir")
    sub_dir=$(sub_dir "${base_dir}")
    ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
    vcs="svn"
    pr="($vcs|$ref)"
  }

  svk_dir() {
    [ -f ~/.svk/config ] || return 1
    base_dir=$(awk '/: *$/ { sub(/^ */,"",$0); sub(/: *$/,"",$0); if (match("'${PWD}'", $0?(/|$)")) { print $0; d=1; } } /depotpath/ && d == 1 { sub(".*/","",$0); r=$0 } /revision/ && d == 1 { print r ":" $2; exit 1 }' ~/.svk/config) && return 1
    ref=${base_dir##*}
    base_dir=${base_dir%%*}
    sub_dir=$(sub_dir "${base_dir}")
    vcs="svk"
    pr="($vcs|$ref)"
  }

  hg_dir() {
    hg_root=$(hg root 2>&1 | egrep -v "$abort:");
    if [ $hg_root ]; then
      base_dir=$hg_root
      sub_dir=$(sub_dir base_dir)
      hg_branch=$(hg branch);
      vcs="hg"
      ref=$hg_branch
      pr="($vcs|$ref)"
    else
      return 1
    fi;
  }
  # comment in case if no git-completion is avaliable
  git_dir ||
  svn_dir ||
  svk_dir ||
  hg_dir ||
  base_dir="$PWD"

  #echo "${vcs:+($vcs)}${_bold}${base_dir/$HOME/~}${_normal}${vcs:+[$ref]${_bold}${sub_dir}${_normal}}"
  echo -e $pr
}

txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
txtwht='\033[0;37m' # White
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan
bldwht='\033[1;37m' # White
unkblk='\033[4;30m' # Black - Underline
undred='\033[4;31m' # Red
undgrn='\033[4;32m' # Green
undylw='\033[4;33m' # Yellow
undblu='\033[4;34m' # Blue
undpur='\033[4;35m' # Purple
undcyn='\033[4;36m' # Cyan
undwht='\033[4;37m' # White
bakblk='\033[40m'   # Black - Background
bakred='\033[41m'   # Red
badgrn='\033[42m'   # Green
bakylw='\033[43m'   # Yellow
bakblu='\033[44m'   # Blue
bakpur='\033[45m'   # Purple
bakcyn='\033[46m'   # Cyan
bakwht='\033[47m'   # White
txtrst='\033[m'   # Text Reset

# git showing branch name in prompt
##export PS1='\u@\h:\w''$(__git_ps1 " (%s)")''\$ '
#export PS1="\u\[${txtpur}\]@\[${txtrst}\]\h\[${txtpur}\]:\[${txtrst}\]\w\["'$(__vcs_status)'"\]"'$(__vcs_branch)'"\[${txtrst}\]\[${txtpur}\]\$ \[${txtrst}\]"


#---------

test -n "$(git status --porcelain)"
if [ -n "$(git status --porcelain)" ]; then 
  echo "Updates available";
else 
  echo "No updates available";
fi

#git status | grep 'nothing to commit' && echo 'you are clean'
#git status --porcelain | egrep "^D" | sed -e 's/^D  //'
#git status -s | grep -q '^.M'

# Check existance PID
if [ -f "${UPD_NEWZDASH_PATH}/.upgrade.newzdash" ]; then
  echo "PID file exists."
  echo "If needed, please remove file ${UPD_NEWZDASH_PATH}/.upgrade.newzdash manually"
  exit 1
else
  cd "${UPD_NEWZDASH_PATH}"

  if [ -n "$(git status --porcelain)" ]; then 
    echo "Updates available"; 
  else 
    echo "No updates available";
  fi

#echo \u\[${txtpur}\]@\[${txtrst}\]\h\[${txtpur}\]:\[${txtrst}\]\w\["'$(__vcs_status)'"\]"'$(__vcs_branch)'"\[${txtrst}\]\[${txtpur}\]\$ \[${txtrst}\]

exit

  read -p "Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
      doIt
  else
    exit
  fi

  touch "${UPD_NEWZDASH_PATH}/.upgrade.newzdash"
  git stash
  git pull

  rm "${UPD_NEWZDASH_PATH}/.upgrade.newzdash"
fi

echo "#------------------------------------------------------------------------------"
echo "# Updating NewzDash - Complete"
echo "#------------------------------------------------------------------------------"
