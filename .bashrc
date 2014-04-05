[[ -r "$HOME/.colors" ]] && source "$HOME/.colors"

export EDITOR="vim"
export VISUAL="vim"
export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"
export PATH="/usr/local/bin:$PATH:/Users/alxndr/.gem/ruby/1.8/bin:/usr/local/share/npm/bin"

export LSCOLORS='Gxgxfxfxcxdxdxhbadbxbx'

set -o vi
bind -m vi-insert 'Control-l: clear-screen'
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

rewrite_PS1() {
  GITBRANCH="$([[ -e .git ]] && git rev-parse --abbrev-ref HEAD)"
  if [[ -n "$GITBRANCH" ]]; then
    GITBRANCH="branch:$BYellow$GITBRANCH$Color_Off"
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
rewrite_PS1
export PROMPT_COMMAND="rewrite_PS1"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

