autoload -U colors && colors

NEWLINE=$'\n'

PREVIOUS_COMMAND_EXIT_STATUS_INDICATOR="%(?..%{$fg[red]%}%? ✘ %{$reset_color%})"

RPROMPT="%{$fg[blue]%}${${(%):-%m}:s/MBP16M4-04/Planted Solar/}%{$reset_color%}"
PROMPT='${NEWLINE}${PREVIOUS_COMMAND_EXIT_STATUS_INDICATOR}${NEWLINE}%{$reset_color%}%{$fg[cyan]%}%(3~|…/%2~|%~)%{$reset_color%} $(git_prompt_info)${NEWLINE}%{$fg[magenta]%}⟫%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}𝚫%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
