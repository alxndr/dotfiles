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
  BRANCH=$(git branch | grep -m 1 "$1" | sed -e 's/^..//')
  echo $BRANCH
  if [[ -z "$BRANCH" ]]; then
    echo "No branch found with '$1' in the name."
    return
  fi
  gitc checkout "$BRANCH"
}

alias brr="bundle && rdm && rr"
alias cukes="ENV=local cucumber features/ -t @complete -t @write -r features/"
alias generate_tags="ctags -R -f ./.git/tags --exclude=jscoverage --exclude=.jhw-cache --exclude=.sass-cache --exclude=pkg ."
alias jack="ack --js --ignore-dir=pkg --ignore-dir=vendor --ignore-dir=jscoverage --ignore-dir=ext"
alias rr="if [[ -e ./tmp/restart.txt ]]; then touch ./tmp/restart.txt && echo Restarted server; else echo No ./tmp/restart.txt?; fi; update_homepage"
alias smart_asset="smart_asset -v"
alias update_homepage="if [[ -e ./vendor/plugins/cmservice_plugin/bin/cmservice ]]; then ruby vendor/plugins/cmservice_plugin/bin/cmservice && echo Reloaded homepage; fi"

