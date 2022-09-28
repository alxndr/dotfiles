setopt DVORAK
setopt IGNOREEOF


echo -n …vi-mode ''
bindkey -v
export KEYTIMEOUT=10 # cut timeout when switching modes; h/t https://dougblack.io/words/zsh-vi-mode.html
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward


if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  if [[ -x "$(which brew)" ]]; then
    echo -n …brew ''
    UPDATEFILE=/tmp/zshrc-brew-update
    MINUTE=60 # seconds
    HOUR=$((60 * MINUTE))
    DAY=$((24 * HOUR))
    if [[
      (! (-e $UPDATEFILE))
      || ($(($(date -r $UPDATEFILE '+%s') + (2 * $DAY))) -lt $(date '+%s'))
    ]]; then
      echo
      vared -p 'update brew?? Y/n ' -c CONFIRM
      case ${CONFIRM:0:1} in
        [Yy])
          brew update && touch $UPDATEFILE
          ;;
        *);
          echo 'skipping brew update'
          ;;
      esac
    fi
  fi
fi


echo -n …oh-my-zsh ''
export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
ZSH_THEME="alxndr"
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
test -f "$ZSH/oh-my-zsh.sh" && source $ZSH/oh-my-zsh.sh
if [[ -x $(which git) ]]; then
  echo -n …git ''
  plugins=(git)
fi


if [[ -f "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  echo -n …iterm2 ''
  # h/t https://nicksays.co.uk/iterm-tool-versions-status-bar/
  # also https://www.iterm2.com/3.3/documentation-scripting-fundamentals.html
  iterm2_print_user_vars() {
    iterm2_set_user_var versionNode $(node -v)
    iterm2_set_user_var versionElixir $(elixir -v | awk '/Elixir/{print $2}')
  }
  source "${HOME}/.iterm2_shell_integration.zsh"
fi


if [[ -f ~/.fzf.zsh ]]; then
  echo -n …fzf ''
  if [[ -x "$(which rg)" && -x "$(which fzf)" ]]; then
    export FZF_DEFAULT_COMMAND="rg"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
  source ~/.fzf.zsh
fi


test -x "$(which fnm)" && \
  echo -n …fnm '' && \
  eval "$(fnm env)"


test -x "$(which deno)" && \
  echo -n …deno '' && \
  export PATH="$PATH:/Users/xander/.deno/bin"


echo
