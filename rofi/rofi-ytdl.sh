#!/bin/bash

URL=$(rofi -dmenu -i -l 0 -p "Video URL")
DIR="$HOME/Videos/ytdl/.p"

if [ -n "$URL" ]; then
    mkdir -p "$DIR"

	youtube-dl -i -o "$DIR/%(title)s.%(ext)s" "$URL"
fi