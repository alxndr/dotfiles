
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

. /etc/colors.sh
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
export GREP_OPTIONS="--exclude=\*.svn\*"

export LSCOLORS='Gxgxfxfxcxdxdxhbadbxbx'

export PATH="/opt/mongodb/bin:$PATH"
export PATH="$PATH:/usr/local/mysql/bin"
export PATH="$PATH:/Users/aquine/.gem/ruby/1.8/bin"


export AMAZON_ACCESS_KEY_ID="AKIAILYS5JTIET4FL3OA"
export AMAZON_SECRET_ACCESS_KEY="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"
export AMAZON_BUCKET="currenttv_dev"
#export AMAZON_BUCKET="currenttv_local"
#export AMAZON_BUCKET="currenttv_staging"
#export AMAZON_BUCKET="currenttv" # PRODUCTION


if [[ "$(ps aux | grep dude | wc -l)" -le 1 ]]; then
  cd ~/.git-dude && (git-dude >/dev/null &1>2 &) && cd -
fi

