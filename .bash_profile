[[ -r "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
[[ -r "$HOME/.alias" ]] && source "$HOME/.alias"

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

