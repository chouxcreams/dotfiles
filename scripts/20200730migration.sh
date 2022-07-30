#! /usr/local/bin/bash

mv -f "$HOME"/.volta "$VOLTA_HOME"
mv "$HOME"/.node_repl_history "$NODE_REPL_HISTORY"
mv "$HOME"/.npmrc "$NPM_CONFIG_USERCONFIG"
mv "$HOME"/.mysql_history "$MYSQL_HISTFILE"
mv "$HOME"/.sqlite_history "$SQLITE_HISTORY"
mv "$HOME"/.psql_history "$PSQL_HISTORY"
mv -f "$HOME"/.npm "$XDG_CACHE_HOME"/npm
mv -f "$HOME"/go "$XDG_DATA_HOME"/go
mv -f "$HOME"/.aws "$XDG_CONFIG_HOME"/aws
mv -f "$HOME"/.rustup "$XDG_DATA_HOME"/rustup
mv -f "$HOME"/.cargo "$XDG_DATA_HOME"/cargo
mv -f "$HOME"/.gem "$XDG_DATA_HOME"/gem
mv -f "$HOME"/.elm "$XDG_DATA_HOME"/elm
