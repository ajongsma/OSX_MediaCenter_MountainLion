#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Subliminal"
echo "#------------------------------------------------------------------------------"
### https://github.com/Diaoul/subliminal
### https://github.com/Diaoul/subliminal.git
### subliminal -l en The.Big.Bang.Theory.S05E18.HDTV.x264-LOL.mp4

source ~/.bashrc

## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
##
## To check out, might concider later on  ##
##
## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

exit

sudo easy_install pip
sudo easy_install beautifulsoup4
sudo easy_install requests
sudo easy_install enzyme
sudo easy_install html5lib
#ERR: sudo easy_install lxml

svn checkout https://github.com/Diaoul/subliminal.git/branches/master ~/Github/subliminal
cd ~/Github/subliminal
sudo python setup.py install

Installing subliminal script to /usr/local/bin


echo "-----------------------------------------------------------"
echo "| Comment out:"
echo "| Subtitulos                    : #from Subtitulos import Subtitulos"
echo "| SubsWiki                      : #from SubsWiki import SubsWiki"
echo "-----------------------------------------------------------"
subl /usr/local/share/periscope/periscope/plugins/__init__.py
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

exit

#cd /usr/local/share/periscope
sudo ln -s /usr/local/share/periscope/periscope.py /usr/local/bin/periscope.py
periscope </path/to/my/video>  -l nl

echo "#------------------------------------------------------------------------------"
echo "# Installing Subliminal - Complete"
echo "#------------------------------------------------------------------------------"