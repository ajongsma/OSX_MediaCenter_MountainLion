#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Periscope"
echo "#------------------------------------------------------------------------------"
### http://code.google.com/p/periscope/
##  periscope </path/to/my/video>  -l nl

### To Check Out ???
##  Run the following command to ensure you have all the dependencies installed:
##  sudo apt-get install python-nautilus python-notify
##  Now create a folder python-extensions in /home/yourusername/.nautilus
##  Run the following commands to install the extension:
##    cd ~/.nautilus/python-extensions
##    wget http://periscope.googlecode.com/svn/trunk/bin/periscope-nautilus/periscope-nautilus.py
##
##  Restart nautilus by running the following command:
##    nautilus -q

source ~/.bashrc

sudo pip install beautifulsoup
sudo pip install beautifulsoup4

sudo pip install periscope
#sudo svn checkout https://github.com/patrickdessalle/periscope/trunk/ /usr/local/share/periscope

mkdir ~/.config



echo "#------------------------------------------------------------------------------"
echo "# To check for available subtitles via Periscope type:"
echo "#   periscope ~/Media/Movies/* -l nl"
echo ""
echo "# Installing Periscope - Complete"
echo "#------------------------------------------------------------------------------"