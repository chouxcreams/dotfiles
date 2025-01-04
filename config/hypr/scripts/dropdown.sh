#!/usr/bin/env bash

TOGGLE=/tmp/droptoggle
DROPTERM=kitty-dropdown

if [ -f "$TOGGLE" ]; then
    #Hide terminal and unpin
	hyprctl --batch "dispatch movewindowpixel 0 -500,$DROPTERM; dispatch pin $DROPTERM; dispatch cyclenext"
	rm $TOGGLE
else
    #Show terminal and pin
    hyprctl --batch "dispatch movewindowpixel 0 500,$DROPTERM; dispatch pin $DROPTERM; dispatch focuswindow $DROPTERM"
    touch $TOGGLE
fi
exec-once=[workspace special; size 75% 20%;move 12.5% 40] kitty
bind=,F12,togglespecialworkspace
