#!/usr/bin/env bash

# search root
root_path=$HOME

prompt="-p Folder"

code_folder="Code"

folder_path="$(find $root_path -maxdepth 5 -type d \( ! -regex '.*/\..*' \) | \
             sed 's|^'$root_path/'||' | sort | \
             rofi -dmenu -l 100 -i $prompt )"

if [[ ! -z $folder_path ]]; then
    if [[ "$folder_path" == "$root_path" ]]; then
        search_path=$root_path
    else
        search_path="$root_path/$folder_path"
    fi

    echo "$search_path"

    if [[ ! -z $search_path ]]; then
        if [[ "$search_path" == *"$code_folder"* ]]; then
            $VISUAL "$search_path"
        else
            xdg-open "$search_path"
        fi
    fi

fi

exit 0
