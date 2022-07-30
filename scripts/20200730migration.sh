#! /usr/local/bin/bash

mv -f "$HOME"/.volta "$VOLTA_HOME"
mv "$HOME"/.node_repl_history "$NODE_REPL_HISTORY"
mv "$HOME"/.npmrc "$NPM_CONFIG_USERCONFIG"
mv "$HOME"/.mysql_history "$MYSQL_HISTFILE"
mv "$HOME"/.sqlite_history "$SQLITE_HISTORY"
mv "$HOME"/.psql_history "$PSQL_HISTORY"
mv -f "$HOME"/.npm "$XDG_CACHE_HOME"/npm
