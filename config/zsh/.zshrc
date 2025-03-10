typeset -U path PATH

export HISTFILE="$XDG_STATE_HOME"/zsh/history

path=(
    /opt/homebrew/bin(N-/)
    /usr/local/bin(N-/)
    /home/linuxbrew/.linuxbrew/bin(N-/)
    $HOME/.local/bin(N-/)
    $HOME/.local/share/cargo/bin(N-/)
    $HOME/bin(N-/)
    $path
)

### ghostty ###
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

### anyenv ###
export ANYENV_ROOT="$XDG_DATA_HOME"/anyenv
(( ${+commands[anyenv]} )) && eval "$(anyenv init -)" # miseよりも先に読み込まないと、miseの設定を優先してくれない。

### mise ###
if (( ${+commands[mise]} )) then;
    eval "$(mise activate zsh)"
    eval "$(mise hook-env -s zsh)" &> /dev/null # miseに設定されたpathが使えるようにする
fi

### プラグインの読み込み
### homebrewのbinにpathを通してから
if [[ -e "$XDG_CACHE_HOME/sheldon/sheldon.zsh" ]]; then
    source "$XDG_CACHE_HOME/sheldon/sheldon.zsh"
else
    eval "$(sheldon source)"
    echo "Run: task sheldon:cache --force "
fi

autoload -Uz compinit && compinit -i
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache-$ZSH_VERSION

ssh-add -K ~/.ssh/id_rsa &> /dev/null
