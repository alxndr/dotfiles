[[ -r "$HOME/.colors" ]] && source "$HOME/.colors"

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

rewrite_PS1() {
  GITBRANCH="$(parse_git_branch)"
  if [[ -n "$GITBRANCH" ]]; then
    GITBRANCH="$BYellow$GITBRANCH$Color_Off"
  fi
  WHOAMI="$(whoami)"
  if [[ "${WHOAMI:(-5)}" == "quine" || "$WHOAMI" == "alxndr" ]]; then
    USER=""
  else
    USER="\u "
  fi
  export PS1="
\[\D{%T}\] $GITBRANCH
$USER\w $ "
}
export PROMPT_COMMAND="rewrite_PS1"

export EDITOR="/usr/bin/vim"
export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"
export PATH="/usr/local/bin:$PATH:/Users/alxndr/.gem/ruby/1.8/bin"

export LSCOLORS='Gxgxfxfxcxdxdxhbadbxbx'

set -o vi
bind -m vi-insert 'Control-l: clear-screen'


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
