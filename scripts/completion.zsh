#!/usr/bin/env zsh
if (( ${+commands[gibo]} )); then
    gibo completion zsh > "$XDG_DATA_HOME"/zsh/completions/_gibo
fi

if (( ${+commands[volta]} )); then
    volta completions zsh > "$XDG_DATA_HOME"/zsh/completions/_volta
fi

if (( ${+commands[sheldon]} )); then
    sheldon completions --shell zsh > "$XDG_DATA_HOME"/zsh/completions/_sheldon
fi

