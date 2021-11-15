#!/usr/bin/env bash

prompt="-p Manual:"

# terminal to open manual
terminal="terminal"

# list all manuals
#manual="$(man -k . | dmenu $prompt | awk '{print $1}')"

$SCRIPTS_DIR/fzf/fzf-window fman

# # open selected manual with terminal
# if [[ ! -z "$manual" ]]; then
#     eval "$($terminal -T "Mansearch - Manual Viewer" -e "man $manual")"
# fi

exit 0

