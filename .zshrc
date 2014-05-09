# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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
plugins=(git rails ruby)

source $ZSH/oh-my-zsh.sh

# User configuration

bindkey -v

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

# make sure we can see psql
export PATH="/usr/local/opt/postgresql/bin:$PATH"

# use github's hub as git
if [[ -x "$(which hub)" ]]; then
  eval "$(hub alias -s)"
fi

# use rbenv or rvm
if [[ -x $(which rbenv) ]]; then
  eval "$(rbenv init -)"
else
  source $HOME/.rvm/scripts/rvm
fi

export EDITOR="vim"
export VISUAL="vim"

export PAGER="less"
export LESS="-FRSX"

export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"

for FILE ("$HOME/.alias" "/usr/local/bin/virtualenvwrapper.sh") do
  [[ -r "$FILE" ]] && source "$FILE"
done

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
