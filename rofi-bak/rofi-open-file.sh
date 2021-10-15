#!/usr/bin/env bash

SELECTION=$(tree "$HOME" -d --matchdirs -i -P "Downloads|Development|Documents|Videos" --prune --dirsfirst -f | rofi -dmenu -i  -p "Open")
if [ -n "$SELECTION" ]; then
    xdg-open "$SELECTION" 2> /dev/null
fi