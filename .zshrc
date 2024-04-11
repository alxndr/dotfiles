setopt DVORAK
setopt IGNOREEOF

MINUTE=60 # seconds
HOUR=$((60 * MINUTE))
DAY=$((24 * HOUR))

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
plugins=(asdf dotenv vi-mode)
test -f "$ZSH/oh-my-zsh.sh" && source "$ZSH/oh-my-zsh.sh"


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


if [[ -x $(which fzf) ]]; then
  echo -n …fzf ''
  plugins+=(fzf)
  if [[ -x "$(which rg)" ]]; then
    export FZF_DEFAULT_COMMAND="rg"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    plugins+=(ripgrep)
  fi
  test -f ~/.fzf.zsh && source ~/.fzf.zsh
fi


test -x "$(which deno)" && \
  echo -n …deno '' && \
  export PATH="$PATH:/Users/xander/.deno/bin"


[ -f "/Users/xander/.ghcup/env" ] && source "/Users/xander/.ghcup/env" # ghcup-env
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [[ -x "$(which opam)" ]]; then
  eval $(opam env)
fi


echo
echo
date

# bun completions
[ -s "/Users/xander/.bun/_bun" ] && source "/Users/xander/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
