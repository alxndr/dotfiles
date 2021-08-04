autoload -U colors && colors

NEWLINE=$'\n'

PREVIOUS_COMMAND_EXIT_STATUS_INDICATOR="%(?..%{$fg[red]%}%? ✘ %{$reset_color%})"

PROMPT='${NEWLINE}${NEWLINE}%{$reset_color%}%{$fg[cyan]%}%(3~|…/%2~|%~)%{$reset_color%} $(git_prompt_info)${NEWLINE}${PREVIOUS_COMMAND_EXIT_STATUS_INDICATOR}%{$fg[magenta]%}⟫%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}𝚫%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
