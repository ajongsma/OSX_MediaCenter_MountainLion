#!/bin/bash
# Download and install XQuartz

if [ ! -d /Applications/xsuartz.app ]; then
  #url="$(curl -s http://www.alfredapp.com | grep '.dmg')"
  url="http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.4.dmg"
  zip="${url##http*/}"
  download_dir="/src/xquartz"
  mkdir -p "$download_dir"

  #sudo download_dmg "$(curl -s http://www.alfredapp.com | grep '.dmg')" "${download_dir}/${zip}"

  echo "Downloaded to: ${download_dir}/${zip}"

  curl -L "$url" -o "${download_dir}/${zip}"
  #unzip -q "${download_dir}/${zip}" -d /${download_dir}/
  #sudo mv ${download_dir}/alfred.app /Applications/alfred.app
else
  echo "$(tput setaf 10)XQuartz is already installed.$(tput sgr0)"
fi

#http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.4.dmg
