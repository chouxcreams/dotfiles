#!/usr/bin/env zsh

(( ${+commands[starship]} )) && eval "$(starship init zsh)"
# eval "$(gh completion -s zsh)"
(( ${+commands[direnv]} )) && eval "$(direnv hook zsh)"
### ディレクトリ移動するたびに呼び出される関数
function chpwd() {
    echo -ne "\033]0;$(pwd | sed 's|.*/||')\007"
}
autoload -Uz chpwd && chpwd
