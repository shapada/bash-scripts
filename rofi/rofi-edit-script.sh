#!/usr/bin/env bash

FILE=$(ls ~/Development/scripts | rofi -dmenu -i -p "Edit Script")

echo $FILE

if [ -n "$FILE" ]; then
    xdg-open "${FILE}" 2> /dev/null     

    exec i3-msg [title="^code-oss$"]; focus
fi
