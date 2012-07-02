# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

export PS1="\u@eleven-twelve \w$ "
export EDITOR="/usr/bin/emacs"

alias e='emacs'
