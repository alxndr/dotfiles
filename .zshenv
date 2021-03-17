export EDITOR="nvim"
export PAGER="more"
export LESS="-F -R -S -W"

export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"

# export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# these should already be there...

export PATH="$PATH:/Users/alxndr/Library/Python/3.7/bin"

# make sure we can see psql
export PATH="/usr/local/opt/postgresql/bin:$PATH"

# npm
export PATH="/usr/local/share/npm/bin:$PATH"

# export IPFS_PATH=~/.ipfs-2

export RIPGREP_CONFIG_PATH=~/workspace/dotfiles/ripgrep.cfg


#########
# unixy #
#########

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="curl"
alias gr="grep"
alias l="ls -AFl"
alias ll="ls -aFl"
alias ls="ls -F"
      lsd() {
        if [[ -n "$1" ]]; then
          ls -G -d $1/*(D/)
        else
          # h/t Stéphane https://unix.stackexchange.com/a/502028/48320
          ls -G -d -- *(D/)
        fi
      }
alias ln="ln -v"
alias tlf="tail -f"
alias top="top -o cpu -O vsize"
alias tophistory="history | awk '{a[\$2]++}END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n30" # https://coderwall.com/p/o5qijw
      until_fail() {
        eval "$@"
        while [ "$?" -eq "0" ]; do
          eval "$@"
        done
      }
alias uq="cat -n | sort -uk2 | sort -nk1 | cut -f2-" # h/t https://stackoverflow.com/a/20639730/303896
alias wh="which"
alias yr="ncal $(date -j +'%Y')"

#########
# mac-y #
#########

      battery() { ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.0f%%"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}' }
alias fixcamera="sudo killall AppleCameraAssistant && sudo killall VDCAssistant" # h/t @GregMefford
      notify() { osascript -e "display notification \"$2\" with title \"$1\"" }
alias nv="nvim"
      yt() { youtube-dl -f best $1 }


#######
# git #
#######

alias bad="git bisect bad"
alias good="git bisect good"

alias g="git"
alias ga="git add"
alias gA="git add --all"
alias gap="git add --patch"
alias gb="git branch --color"
alias gco="git checkout"
# alias gcompare="git show-branch \$(git rev-parse --abbrev-ref HEAD) origin/\$(git rev-parse --abbrev-ref HEAD)"
alias gcv="git commit --verbose"
alias gd="git diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'."
      gdiff() {
        $FIRST=$1
        $SECOND=$2
        $FILE=$3
        diff <(git show :$FIRST:$FILE) <(git show :$SECOND:$FILE)
      }
alias gdp="git co develop && git pull"
alias gds="gd --staged"
alias gf="git fetch"
alias gh="giturl | xargs open"
      ghb() { open $(giturl)/compare/develop...$(git branch-name) }
alias giturl="git config --get remote.origin.url | sed -e 's/\/\///' -e 's/git.//' -e 's/:/\//' -e 's/\.git//' -e 's/^/http:\/\//'"
alias gl="git l"
alias glg="git lg"
alias glu="git log --patch"
alias gmd="git co develop && git pull && git co - && git merge develop"
alias gp="git pull"
      gri() { git rebase --interactive "HEAD~$1" }
alias gsl="git stash list"
      gsp() {
        git stash pop stash@{${1:-0}}
      }
      gss() {
        git stash show --patch stash@{${1:-0}}
      }
alias s="git status --short"

##########
# docker #
##########

alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"
alias dmenv="eval \"\$(docker-machine env default)\""
      docker-scrub() {
        docker rm $(docker ps -q -f 'status=exited')
        docker rmi $(docker images -f "dangling=true" -q)
        docker volume rm $(docker volume ls -qf dangling=true)
        docker image prune
        docker container prune
        docker volume prune
      }

###########
# general #
###########

alias b="brew"
alias bl="bundle"
      decode_jwt() {
        if [[ -n "$1" ]]; then
          JWT=$1
        else
          read JWT
        fi
        JWT_SPLIT=(${(s:.:)JWT}) # split on periods
        for JWT_PIECE in $JWT_SPLIT; do
          echo
          echo $JWT_PIECE | base64 -D
          echo
        done
      }
      dotenv() {
        # Usage: `dotenv command [args...]`
        # If there's an .env file in the current directory, it will run the
        # given command (with optional args) after adding the name=value
        # options specified in the .env file to the command's environment.
        if [[ ! -r .env ]]; then
          echo "ERROR: No .env file in current directory; exiting..."
          return 1
        fi
        # TODO This breaks if there's a backslash in a value?
        env $(grep -E "^(export )?\w+=" .env | xargs) $@
      }
alias eau="mix test && eautotest"
alias eautotest="ls {lib,web}/**/*.ex test/**/*.exs mix.exs mix.lock config/{config,test}.exs | entr -d mix test"
      extract_urls() {
        [[ -z "$1" ]] && echo "Usage: spider url [depth=5]" && return 1
        lynx \
          -dump \
          -listonly \
          $1 \
        | awk '/^ *[0-9]/ {print $2}'
      }
alias gx="gigalixir"
alias h="hex"
alias ism="iex -S mix"
alias ismp="iex -S mix phx.server"
alias m="mix"
alias meb="mix escript.build"
alias mps="mix phx.server"
alias mt="mix test"
alias n="npm"
alias nd="node"
alias ndd="nodemon"
alias ni="npm install --loglevel warn"
alias niD="npm install --loglevel warn --save-dev"
alias niS="npm install --loglevel warn --save"
      node-watcher() {
        if [[ -z "$1" ]]; then
          echo "need a command to run whenever a webfile changes..."
        else
          webfiles | PWD=$(pwd) entr -rs "echo \"\n\\033[36m➥ \${0##${PWD}/}\\033[00m\n\" && $1"
        fi
      }
alias nr="npm run --silent"
alias nvm="echo \"You probably want fnm, not nvm...\""
alias nx="npx"
      report() { $@ && say "done" || say "error" }
alias sactl="sudo apachectl"
alias start_postgres="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias us="bundle exec unicorn -c tmp/unicorn.rb"
      upyet() {
        URL=$1
        until [[ $(curl -Is $URL | grep "HTTP\S* 200 OK") ]]; do
          echo -n .
          sleep 5
        done
        echo $URL
        date
      }
alias webfiles="rg --type web --files"
      webm2mp3() {
        ffmpeg -i "$1" -vn -f mp3 "${1%.webm}.mp3"
      }
alias y="yarn"


###
# BR stuff
###

gcf() { git checkout "feature/$1" }
gcC() { git checkout "feature/CONS-$1" }
gcN() { git checkout "feature/NR-$1" }
gcP() { git checkout "feature/PT-$1" }
gcS() { git checkout "feature/SOC-$1" }
gcT() { git checkout "feature/CTT-$1" }
gfs() { git checkout develop && git pull && git checkout -b "feature/$1" }

# https://statmilk.atlassian.net/wiki/spaces/ENG/pages/943030296/Getting+AWS+Access+Keys+from+Okta+SSO
export AWS_DEFAULT_REGION=us-east-1
export AWS_PAGER=""
# [[ ! -x $(which saml2aws) ]] && brew tap versent/homebrew-taps && brew install saml2aws

back_up_media() {
  rsync \
    --verbose \
    --itemize-changes \
    --progress \
    --archive \
    --delete \
    --extended-attributes \
    /Volumes/MEDIA/* \
    /Volumes/Media2
}
