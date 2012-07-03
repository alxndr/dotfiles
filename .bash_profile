alias ll="ls -AFGl"
alias l='ls -AFl'
alias top="top -o cpu -O vsize"

alias rs="rails server"
alias rc="rails console"

alias rT="rake -T"
alias rdm="rake db:migrate"
alias rps="rake parallel:spec"
alias testprep="rake db:test:prepare parallel:prepare"

alias gb="git branch --color"
alias gbc="git branch --no-color | sed -e '/^[^*]/d' -e 's/^* //'"
alias gc="git checkout"
alias gd="git diff --color"
alias gdc="gd --color --cached"
alias gds="gd --color --staged"
alias gl="git log"
alias gp="git pull"
alias gpr="git pull --rebase"
alias gpx="gp && gitx"
alias gq="git push"

alias bindle="bundle install"

alias rspec="rspec -c"

[[ -r "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

