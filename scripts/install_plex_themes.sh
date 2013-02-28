#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Themes for Plex Media Client "
echo "#------------------------------------------------------------------------------"
## #SKINS_LIST =  "http://anomiesoftware.com/downloads/preenSkinsLaika1.xml"

source ../config.sh

#PLEX_SKINS_LIST="http://anomiesoftware.com/downloads/preenSkinsLaika1.xml"
PLEX_SKINS_FOLDER="~/Library/Application\ Support/Plex/addons/"

[ -d ~/Github ] || mkdir -p ~/Github/Plex_Themes
cd ~/Github/Plex_Themes

## https://github.com/maverick214/PlexAeon.git
git clone https://github.com/maverick214/PlexAeon.git
cp -r PlexAeon ~/Library/Application\ Support/Plex/addons/
#cp -r PlexAeon $PLEX_SKINS_FOLDER

## https://github.com/maverick214/Metropolis.git
git clone --progress https://github.com/maverick214/Metropolis.git
#cp -r Metropolis $PLEX_SKINS_FOLDER
cp -r Metropolis ~/Library/Application\ Support/Plex/addons/

## https://github.com/gitSebastian/Retroplex.git
git clone --progress https://github.com/gitSebastian/Retroplex.git
#cp -r Retroplex $PLEX_SKINS_FOLDER
cp -r Retroplex ~/Library/Application\ Support/Plex/addons/

## https://github.com/jaaps/skin.blur.git
git clone --progress https://github.com/jaaps/skin.blur.git 
#cp -r skin.blur $PLEX_SKINS_FOLDER/Blur
cp -r skin.blur ~/Library/Application\ Support/Plex/addons/Blur

## https://github.com/reddragon220/Quicksilver.git
git clone --progress https://github.com/reddragon220/Quicksilver.git
#cp -r Quicksilver $PLEX_SKINS_FOLDER
cp -r Quicksilver ~/Library/Application\ Support/Plex/addons/

## https://github.com/kevinlekiller/Newznab-Carbon-Theme.git
git clone --progress https://github.com/kevinlekiller/Newznab-Carbon-Theme.git
#cp -r Newznab-Carbon-Theme/Carbon $PLEX_SKINS_FOLDER/Carbon
cp -r Newznab-Carbon-Theme/Carbon ~/Library/Application\ Support/Plex/addons/

echo "#------------------------------------------------------------------------------"
echo "# Install Themes for Plex Media Client - Complete"
echo "#------------------------------------------------------------------------------"
