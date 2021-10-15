#!/usr/bin/env bash

SCRIPTS_DIR=/home/sd/Development/scripts

FILE=$(ls "$SCRIPTS_DIR" | rofi -dmenu -i -p "Link Script")

if [ -n "$FILE" ]; then
    LINK_NAME=$(rofi -dmenu -i -l 0 -p "Link Name")

    if [ -n "$LINK_NAME" ]; then
        FILE_PATH="${SCRIPTS_DIR}/${FILE}"

        chmod +x $FILE_PATH

        ln -s -f "$FILE_PATH" "$LOCAL_BIN/$LINK_NAME"
    fi
fi