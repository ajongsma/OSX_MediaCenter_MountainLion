# PATH additions
for another_bin in \
    /usr/X11/bin
    $(brew --prefix coreutils)/libexec/gnubin \
    $HOME/bin \
    $(brew --prefix josegonzalez/php/php54)/bin \
    $HOME/.rbenv/bin
do
    [[ -e $another_bin ]] && export PATH=$another_bin:$PATH
done
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
