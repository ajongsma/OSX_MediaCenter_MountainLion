#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd for Headphones"
echo "#------------------------------------------------------------------------------"

source ../config.sh

echo "-----------------------------------------------------------"
echo "| Menu, Config, Categories:"
echo "| music, Default, Default, Default, Music/"
echo "-----------------------------------------------------------"
open http://localhost:8080/config/categories/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd for Headphones - Complete"
echo "#------------------------------------------------------------------------------"
