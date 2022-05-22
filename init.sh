#! /bin/bash -e

DOTPATH="$HOME/dotfiles"
ln -s "$DOTPATH"/.zshenv "$HOME"/.zshenv
ln -s "$DOTPATH"/.nanorc "$HOME"/.nanorc

# nanoのシンタックスハイライトをインストール
git clone https://github.com/scopatz/nanorc.git "$DOTPATH"/.nano

mkdir -p "$HOME"/.config
ln -s "$DOTPATH"/.config/git "$HOME"/.config/git
