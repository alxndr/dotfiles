for FILE in "$HOME/.bashrc" "$HOME/.alias" "$HOME/.rvm/scripts/rvm" "$rvm_path/scripts/completion"
do
  [[ -r "$FILE" ]] && echo source "$FILE" && source "$FILE"
done

