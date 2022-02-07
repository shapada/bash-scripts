#!/usr/bin/env bash

SELECTION=$(rofi -modi "Clipboard:greenclip print,drun" -show Clipboard -run-command '{cmd}')

if [ -n "$SELECTION" ]; then
    sleep 0.5

    xdotool type $(xclip -o -selection clipboard);
fi