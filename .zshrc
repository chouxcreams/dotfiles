### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


### Zinitでプラグインを入れる
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light paulirish/git-open
zinit light mollifier/cd-gitroot


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


### 環境変数の設定
export LANG=ja_JP.UTF-8
export EDITOR=nano
export GOPATH=$HOME/go
export PIPENV_VENV_IN_PROJECT=true
export VOLTA_HOME=$HOME/.volta
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND='fd --type d'
export STARSHIP_CONFIG="$ZDOTDIR"/.config/starship.toml


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
alias nano='/usr/local/bin/nano -i -m'
alias reshell='exec $SHELL -l' #shellの再起動
alias rlang='/usr/local/bin/r'
alias cdgr='cd-gitroot'
alias cd='z'


### gitやdockerの補完の設定
zstyle ':completion:*:*:git:*' script ~/dotfiles/.zsh/completion/git-completion.bash
fpath=(~/dotfiles/.zsh/completion $fpath)
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

for file in `\fd .zsh $ZDOTDIR/.zsh/rc --max-depth 1 --type f --type l`; do
    source $file
done
