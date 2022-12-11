### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Fig pre block. Keep at the top of this file.
[[ -f "$XDG_DATA_HOME/fig/shell/zshrc.pre.zsh" ]] && . "$XDG_DATA_HOME/fig/shell/zshrc.pre.zsh"

### Zinitでプラグインを入れる
zinit wait lucid blockf light-mode for \
    @'zsh-users/zsh-autosuggestions' \
    @'zsh-users/zsh-completions' \
    @'zdharma-continuum/fast-syntax-highlighting' \
    @'paulirish/git-open' \
    @'mollifier/cd-gitroot' \
    @'momo-lab/zsh-replace-multiple-dots'


typeset -U path PATH


### homebrewの設定
### cf).https://zenn.dev/ress/articles/069baf1c305523dfca3d
path=(
	/opt/homebrew/bin(N-/)
	/usr/local/bin(N-/)
	$path
)
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


#### 環境変数の設定 ####
export LANG=ja_JP.UTF-8
export HISTFILE="$XDG_STATE_HOME"/zsh/history
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

### Docker ###
alias dcp='docker compose'
zinit ice wait lucid as"completion" has"docker"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

### Elm ###
# IntelliJのElmプラグインがELM_HOMEに対応していないため使わない
# export ELM_HOME="$XDG_CONFIG_HOME"/elm

### fzf ###
[ -f $XDG_DATA_HOME/fzf/fzf.zsh ] && source $XDG_DATA_HOME/fzf/fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND='fd --type d'

### gibo ###
export GIBO_BOILERPLATES="$XDG_DATA_HOME"/gitignore-boilerplates
zinit ice wait lucid as"completion" has"gibo" mv"gibo-completion.zsh -> _gibo"
zinit snippet https://github.com/simonwhitaker/gibo/blob/main/shell-completions/gibo-completion.zsh

### Golang ###
export GOPATH="$XDG_DATA_HOME"/go
export GOENV_ROOT="$XDG_DATA_HOME"/goenv

### Gradle ###
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

### less ###
export LESSHISTFILE=-

### lsd ###
(( ${+commands[lsd]} )) && alias ls='lsd'
alias la='ls -a'
alias ll='ls -la'

### MySQL ###
export MYSQL_HISTFILE="$XDG_STATE_HOME"/mysql/mysql_history

### navi ###
export NAVI_CONFIG="$XDG_CONFIG_HOME"/navi/config.yaml

### netrc ###
export NETRC="$XDG_CONFIG_HOME"/netrc/.netrc

### Node.js ###
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/node_repl_history

### npm ###
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
zinit ice wait lucid as"completion" has"npm" mv"completion.sh -> _npm"
zinit snippet https://github.com/npm/cli/blob/latest/lib/utils/completion.sh

### PostgreSQL ###
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

### Python ###
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonstartup.py
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export MPLCONFIGDIR="$XDG_CONFIG_HOME"/matplotlib

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
zinit ice wait lucid as"completion" has"task"
zinit snippet https://github.com/go-task/task/blob/master/completion/zsh/_task

### Volta ###
export VOLTA_HOME="$XDG_DATA_HOME"/volta

### wget ###
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

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
    $XDG_CONFIG_HOME/git/subcommand(N-/)
    $VOLTA_HOME/bin(N-/)
    $HOME/.poetry/bin(N-/)
    $path
)

export GCD_PATH="$HOME/dotfiles:$GCD_PATH"


### エイリアスの設定
alias arduino='/Applications/Arduino.app/Contents/MacOS/Arduino'
alias hex='hexyl'
alias nano='nano -i -m'
alias reshell='exec $SHELL -l' #shellの再起動
alias rlang='/usr/local/bin/r'
alias gd='cd-gitroot'
alias pathls='echo $PATH | sed -e "s/:/\n/g"'
alias e='$EDITOR'


### gitやdockerの補完の設定
autoload -Uz compinit && compinit -i


### その他
eval "$(starship init zsh)"
eval "$(gh completion -s zsh)"
eval "$(direnv hook zsh)"

ssh-add -K ~/.ssh/id_rsa &> /dev/null

# git add and commit
# 引数にはコミットメッセージを入れる
gac() {
    git add . && git commit -m "$1"
}

# git add, commit and push
# 引数にはコミットメッセージを入れる
gacp() {
    branch=`git rev-parse --abbrev-ref HEAD`
    git add . && git commit -m "$1" && git push -u origin "$branch"
}

for file in `\fd .zsh $ZDOTDIR/rc --max-depth 1 --type f --type l`; do
    source $file
done

[ -f $ZDOTDIR/rc/local.zsh ] && source $ZDOTDIR/rc/local.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$XDG_DATA_HOME/fig/shell/zshrc.post.zsh" ]] && . "$XDG_DATA_HOME/fig/shell/zshrc.post.zsh"
