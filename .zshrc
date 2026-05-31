echo -n '… '
setopt DVORAK
setopt IGNOREEOF

# n.b. this does not account for leap seconds/days...
MIN=60
((HOUR = 60 * $MIN))
((DAY = 24 * $HOUR))


bindkey -v
export KEYTIMEOUT=10 # cut timeout when switching modes; h/t https://dougblack.io/words/zsh-vi-mode.html
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward


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
        echo '\n…skipping brew update'
        ;;
    esac
  fi
fi


if [[ -x "$(which asdf)" ]]; then
  echo -n 'asdf… '
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  # completions...
  mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
  asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
fi


if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo -n 'omz… '
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME="alxndr"
  CASE_SENSITIVE="true"
  COMPLETION_WAITING_DOTS="true"
  plugins=(asdf dotenv vi-mode)
  test -f "$ZSH/oh-my-zsh.sh" && source "$ZSH/oh-my-zsh.sh"
fi


if [[ -x $(which fzf) ]]; then
  echo -n 'fzf… '
  if [[ -x "$(which rg)" ]]; then
    export FZF_DEFAULT_COMMAND="rg"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
  test -f ~/.fzf.zsh && source ~/.fzf.zsh
fi


if [[ -f "$HOME/.cargo/env" ]]; then
  echo -n 'rust… '
  source "$HOME/.cargo/env"
fi


if [[ -d "$HOME/.bun" ]]; then
  echo -n 'bun… '
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun" # bun completions
fi


echo
uptime
