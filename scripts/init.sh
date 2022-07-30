#! /bin/bash -e

DOTPATH="$HOME/dotfiles"
XDG_CONFIG_HOME="$HOME"/.config
XDG_DATA_HOME="$HOME"/.local/share
XDG_STATE_HOME="$HOME"/.local/state
XDG_CACHE_HOME="$HOME"/.cache
XDG_RUNTIME_DIR="$HOMR"/.tmp
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_RUNTIME_DIR"

ln -sfv "$DOTPATH"/.config/zsh "$XDG_CONFIG_HOME"

mkdir -p "$XDG_CONFIG_HOME"/.config/zsh/completion
mkdir -p "$XDG_CACHE_HOME"/pg

# nanoのシンタックスハイライトをインストール
git clone https://github.com/scopatz/nanorc.git "$XDG_CONFIG_HOME"/nano/.nanorc

ln -sfv "$DOTPATH"/.config/git "$XDG_CONFIG_HOME"
ln -sfv "$DOTPATH"/.config/nano "$XDG_CONFIG_HOME"
ln -sfv "$DOTPATH"/.config/starship.toml "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME"/latexmk
ln -sfv "$DOTPATH"/.config/latexmk/latexmkrc "$XDG_CONFIG_HOME"/latexmk/latexmkrc
ln -sfv "$XDG_CONFIG_HOME/zsh/.zshenv" "$HOME/.zshenv"
