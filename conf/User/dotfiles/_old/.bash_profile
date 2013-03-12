# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases, and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

if [ -f ~/.ssh/id_rsa ]; then
    ssh-add ~/.ssh/id_rsa
fi