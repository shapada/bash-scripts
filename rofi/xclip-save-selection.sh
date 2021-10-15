#!/usr/bin/env bash

XCLIP_SELECTION=$( xclip -out -selection primary | xclip -in -selection clipboard)
SAVED_XCLIPS="$HOME/local/logs/xclips.log"
CLIPS_DIR="$HOME/local/logs/xclips"

if [ -n "$SAVED_XCLIPS" ]; then
    FILE_NAME=$(rofi -dmenu -i -l 0 -p "Save As")
    xclip -o > "${CLIPS_DIR}/${FILE_NAME}"
fi