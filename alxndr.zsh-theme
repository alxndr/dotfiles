autoload -U colors && colors

NEWLINE=$'\n'

PREVIOUS_COMMAND_EXIT_STATUS_INDICATOR="%(?..%{$fg[red]%}%? ✘ %{$reset_color%})"

DEFAULT_DOCKER_IMAGE_STATUS="$(docker-machine ls 2>/dev/null | grep default | awk '{print $4}')"

if [[ "$DEFAULT_DOCKER_IMAGE_STATUS" -eq "Stopped" ]]; then
  DOCKER_THING=""
else
  DOCKER_THING="🐳 "
fi

PROMPT='${NEWLINE}%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%{$reset_color%}${NEWLINE}${PREVIOUS_COMMAND_EXIT_STATUS_INDICATOR}${DOCKER_THING}%{$fg[magenta]%}$%{$reset_color%} '
RPROMPT="%{$fg_bold[black]%}[%*]%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}🌵 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

