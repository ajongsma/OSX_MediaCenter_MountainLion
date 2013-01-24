#!/bin/bash

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew install bash-completion git

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash

# Remove outdated versions from the cellar
brew cleanup

# Install iTerm
#url="https://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip"
#zip="${url##http*/}"
#download_dir="/tmp/iterm2-$$"
#mkdir -p "$download_dir"
#curl -L "$url" -o "${download_dir}/${zip}"
#unzip -q "${download_dir}/${zip}" -d /Applications/
#rm -rf "$download_dir"
#
#cd
#git clone git://github.com/sstephenson/rbenv.git .rbenv
#mkdir -p ~/.rbenv/plugins
#cd ~/.rbenv/plugins
#git clone git://github.com/sstephenson/ruby-build.git
#export PATH="$HOME/.rbenv/bin:$PATH"
#rbenv rehash
#rbenv install 1.9.3-p194
#rbenv rehash
#rbenv global 1.9.3-p194
