export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.

DISABLE_UPDATE_PROMPT=true
ZSH_THEME="alxndr"

CASE_SENSITIVE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git mix)

source $ZSH/oh-my-zsh.sh

[[ -s "$HOME/.zshenv" ]] && source $HOME/.zshenv

bindkey -v
# restore control-r to search history in vi mode
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# use github's hub as git
if [[ -x "$(which hub)" ]]; then
  eval "$(hub alias -s)"
fi

# javascript... Schniz/fnm
if [[ -x $(which fnm) ]]; then
  eval $(fnm env --multi)
fi

# javascript... yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# ruby... rbenv, rvm
if [[ -x $(which rbenv) ]]; then
  eval "$(rbenv init -)"
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

# elixir... exenv
if [[ -x $(which exenv) ]]; then
  eval "$(exenv init -)"
  export PATH="$HOME/.exenv/bin:$PATH"
fi

# python... virtualenv (?)
for FILE ("$HOME/.alias" "/usr/local/bin/virtualenvwrapper.sh") do
  [[ -r "$FILE" ]] && source "$FILE"
done

[[ -f "$HOME/.br.sh" ]] && source $HOME/.br.sh

if [[ -x $(which ncal) ]]; then
  ncal
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
