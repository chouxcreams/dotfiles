#!/usr/bin/env zsh

eval "$(starship init zsh)"
# eval "$(gh completion -s zsh)"
eval "$(direnv hook zsh)"
### ディレクトリ移動するたびに呼び出される関数
function chpwd() {
    echo -ne "\033]0;$(pwd | sed 's|.*/||')\007"
}
autoload -Uz chpwd && chpwd
