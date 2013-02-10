#!/bin/bash
# Download and install iTerm2

# Include a number of methods that are used throughout the installations

if [ ! -d /Applications/iTerm.app ]; then
  url="https://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip"
  zip="${url##http*/}"
  download_dir="/src/iterm2"
  mkdir -p "$download_dir"

  curl -L "$url" -o "${download_dir}/${zip}"
  
  echo "Downloaded to: ${download_dir}/${zip}"
  unzip -q "${download_dir}/${zip}" -d /${download_dir}/
  sudo mv ${download_dir}/iTerm.app /Applications/iTerm.app
else
  echo "$(tput setaf 10)iTerm2 is already installed.$(tput sgr0)"
fi
