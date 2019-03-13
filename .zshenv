export EDITOR="nvim -u ~/workspace/dotfiles/init.vim"
export PAGER="more"
export LESS="-F -R -S -W"

export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# make sure we can see psql
export PATH="/usr/local/opt/postgresql/bin:$PATH"

# npm
export PATH="/usr/local/share/npm/bin:$PATH"

# exenv
export PATH="$HOME/.exenv/bin:$PATH"

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

if [[ -x $(which exenv) ]]; then
  eval "$(exenv init -)"
fi
