#!/usr/bin/env zsh
if (( ${+commands[deno]} )); then
    deno completions zsh > "$XDG_DATA_HOME"/zsh/completions/_deno
fi

