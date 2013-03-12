# PATH additions
for another_bin in \
    $(brew --prefix coreutils)/libexec/gnubin \
    $HOME/bin \
    $(brew --prefix josegonzalez/php/php54)/bin \
    $HOME/.rbenv/bin
do
    [[ -e $another_bin ]] && export PATH=$another_bin:$PATH
done
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

hash rbenv &>/dev/null
if [ $? -eq 0 ]; then
	eval "$(rbenv init -)"
	rbenv global 1.9.3-p194
fi