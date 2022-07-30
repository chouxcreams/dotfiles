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


### Zinitでプラグインを入れる
zinit wait lucid blockf light-mode for \
    @'zsh-users/zsh-autosuggestions' \
    @'zsh-users/zsh-completions' \
    @'zdharma-continuum/fast-syntax-highlighting' \
    @'paulirish/git-open' \
    @'mollifier/cd-gitroot'


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
export EDITOR=nano
export PIPENV_VENV_IN_PROJECT=true
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND='fd --type d'
export STARSHIP_CONFIG="$ZDOTDIR"/.config/starship.toml

### aws-cli ###
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

### Golang ###
export GOPATH="$XDG_DATA_HOME"/go

### Node.js ###
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

### npm ###
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

### Volta ###
export VOLTA_HOME="$XDG_DATA_HOME"/volta

### MySQL ###
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history

### SQLite ###
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite_history

### PostgreSQL ###
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

### Pathの設定
path=(
    $HOME/Library/Android/sdk(N-/)
    $HOME/Library/Android/sdk/platform-tools(N-/)
    $HOME/.anyenv/bin(N-/)
    $HOME/.cargo/bin(N-/)
    $GOPATH/bin(N-/)
    $ZDOTDIR/git-subcommand(N-/)
    $VOLTA_HOME/bin(N-/)
    $HOME/.poetry/bin(N-/)
    $path
)

export GCD_PATH="$HOME/dotfiles:$GCD_PATH"


### エイリアスの設定
alias arduino='/Applications/Arduino.app/Contents/MacOS/Arduino'
alias dcp='docker compose'
alias hex='hexyl'
alias ll='lsd -la'
alias ls='lsd'
alias nano='nano -i -m'
alias reshell='exec $SHELL -l' #shellの再起動
alias rlang='/usr/local/bin/r'
alias cdgr='cd-gitroot'
alias cd='z'


### gitやdockerの補完の設定
autoload -Uz compinit && compinit -i


### その他
eval "$(starship init zsh)"
eval "$(gh completion -s zsh)"
eval "$(direnv hook zsh)"
eval "$(anyenv init -)"
eval "$(zoxide init zsh)"

ssh-add -K ~/.ssh/id_rsa &> /dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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