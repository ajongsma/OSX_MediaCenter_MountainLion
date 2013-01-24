#!/bin/bash
# Download and install Alfred

if [ ! -d /Applications/alfred.app ]; then
  #url="$(curl -s http://www.alfredapp.com | grep '.dmg')"
  url="http://cachefly.alfredapp.com/alfred_1.3.2_265.zip"
  zip="${url##http*/}"
  download_dir="/src/alfred"
  mkdir -p "$download_dir"

  #sudo download_dmg "$(curl -s http://www.alfredapp.com | grep '.dmg')" "${download_dir}/${zip}"

  echo "Downloaded to: ${download_dir}/${zip}"

  curl -L "$url" -o "${download_dir}/${zip}"
  unzip -q "${download_dir}/${zip}" -d /${download_dir}/
  sudo mv ${download_dir}/alfred.app /Applications/alfred.app
else
  echo "$(tput setaf 10)Alfred is already installed.$(tput sgr0)"
fi
