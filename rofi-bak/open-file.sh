#!/usr/bin/env bash

# search root
root_path=$HOME

prompt="-p Open File"

file_path="$(find $root_path -maxdepth 5 -type d \( ! -regex '.*/\..*' \) | \
             sed 's|^'$root_path/'||' | sort | \
             rofi -dmenu -l 100 -i $prompt )"

if [[ ! -z $file_path ]]; then

    if [[ "$file_path" == "$root_path" ]]; then
        search_path=$root_path
    else
        search_path="$root_path/$file_path"
    fi

    total="$(find "$search_path" -maxdepth 1 -type f | wc -l)"
    
    if [[ $total -eq 0 ]]; then
        prompt="No files here!"
    else
        prompt="File:"
    fi

    file_name="$(find "$search_path" -maxdepth 1 -type f | \
                 awk -F'/' '{print $NF}' | \
                 rofi -dmenu -i -l 100 -p "$prompt")"

    if [[ ! -z $file_name ]]; then
        xdg-open "$search_path/$file_name"
    fi

fi

exit 0
