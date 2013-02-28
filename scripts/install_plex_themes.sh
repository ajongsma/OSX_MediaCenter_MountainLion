#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Themes for Plex Media Client "
echo "#------------------------------------------------------------------------------"
## #SKINS_LIST =  "http://anomiesoftware.com/downloads/preenSkinsLaika1.xml"

source ../config.sh

PLEX_SKINS_LIST="http://anomiesoftware.com/downloads/preenSkinsLaika1.xml"
PLEX_SKINS_FOLDER="~/Library/Application\ Support/Plex/addons/"

[ -d ~/Github ] || mkdir -p ~/Github/Plex\ Themes
cd ~/Github/Plex\ Themes

## https://github.com/maverick214/PlexAeon.git
git clone https://github.com/maverick214/PlexAeon.git
cp -r PlexAeon $PLEX_SKINS_FOLDER

## https://github.com/maverick214/Metropolis.git
git clone https://github.com/maverick214/Metropolis.git
cp -r Metropolis $PLEX_SKINS_FOLDER

## https://github.com/gitSebastian/Retroplex.git
git clone https://github.com/gitSebastian/Retroplex.git
cp -r Retroplex $PLEX_SKINS_FOLDER

## https://github.com/jaaps/skin.blur.git
git clone https://github.com/jaaps/skin.blur.git ./Blur
cp -r Blur $PLEX_SKINS_FOLDER

## https://github.com/reddragon220/Quicksilver.git
git clone https://github.com/reddragon220/Quicksilver.git
cp -r Quicksilver $PLEX_SKINS_FOLDER

## https://github.com/kevinlekiller/Newznab-Carbon-Theme.git
git clone https://github.com/kevinlekiller/Newznab-Carbon-Theme.git
cp -r Newznab-Carbon-Theme/Carbon $PLEX_SKINS_FOLDER/Carbon


echo "#------------------------------------------------------------------------------"
echo "# Install Themes for Plex Media Client - Complete"
echo "#------------------------------------------------------------------------------"
