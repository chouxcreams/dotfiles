# Fig pre block. Keep at the top of this file.
[[ -f "$XDG_DATA_HOME/fig/shell/zshrc.pre.zsh" ]] && . "$XDG_DATA_HOME/fig/shell/zshrc.pre.zsh"

typeset -U path PATH

path=(
    /opt/homebrew/bin(N-/)
    /usr/local/bin(N-/)
    /home/linuxbrew/.linuxbrew/bin(N-/)
    $path
)


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

# Fig post block. Keep at the bottom of this file.
[[ -f "$XDG_DATA_HOME/fig/shell/zshrc.post.zsh" ]] && . "$XDG_DATA_HOME/fig/shell/zshrc.post.zsh"
