# shortcuts and whatnot for br

alias cukes="ENV=local cucumber features/ -t @complete -t @write -r features/"
unalias gc
alias gc="gitc"
alias generate_tags="ctags -R -f ./.git/tags --exclude=jscoverage --exclude=.jhw-cache --exclude=.sass-cache --exclude=pkg ."
alias jack="ack --js --ignore-dir=pkg --ignore-dir=vendor --ignore-dir=jscoverage --ignore-dir=ext"
alias rr="if [[ -e ./tmp/restart.txt ]]; then touch ./tmp/restart.txt && echo Restarted server; else echo No ./tmp/restart.txt?; fi; update_homepage"
alias update_homepage="if [[ -e ./vendor/plugins/cmservice_plugin/bin/cmservice ]]; then ruby vendor/plugins/cmservice_plugin/bin/cmservice && echo Reloaded homepage; fi"
