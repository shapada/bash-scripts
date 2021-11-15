#!/usr/bin/env bash

# terminal to open manual
terminal="urxvt"

scripts_dir=${SCRIPTS_DIR:-$HOME/.local/scripts}

echo $scripts_dir

read -ra user_input=$(find $scripts_dir -type f \( -iname "*" ! -iname ".*" \) | sort | dmenu -l 100 -i -p "Run Script")

echo $user_input

if [ ! -z "${input_cmd}" ];  then
    if [ ! -z "${input_cmd[1]}" ]; then
        cmd="${input_cmd[@]}"
    else
        cmd="${input_cmd}"
    fi

    $terminal -e zsh -c "${cmd}"
fi
