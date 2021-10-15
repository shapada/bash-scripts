#!/usr/bin/env bash

folders="Downloads|Code|Documents|Videos"
folder_paths=$(tree $HOME -L 2 --matchdirs -i -P "Downloads|Code}" --prune --dirsfirst -f)
folder_path=$(echo "$folder_paths" | dmenu -l 100 -i  -p "Open")

if [ -n "$folder_path" ]; then
    xdg-open "$folder_path" 2> /dev/null
fi