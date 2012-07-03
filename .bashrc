
if [[ -r "$HOME/.colors" ]]; then
  source "$HOME/.colors"
fi

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function rewrite_PS1 {
  if [[ -n "$(parse_git_branch)" ]]; then
    GITBRANCH="$BYellow$(parse_git_branch)$Color_Off"
  else
    GITBRANCH=""
  fi
  if [[ "$(whoami)" == "aquine" ]]; then
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
export GREP_OPTIONS="-I --exclude=\*.svn\*"

export LSCOLORS='Gxgxfxfxcxdxdxhbadbxbx'

