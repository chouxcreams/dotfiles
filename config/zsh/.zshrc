typeset -U path PATH

export HISTFILE="$XDG_STATE_HOME"/zsh/history

path=(
    /opt/homebrew/bin(N-/)
    /usr/local/bin(N-/)
    /home/linuxbrew/.linuxbrew/bin(N-/)
    $HOME/.local/bin(N-/)
    $HOME/bin(N-/)
    $path
)


### mise ###
if (( ${+commands[mise]} )) then;
    eval "$(mise activate zsh)"
    eval "$(mise hook-env -s zsh)" # miseに設定されたpathが使えるようにする
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
