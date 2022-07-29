#! /bin/bash -e

DOTPATH="$HOME/dotfiles"
XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
ln -sfv "$DOTPATH"/.config/zsh "$XDG_CONFIG_HOME"

# nanoのシンタックスハイライトをインストール
git clone https://github.com/scopatz/nanorc.git "$XDG_CONFIG_HOME"/nano/.nanorc

ln -sfv "$DOTPATH"/.config/git "$XDG_CONFIG_HOME"
ln -sfv "$DOTPATH"/.config/nano "$XDG_CONFIG_HOME"
ln -sfv "$DOTPATH"/.config/starship.toml "$XDG_CONFIG_HOME"

