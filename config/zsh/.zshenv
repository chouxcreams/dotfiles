### XDG Base Directory ###
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_RUNTIME_DIR="$HOME"/.tmp

### Zsh ###
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME"/zsh/history

### dotfiles ###
export DOTFILES_DIR="$HOME"/dotfiles
export DOTFILES_CONFIG_DIR="$DOTFILES_DIR"/.config
