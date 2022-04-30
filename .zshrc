setopt DVORAK
setopt IGNOREEOF

###
# oh-my-zsh stuff
###

export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.

# DISABLE_UPDATE_PROMPT=true
ZSH_THEME="alxndr"

CASE_SENSITIVE="true"

COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh


###
# regularly-scheduled programming
###

# [[ -s "$HOME/.alias" ]] && source "$HOME/.alias"
# ...moving all of that shit right into zshenv so that subshells can get it...

# Vi mode...
bindkey -v
export KEYTIMEOUT=10 # cut timeout when switching modes; h/t https://dougblack.io/words/zsh-vi-mode.html
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# tweaks for fzf / ripgrep
if [[ -x "$(which rg)" && -x "$(which fzf)" ]]; then
  export FZF_DEFAULT_COMMAND="rg"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# javascript... Schniz/fnm
test -x "$(which fnm)" && eval "$(fnm env)"

# javascript... yarn
# export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"

# python... virtualenv (?)
# [[ -r "/usr/local/bin/virtualenvwrapper.sh" ]] && source "/usr/local/bin/virtualenvwrapper.sh"

# h/t https://nicksays.co.uk/iterm-tool-versions-status-bar/
# also https://www.iterm2.com/3.3/documentation-scripting-fundamentals.html
iterm2_print_user_vars() {
  iterm2_set_user_var versionNode $(node -v)
  iterm2_set_user_var versionElixir $(elixir -v | awk '/Elixir/{print $2}')
}
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# do some stuff on `cd`
# https://stackoverflow.com/a/45444758/303896
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd () {
  test -f "./.node-version" -o -f "./.nvmrc" -a -x "$(which fnm)" && \
    echo "... setting up fnm ..." && \
    eval "$(fnm env)" && \
    f;
}
