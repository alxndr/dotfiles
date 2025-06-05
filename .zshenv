export EDITOR="nvim"
export PAGER="nvim"
export MANPAGER="nvim +Man!"
export LESS="-F -R -S -W"

export GREP_OPTIONS="-I --exclude=\*.svn\* --exclude=\*.min.\*js"

export RIPGREP_CONFIG_PATH=~/workspace/dotfiles/ripgrep.cfg


#########
# unixy #
#########

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="curl"
      digbr() {
        dig ${1?:specify a subdomain to look up}.bleacherreport.com
      }
alias e="nvim"
alias gr="grep"
alias l="ls -AFlno" # OMZ? is overriding this...
alias la="ls -A"
alias ll="ls -AFl" # OMZ? is overriding this...
alias ln="ln -v"
      lsd() {
        if [[ -n "$1" ]]; then
          ls -G -d $1/*(D/)
        else
          # h/t Stéphane https://unix.stackexchange.com/a/502028/48320
          ls -G -d -- *(D/)
        fi
      }
alias tlf="tail -f"
alias top="top -o cpu -O vsize"
alias tophistory="history | awk '{a[\$2]++}END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n30" # https://coderwall.com/p/o5qijw
      until_fail() {
        tries=1
        eval "$@"
        while [ "$?" -eq "0" ]; do
          ((tries+=1))
          sleep 1
          eval "$@"
        done
        echo "tries: ${tries}"
      }
      until_success() {
        tries=1
        eval "$@"
        while [ "$?" -ne "0" ]; do
          sleep 1
          ((tries+=1))
          eval "$@"
        done
        echo "tries: ${tries}"
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
      yt() { youtube-dl --format best $1 }
      yt-mp3() { youtube-dl --extract-audio --audio-format mp3 $1 }



#######
# git #
#######

alias bad="git bisect bad"
alias good="git bisect good"
      sha-filepath() {
        # given a filepath, print the filename appending the most recent SHA to edit the file
        FILEPATH=${1?:specify a file}
        SHA=$(git log -1 --format=%h $FILEPATH)
        FILENAME=$(basename $FILEPATH)
        FILE_WITHOUT_EXTENSION=${FILENAME%.*}
        FILE_EXTENSION=${FILENAME##*.}
        echo "${FILE_WITHOUT_EXTENSION}.${SHA}.${FILE_EXTENSION}"
      }

alias g="git"
alias ga="git add"
alias gA="git add --all"
alias gap="git add --patch"
alias gb="git branch --color"
alias gco="git checkout"
alias gcv="git commit --verbose"
alias gd="git diff --patch --ignore-all-space --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'."
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
alias glh="git l --since yesterday"
alias glu="git log --patch"
alias gmd="git co develop && git pull && git co - && git merge develop"
alias gp="git pull"
      gri() { git rebase --interactive "HEAD~$1" --verbose }
alias gs="git show" # ...not stash...
alias gsl="git stash list"
      gsp() { git stash pop stash@{${1:-0}} }
      gss() { git stash show --patch stash@{${1:-0}} }
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

alias a="asdf"
alias b="brew"
alias bl="bundle"
alias bx="bundle exec"
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
      extract_urls() {
        [[ -z "$1" ]] && echo "Usage: spider url [depth=5]" && return 1
        lynx \
          -dump \
          -listonly \
          $1 \
        | awk '/^ *[0-9]/ {print $2}'
      }
      f="echo Start getting used to asdf... aliased to 'a' at least"
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
alias nt="npm test"
alias nx="npx"
alias o="ocaml"
alias py="python"
alias python="python3"
      report() { $@ && say "done" || say "error" }
alias rk="raku"
alias rt="racket"
alias sactl="sudo apachectl"
alias start_postgres="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias tsn="ts-node"
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
alias waitfor="wait-on --interval 999 --timeout ${TIMEOUT:-99999}"
alias webfiles="rg --type web --files"
      webm2mp3() {
        ffmpeg -i "$1" -vn -f mp3 "${1%.webm}.mp3"
      }
alias y="yarn" # runs `yarn install` with no args...
alias z="zola"

back_up_drive() {
  FROM=${1:?specify volume names: first from, then to}
  TO=${2:?specify volume names: first from, then to}
  START=$(date)
  echo "Started: $START"
  unison \
    -fastcheck true \
    -copythreshold 10000 \
    -ignore 'Name {.fseventsd,.Trashes}' \
    "/Volumes/${FROM}" \
    "/Volumes/${TO}"
  END=$(date)
  echo
  echo "Started: $START"
  echo "Ended @: $END"
}

back_up_media_unison() {
  back_up_drive MEDIA Media2
}

[[ -f ~/.br-env.zsh ]] && source ~/.br-env.zsh

aoc() {
  # Advent Of Code — https://adventofcode.com
  # create dir and download first part of the puzzle
  if [[ "$1" == "today" ]]; then
    YEAR=$(date +%Y)
    DAY=$(date +%d)
  else
    YEAR=$1
    DAY=$(printf '%02d' "$2")
  fi
  DIR=~/workspace/adventofcode/${YEAR}/${DAY}
  mkdir -p $DIR
  cd $DIR
  URL=https://adventofcode.com/${YEAR}/day/${2}
  echo "\`\`\`" >README.md
  links -dump $URL \
  | awk '/--- Day/{P=1} /identify/{P=0} {if (P) print}' \
  >> README.md
  echo "\`\`\`" >>README.md
  cat README.md
}

yt-rip-stream() { yt-dlp --extract-audio --live-from-start https://www.youtube.com/watch\?v\=${${${${1:?pass a YouTube ID/url}#*=}%&*}:?could not determine YouTube ID; exiting...} }
