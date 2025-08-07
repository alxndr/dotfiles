setopt DVORAK
setopt IGNOREEOF

# n.b. this does not account for leap seconds/days...
MIN=60
((HOUR = 60 * $MIN))
((DAY = 24 * $HOUR))


echo -n 'vi-mode… '
bindkey -v
export KEYTIMEOUT=10 # cut timeout when switching modes; h/t https://dougblack.io/words/zsh-vi-mode.html
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
echo


if [[ -x "/opt/homebrew/bin/brew" ]]; then
  echo -n 'homebrew… '
  eval "$(/opt/homebrew/bin/brew shellenv)"
  updated=$(date -r /opt/homebrew/.git/HEAD +%s)
  if [[ $((($(date +%s) - updated))) -gt $((13 * $DAY)) ]]; then # https://stackoverflow.com/a/19464264/303896
    echo -e "\nupdate now? (last update $(date -r /opt/homebrew/.git/HEAD))"
    vared -p "… [y/N] " -c CONFIRM
    case ${CONFIRM:0:1} in
      [Yy])
        brew update
        ;;
      *);
        echo 'skipping brew update'
        ;;
    esac
  fi
  echo
fi


if [[ -x "$(which asdf)" ]]; then
  echo -n 'asdf… '
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  # completions...
  mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
  asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
  echo
fi


export ZSH=$HOME/.oh-my-zsh
if [[ -d "$ZSH" ]]; then
  echo -n 'oh-my-zsh… '
  ZSH_THEME="alxndr"
  CASE_SENSITIVE="true"
  COMPLETION_WAITING_DOTS="true"
  plugins=(asdf dotenv vi-mode)
  test -f "$ZSH/oh-my-zsh.sh" && source "$ZSH/oh-my-zsh.sh"
  echo
fi



# if [[ -f "${HOME}/.iterm2_shell_integration.zsh" ]]; then
#   echo -n 'iterm2… '
#   # h/t https://nicksays.co.uk/iterm-tool-versions-status-bar/
#   # also https://www.iterm2.com/3.3/documentation-scripting-fundamentals.html
#   iterm2_print_user_vars() {
#     iterm2_set_user_var versionNode $(node -v)
#     iterm2_set_user_var versionElixir $(elixir -v | awk '/Elixir/{print $2}')
#   }
#   source "${HOME}/.iterm2_shell_integration.zsh"
#   echo
# fi


if [[ -x $(which fzf) ]]; then
  echo -n 'fzf… '
  plugins+=(fzf)
  if [[ -x "$(which rg)" ]]; then
    export FZF_DEFAULT_COMMAND="rg"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    plugins+=(ripgrep)
  fi
  test -f ~/.fzf.zsh && source ~/.fzf.zsh
  echo
fi


if [[ -x "$(which deno)" ]]; then
  echo -n 'deno… '
  export PATH="$PATH:/Users/xander/.deno/bin"
  echo
fi


# [ -f "/Users/xander/.ghcup/env" ] && source "/Users/xander/.ghcup/env" # ghcup-env
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# if [[ -x "$(which opam)" ]]; then
#   eval $(opam env)
# fi


if [[ -f "$HOME/.cargo/env" ]]; then
  echo -n 'rust… '
  source "$HOME/.cargo/env"
  echo
fi


if [[ -d "$HOME/.bun" ]]; then
  echo -n 'bun… '
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  [ -s "/Users/xander/.bun/_bun" ] && source "/Users/xander/.bun/_bun" # bun completions
  echo
fi


echo "\n" && uptime


# Apollo GraphQL Rover stuff
export APOLLO_TELEMETRY_DISABLED=1
