export EDITOR="nvim"
export PAGER="more"
export LESS="-F -R -S -W"

export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# make sure we can see psql
export PATH="/usr/local/opt/postgresql/bin:$PATH"

# npm
export PATH="/usr/local/share/npm/bin:$PATH"

export IPFS_PATH=~/.ipfs-2

export RIPGREP_CONFIG_PATH=~/workspace/dotfiles/ripgrep.cfg
