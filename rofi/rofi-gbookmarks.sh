#!/usr/bin/env bash

SELECTION=$(rofi -modi "Clipboard:greenclip print" -show Clipboard -run-command '{cmd}')

if [ -n "$SELECTION" ]; then
    xdotool type $(xclip -o -selection clipboard);
fis