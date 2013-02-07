#!/bin/bash

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Remove outdated versions from the cellar
brew cleanup

echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
