#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Apache Frontpage"
echo "#------------------------------------------------------------------------------"
## /Library/Server/Web/Data/Sites/Default/index.html

source ../config.sh

sudo cp -v $DIR/www/* $INST_APACHE_SYSTEM_WEB_ROOT/

echo "#------------------------------------------------------------------------------"
echo "# Install Apache Frontpage complete."
echo "#------------------------------------------------------------------------------"
