#! /bin/sh

DOTPATH="$HOME/dotfiles"
ln -s $DOTPATH/.zshenv $HOME/.zshenv

# gitの補完用スクリプトのダウンロード
curl -o $HOME/dotfiles/.zsh/completion/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o $HOME/dotfiles/.zsh/completion/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# dockerの補完用スクリプトのダウンロード
curl -o $HOME/dotfiles/.zsh/completion/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
