#!/bin/bash

URL=$(rofi -dmenu -i -l 0 -p "Video URL")
DIR="$HOME/ytdl"

if [ -n "$URL" ]; then
	youtube-dl -i -o "$DIR/%(title)s.%(ext)s" "$URL"
fi