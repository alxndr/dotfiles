# shortcuts and whatnot for br

alias brr="bundle && rdm && rr"
alias cukes="ENV=local cucumber features/ -t @complete -t @write -r features/"
alias fsa="bin/deploy/fix_pkg && echo now running smart_asset... && DEBUG=1 smart_asset"
alias generate_tags="ctags -R -f ./.git/tags --exclude=jscoverage --exclude=.jhw-cache --exclude=.sass-cache --exclude=pkg ."
alias jack="ack --js --ignore-dir=pkg --ignore-dir=vendor --ignore-dir=jscoverage --ignore-dir=ext"
alias rr="if [[ -e ./tmp/restart.txt ]]; then touch ./tmp/restart.txt && echo Restarted server; else echo No ./tmp/restart.txt?; fi; update_homepage"
      ticket() { gitc branch https://bleacherreport.lighthouseapp.com/projects/6296/tickets/$1 }
alias update_homepage="if [[ -e ./vendor/plugins/cmservice_plugin/bin/cmservice ]]; then ruby vendor/plugins/cmservice_plugin/bin/cmservice && echo Reloaded homepage; fi"

