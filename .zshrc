# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DISABLE_UPDATE_PROMPT=true
ZSH_THEME="alxndr"

CASE_SENSITIVE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git git-flow-completion mix rails ruby)

source $ZSH/oh-my-zsh.sh

# User configuration

[[ -s "$HOME/.zshenv" ]] && source $HOME/.zshenv

bindkey -v
# restore control-r to search history in vi mode
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# use github's hub as git
if [[ -x "$(which hub)" ]]; then
  eval "$(hub alias -s)"
fi

# enable autoswitching rubies based on .ruby-version
[[ -x "/usr/local/opt/chruby/share/chruby/auto.sh" ]] && source /usr/local/opt/chruby/share/chruby/auto.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

# use rbenv||rvm, exenv if available
if [[ -x $(which rbenv) ]]; then
  eval "$(rbenv init -)"
fi
if [[ -x $(which exenv) ]]; then
  eval "$(exenv init -)"
fi

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1 # https://github.com/neovim/neovim/issues/2017#issuecomment-75242046

for FILE ("$HOME/.alias" "/usr/local/bin/virtualenvwrapper.sh") do
  [[ -r "$FILE" ]] && source "$FILE"
done

[[ -f "$HOME/.br.sh" ]] && source $HOME/.br.sh

export NVM_DIR="/Users/alexanderquine/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
