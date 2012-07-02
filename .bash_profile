alias ll="ls -AFGl"
alias l='ls -AFl'
alias top="top -o cpu -O vsize"

alias rs="rails server"
alias rc="rails console"
alias rT="rake -T"
alias rdm="rake db:migrate"
alias gs="git status"
alias gl="git log"
alias gd="git diff --color"
alias gdc="git diff --color --cached"
alias gd.="gd ."
alias gdc.="gdc ."
alias gb="git branch --color"
alias gbc="git branch --no-color | sed -e '/^[^*]/d' -e 's/^* //'"
alias gc="git checkout"
alias gp="git pull && echo 'rake db:migrate...' && rdm"
alias gpr="git pull --rebase"
alias gpx="gp && gitx"
alias gq="git push"
alias bindle="bundle install"
alias rspec="rspec -c"

if [[ -r ".bashrc" ]]; then . ~/.bashrc; fi

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

