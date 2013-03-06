for FILE in "$HOME/.bashrc" "$HOME/.alias" "$HOME/.rvm/scripts/rvm" "$rvm_path/scripts/completion" "/usr/local/bin/virtualenvwrapper.sh"
do
  [[ -r "$FILE" ]]
done

