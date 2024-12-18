#! /bin/bash -e

DOTFILES_DIR="$HOME"/dotfiles
DOTFILES_CONFIG_DIR="$DOTFILES_DIR"/config
XDG_CONFIG_HOME="$HOME"/.config
XDG_DATA_HOME="$HOME"/.local/share
XDG_STATE_HOME="$HOME"/.local/state
XDG_CACHE_HOME="$HOME"/.cache
XDG_RUNTIME_DIR="$HOME"/.tmp
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_RUNTIME_DIR"

ln -sfv "$DOTFILES_CONFIG_DIR"/zsh "$XDG_CONFIG_HOME"

mkdir -p "$XDG_DATA_HOME"/zsh
mkdir -p "$XDG_DATA_HOME"/zsh/completions
mkdir -p "$XDG_STATE_HOME"/pg
mkdir -p "$XDG_STATE_HOME"/node
mkdir -p "$XDG_STATE_HOME"/mydql
mkdir -p "$XDG_STATE_HOME"/sqlite
mkdir -p "$XDG_STATE_HOME"/zsh
mkdir -p "$XDG_CONFIG_HOME"/wakatime
mkdir -p "$XDG_CACHE_HOME"/sheldon

# nanoのシンタックスハイライトをインストール
# git clone https://github.com/scopatz/nanorc.git "$XDG_CONFIG_HOME"/nano/.nanorc

ln -sfv "$DOTFILES_CONFIG_DIR"/git "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/nano "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/npm "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/micro "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/bat "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/starship.toml "$XDG_CONFIG_HOME"/starship.toml
ln -sfv "$DOTFILES_CONFIG_DIR"/latexmk "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/navi "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/python "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/zellij "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/sheldon "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/1password "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/homebrew "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/mise "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/zeno "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/ripgrep "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/glow "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/lazygit "$XDG_CONFIG_HOME"
ln -sfv "$DOTFILES_CONFIG_DIR"/rio "$XDG_CONFIG_HOME"
ln -sfv "$XDG_CONFIG_HOME/zsh/.zshenv" "$HOME/.zshenv"
ln -sfv "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" "$XDG_CONFIG_HOME/1password/agent.sock"
