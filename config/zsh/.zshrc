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
eval "$(sheldon source)"

### gitやdockerの補完の設定
autoload -Uz compinit && compinit -i

ssh-add -K ~/.ssh/id_rsa &> /dev/null

# Fig post block. Keep at the bottom of this file.
[[ -f "$XDG_DATA_HOME/fig/shell/zshrc.post.zsh" ]] && . "$XDG_DATA_HOME/fig/shell/zshrc.post.zsh"