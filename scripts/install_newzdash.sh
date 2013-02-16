#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing NewzDash"
echo "#------------------------------------------------------------------------------"

source ../config.sh

## https://github.com/tssgery/newzdash

##?? NewzDash
##?? ensure that the php5-svn module is installed, on ubuntu/debian you can install with 'sudo apt-get install php5-svn'.
##?? NewzDash will function without this but you will not see version information.

sudo mkdir -p /Users/Newzdash/Sites/newzdash/

#git clone https://github.com/mrkipling/maraschino.git
#git clone git@github.com:tssgery/newzdash.git /Users/Newzdash/Sites/
sudo git clone https://github.com/tssgery/newzdash.git /Users/Newzdash/Sites/newzdash
sudo chown -R `whoami`:wheel /Users/Newzdash/Sites/newzdash
touch /Users/Newzdash/Sites/newzdash config.php
chmod 777 /Users/Newzdash/Sites/newzdash config.php

sudo ln -s /Users/Newzdash/Sites/newzdash /Library/Server/Web/Data/Sites/Default/newzdash

echo "-----------------------------------------------------------"
echo "| Configuration:"
echo "| NewzNab Directory             : $INST_NEWZNAB_PATH"
echo "| NewzNab URL                   : http://localhost/newznab"
echo "| --------------------"
echo "| Save changes"
open http://localhost/newzdash
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Installing NewzDash - Complete"
echo "#------------------------------------------------------------------------------"