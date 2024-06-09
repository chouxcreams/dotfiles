#!/usr/bin/env zsh

#### 環境変数の設定 ####
export EDITOR=nano
(( ${+commands[micro]} )) && EDITOR=micro
export PIPENV_VENV_IN_PROJECT=true

### anyenv ###
export ANYENV_ROOT="$XDG_DATA_HOME"/anyenv
(( ${+commands[anyenv]} )) && eval "$(anyenv init -)"

### aws-cli ###
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

### bat ###
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME"/bat/bat.conf

### delta ###

### deno ###
export DENO_DIR="$XDG_CACHE_HOME"/deno
export DENO_INSTALL_ROOT="$XDG_DATA_HOME"/deno
alias desk='deno task'
alias drun='deno run'

### Docker ###

### Elm ###
# IntelliJのElmプラグインがELM_HOMEに対応していないため使わない
# export ELM_HOME="$XDG_CONFIG_HOME"/elm

### eza ###
(( ${+commands[eza]} )) && alias ls=' eza --git --icons=always --header --time-style "+%Y-%m-%d %H:%M"'
alias la='ls -a'
alias ll='ls -la'

### fzf ###
[ -f $XDG_DATA_HOME/fzf/fzf.zsh ] && source $XDG_DATA_HOME/fzf/fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND='fd --type d'

### gibo ###
export GIBO_BOILERPLATES="$XDG_DATA_HOME"/gitignore-boilerplates

### gmailctl ###
if (( ${+commands[gmailctl]} )) then;
    alias gmailctl='gmailctl --config $XDG_CONFIG_HOME/gmailctl'
    alias gctl='gmailctl'
fi

### Golang ###
export GOPATH="$XDG_DATA_HOME"/go
export GOENV_ROOT="$XDG_DATA_HOME"/goenv

### Gradle ###
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

### less ###
export LESSHISTFILE=-

### MySQL ###
export MYSQL_HISTFILE="$XDG_STATE_HOME"/mysql/mysql_history

### navi ###
export NAVI_HOME="$XDG_CONFIG_HOME"/navi
export NAVI_CONFIG="$NAVI_HOME"/config.yaml

### netrc ###
export NETRC="$XDG_CONFIG_HOME"/netrc/.netrc

### Node.js ###
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/node_repl_history

### npm ###
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

### pipx ###
export PIPX_HOME="$XDG_DATA_HOME"/pipx
export PIPX_BIN_DIR="$XDG_DATA_HOME"/pipx/bin

### Poetry ###
export POETRY_HOME="$XDG_DATA_HOME/poetry"

### PostgreSQL ###
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

### Python ###
# export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonstartup.py
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export MPLCONFIGDIR="$XDG_CONFIG_HOME"/matplotlib

### ripgrep ###
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/ripgreprc

### Rust ###
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

### Ruby ###
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

### sbt ###
export SBT_OPTS="-ivy "$XDG_DATA_HOME"/ivy2 -sbt-dir "$XDG_DATA_HOME"/sbt"

### SQLite ###
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite/sqlite_history

### Starship ###
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship.toml

### task ###

### virtualenv ###
export WORKON_HOME="$XDG_DATA_HOME"/virtualenvs

### Volta ###
export VOLTA_HOME="$XDG_DATA_HOME"/volta

### wget ###
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

### wakatime ###
export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime

### zellij ###
alias zel="zellij"

### zeno ###

### zoxide ###
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
if (( ${+commands[zoxide]} )); then
    alias cd='z'
    eval "$(zoxide init zsh)"
fi

### Pathの設定
path=(
    $HOME/Library/Android/sdk(N-/)
    $HOME/Library/Android/sdk/platform-tools(N-/)
    $CARGO_HOME/bin(N-/)
    $GOPATH/bin(N-/)
    $DENO_INSTALL_ROOT/bin(N-/)
    $XDG_CONFIG_HOME/git/subcommand(N-/)
    $VOLTA_HOME/bin(N-/)
    $POETRY_HOME/bin(N-/)
    $PIPX_BIN_DIR(N-/)
    $path
)

export GCD_PATH="$HOME/dotfiles:$GCD_PATH"

### homebrewの設定
### cf).https://zenn.dev/ress/articles/069baf1c305523dfca3d
if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
    [[ -x /usr/local/bin/brew ]] && alias brewed="arch -arch x86_64 /usr/local/bin/brew"
    alias x64='exec arch -x86_64 /bin/zsh'
    alias a64='exec arch -arm64e /bin/zsh'
    switch-arch() {
        if  [[ "$(uname -m)" == arm64 ]]; then
            arch=x86_64
        elif [[ "$(uname -m)" == x86_64 ]]; then
            arch=arm64e
        fi
        exec arch -arch $arch /bin/zsh
    }
fi

setopt magic_equal_subst

### エイリアスの設定
alias arduino='/Applications/Arduino.app/Contents/MacOS/Arduino'
alias hex='hexyl'
alias nano='nano -i -m'
alias reshell='exec $SHELL -l' #shellの再起動
alias rlang='/usr/local/bin/r'
alias gd='cd-gitroot'
alias pathls='echo $PATH | sed -e "s/:/\n/g"'
alias e='$EDITOR'
alias editorconfig-gen='cp $DOTFILES_DIR/.editorconfig .' # editorconfigファイルの生成

### dotfilesをグローバルで管理するための関数
function dot {
    (cd $DOTFILES_DIR && task $@)
}
