# based on miloshadzic

PROMPT='
%1~%{$reset_color%}/ $(git_prompt_info)%{$fg[cyan]%}⇒%{$reset_color%}  '
RPROMPT='[%*]'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

