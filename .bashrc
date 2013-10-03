[[ -r "$HOME/.colors" ]] && source "$HOME/.colors"

export EDITOR="/usr/bin/vim"
export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"
export PATH="/usr/local/bin:$PATH:/Users/alxndr/.gem/ruby/1.8/bin"

export LSCOLORS='Gxgxfxfxcxdxdxhbadbxbx'

gdc() { # git diff of commit
  if [[ -z "$1" ]]; then
    echo 'Pass a git commit hash as a parameter to see the diff for that commit.'
    return
  fi
  git diff $1^1 $1
}

set -o vi
bind -m vi-insert 'Control-l: clear-screen'
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# put git branch into prompt if we're in a repo
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
rewrite_PS1
export PROMPT_COMMAND="rewrite_PS1"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

