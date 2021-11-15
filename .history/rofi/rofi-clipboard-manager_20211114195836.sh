#!/usr/bin/env bash

SELECTION=$(rofi -modi "Clipboard:greenclip" -show Clipboard -run-command '{cmd}')

if [ -n "$SELECTION" ]; then
    sleep 0.5

    xdotool type $(xclip -o -selection clipboard);
fi