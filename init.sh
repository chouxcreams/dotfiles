#! /bin/bash -e

DOTPATH="$HOME/dotfiles"
ln -s "$DOTPATH"/.zshenv "$HOME"/.zshenv
ln -s "$DOTPATH"/.nanorc "$HOME"/.nanorc

# gitの補完用スクリプトのダウンロード
curl -o "$DOTPATH"/.zsh/completion/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o "$DOTPATH"/.zsh/completion/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# dockerの補完用スクリプトのダウンロード
curl -o "$DOTPATH"/.zsh/completion/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker

# nanoのシンタックスハイライトをインストール
git clone https://github.com/scopatz/nanorc.git "$DOTPATH"/.nano

mkdir -p "$HOME"/.config
ln -s "$DOTPATH"/.config/git "$HOME"/.config/git
ln -s "$DOTPATH"/.config/karabiner "$HOME"/.config/karabiner
