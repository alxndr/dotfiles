PS1="
%*
%B%~%b $ "

autoload -U promptinit && promptinit
autoload -U colors && colors

setopt prompt_subst

for FILE in \
  "$HOME/.rvm/scripts/rvm" \
  "$rvm_path/scripts/completion" \
  "$HOME/.colors" \
  "$HOME/.alias" \
  "$HOME/.git_prompt.zsh" # RPROMPT
do
  [[ -r "$FILE" ]] && source "$FILE"
done

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

