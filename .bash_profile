for FILE in "$HOME/.bashrc" \
  "$HOME/.alias" \
  "$HOME/.rvm/scripts/rvm" \
  "$HOME/.git-completion.bash" \
  "$rvm_path/scripts/completion" \
  "/usr/local/bin/virtualenvwrapper.sh" \
  "$HOME/.br.sh"
do
  [[ -r "$FILE" ]] && source "$FILE"
done

