#!/usr/bin/env bash

BOLD=$(tput bold)
BLACK=$(tput setaf 0) #   0  Black
RED=$(tput setaf 1)  #  1   Red
GREEN=$(tput setaf 2)  #    2   Green
YELLOW=$(tput setaf 3)  #   3   Yellow
BLUE=$(tput setaf 4)  #     4   Blue
MAGENTA=$(tput setaf 5)  #  5   Magenta
CYAN=$(tput setaf 6)  #     6   Cyan
WHITE=$(tput setaf 7)  #    7   White
RESET=$(tput sgr0)
col=40

## Download and install Alfred
if [ ! -e /Applications/alfred.app ] ; then
  #echo "Alfred not installed, please install..."
  printf 'Alfred not installed, please install..' "$RED" $col '[FAIL]' "$RESET"

  url="http://cachefly.alfredapp.com/alfred_1.3.2_265.zip"
  zip="${url##http*/}"
  download_dir="/src/alfred"
  mkdir -p "$download_dir"
  curl -L "$url" -o "${download_dir}/${zip}"

  printf 'Downloaded to ${download_dir}/${zip}, installing...' "YELLOW" $col '[WAIT]' "$RESET"
  unzip -q "${download_dir}/${zip}" -d /${download_dir}/
  sudo mv ${download_dir}/alfred.app /Applications/alfred.app

  if [ ! -e /Applications/alfred.app ] ; then
    else
    printf 'Alfred installed' "$GREEN" $col '[OK]' "$RESET"
  fi
else
  #echo "Alfred found                               [OK]"
  printf 'Alfred found' "$GREEN" $col '[OK]' "$RESET"
fi
