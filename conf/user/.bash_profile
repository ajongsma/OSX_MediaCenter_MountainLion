# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases, and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{bashrc,extra,bash_prompt,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# Set terminal to 256 color
export TERM=xterm-256color

# Tell bash to be colourful
export CLICOLOR=1

# Colors for Dark Terminal Themes:
#export LSCOLORS=GxFxCxDxBxegedabagaced

# Colors for Light Terminal Themes:
#export LSCOLORS=ExFxBxDxCxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'
