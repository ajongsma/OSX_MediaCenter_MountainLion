# PATH additions
for another_bin in \
    $(brew --prefix coreutils)/libexec/gnubin \
    $HOME/bin \
    $(brew --prefix josegonzalez/php/php54)/bin
do
    [[ -e $another_bin ]] && export PATH=$another_bin:$PATH
done
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#### powerline-shell
##function _update_ps1() {
##   export PS1="$(/usr/local/share/powerline-shell/powerline-shell.py $?)"
##}
##
##export PROMPT_COMMAND="_update_ps1"
