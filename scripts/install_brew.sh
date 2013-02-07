#!/bin/bash

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

#brew install bash-completion git
## Install GNU core utilities (those that come with OS X are outdated)
#brew install coreutils

## Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
#brew install findutils
## Install Bash 4
#brew install bash

# Remove outdated versions from the cellar
brew cleanup

echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
