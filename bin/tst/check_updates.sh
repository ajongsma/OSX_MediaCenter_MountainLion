#!/usr/bin/env bash

## Make sure only root can run our script
#if [[ $EUID -ne 0 ]]; then
#   echo "This script must be run as root" 1>&2
#   exit 1
#fi

source ../defaults.sh

echo "-----------------------------------------------------------"
echo "| Checking for updates on GIT"
echo "-----------------------------------------------------------"
cd ~/Github/

echo "#------------------------------------------------------------------------------"
echo "# Checking SABnzbd - nzbToMedia"
echo "#------------------------------------------------------------------------------"

#nothing to commit (working directory clean)

cd ~/Github/nzbToMedia
git_status=`git status | tail -n +2`

git pull
cp -R ~/Github/nzbToMedia/* ~/Library/Application\ Support/SABnzbd/scripts/

## https://github.com/jonnyboy/newznab-tmux.git

## https://github.com/jonnyboy/Newznab-Simple-Theme.git
# $INST_NEWZNAB_PATH/www/templates/simple

## https://github.com/sinfuljosh/bootstrapped.git
# $INST_NEWZNAB_PATH/www/templates/bootstrapped

## https://github.com/spotweb/spotweb.git

#git pul

echo "-----------------------------------------------------------"
echo "| Checking for updates on SVN"
echo "-----------------------------------------------------------"
echo "| Checking for updates NewzNAB:"
#cd /Users/Newznab/Sites/newsnab
#svn info
#svn update
svn info svn://svn.newznab.com/nn/branches/nnplus $INST_NEWZNAB_PATH/

echo "-----------------------------------------------------------"
echo "| Checking for updates on HG"
echo "-----------------------------------------------------------"
echo "| Checking for updates Auto-Sub:"

hg status /Applications/auto-sub
#hg update /Applications/auto-sub

