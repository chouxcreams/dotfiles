#!/usr/bin/env zsh

eval "$(starship init zsh)"
# eval "$(gh completion -s zsh)"
eval "$(direnv hook zsh)"

(( ${+commands[atuin]} )) && eval "$(atuin init zsh)"
