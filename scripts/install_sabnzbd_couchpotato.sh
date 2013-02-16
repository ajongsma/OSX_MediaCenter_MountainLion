#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd for CouchPotato"
echo "#------------------------------------------------------------------------------"

source ../config.sh

echo "-----------------------------------------------------------"
echo "| Menu, Config, Categories:"
echo "| movies, Default, Default, nzbToCouchpotato.py"
echo "|----------"
echo "| Save"
echo "-----------------------------------------------------------"
open http://localhost:8080/config/categories/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd for CouchPotato - Complete"
echo "#------------------------------------------------------------------------------"
