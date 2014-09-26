autoload -U colors && colors

battery() { ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.0f%\%"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}' }

NEWLINE=$'\n'

PROMPT='${NEWLINE}%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%{$reset_color%}${NEWLINE}%{$fg[magenta]%}$%{$reset_color%} '
RPROMPT="%{$fg_bold[black]%}$(battery)${NEWLINE}[%*]%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}🌵 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

