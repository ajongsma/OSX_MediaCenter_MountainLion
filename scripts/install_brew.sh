#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing HomeBrew"
echo "#------------------------------------------------------------------------------"

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
if [ ! -e /usr/local/bin/brew ] ; then
    printf 'HomeBrew failed installing\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
else
    printf 'HomeBrew found\n' "$GREEN" $col '[OK]' "$RESET"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew doctor

# Remove outdated versions from the cellar
brew cleanup

echo "#------------------------------------------------------------------------------"
echo "# Install HomeBrew - Complete"
echo "#------------------------------------------------------------------------------"
