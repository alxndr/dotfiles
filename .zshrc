PS1="
%*
%B%~%b $ "

for FILE in \
  "$HOME/.rvm/scripts/rvm" \
  "$rvm_path/scripts/completion" \
  "$HOME/.colors" \
  "$HOME/.alias" \
  "$HOME/.git_prompt.zsh" # RPROMPT
do
  [[ -r "$FILE" ]] && source "$FILE"
done

bindkey -v

autoload -U promptinit && promptinit
autoload -U colors && colors

setopt prompt_subst

autoload -U compinit
compinit
setopt completeinword # Tab completion from both ends

#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Tab completion should be case-insensitive

# One history for all open shells; store 10,000 entires
# Alt-P: find command that starts like this
# ^R: search in history
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory
setopt sharehistory
setopt extendedhistory
setopt HIST_IGNORE_ALL_DUPS

REPORTTIME=5

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

