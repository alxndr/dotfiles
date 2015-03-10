# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DISABLE_UPDATE_PROMPT=true
ZSH_THEME="alxndr"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

CASE_SENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mix rails ruby)

source $ZSH/oh-my-zsh.sh

# User configuration

# enable autoswitching rubies based on .ruby-version
[[ -x "/usr/local/opt/chruby/share/chruby/auto.sh" ]] && source /usr/local/opt/chruby/share/chruby/auto.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

bindkey -v
# restore control-r to search history in vi mode
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# make sure we can see psql
export PATH="/usr/local/opt/postgresql/bin:$PATH"

# npm
export PATH="/usr/local/share/npm/bin:$PATH"

# use github's hub as git
if [[ -x "$(which hub)" ]]; then
  eval "$(hub alias -s)"
fi

# use rbenv or rvm
if [[ -x $(which rbenv) ]]; then
  eval "$(rbenv init -)"
fi
#if [[ -x $(which rvm) ]]; then
  #source $HOME/.rvm/scripts/rvm
#fi

export EDITOR="nvim"
export VISUAL="nvim"

export PAGER="most"
export LESS="-FRSX"

export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"

for FILE ("$HOME/.alias" "/usr/local/bin/virtualenvwrapper.sh") do
  [[ -r "$FILE" ]] && source "$FILE"
done

[[ -f "$HOME/.br.sh" ]] && source $HOME/.br.sh

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"
