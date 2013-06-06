# shortcuts and whatnot for br

# git-cycle helper function
# `gco ticket-number` will check out a branch that includes "ticket-number"
gco() {
  if [[ -z "$(which gitc)" ]]; then
    echo "Can't find gitc?"
    return
  fi
  if [[ -z "$1" ]]; then
    echo "Need a parameter to search for..."
    return
  fi
  BRANCH=$(git branch | grep $1 | head -1 | sed -e 's/^..//')
  echo $BRANCH
  if [[ -z "$BRANCH" ]]; then
    echo "No branch found with '$1' in the name."
    return
  fi
  gitc checkout "$BRANCH"
}

alias update_homepage="if [[ -e ./vendor/plugins/cmservice_plugin/bin/cmservice ]]; then ruby vendor/plugins/cmservice_plugin/bin/cmservice; fi"
alias rr="if [[ -e ./tmp/restart.txt ]]; then touch ./tmp/restart.txt && echo Restarted server; else echo No ./tmp/restart.txt?; fi; update_homepage"

