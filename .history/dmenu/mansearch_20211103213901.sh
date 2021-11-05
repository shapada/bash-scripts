#!/usr/bin/env bash

fzf_window=$SCRIPTS_DIR/fzf/fzf-window
# list all manuals
#manual="$(man -k . | dmenu $prompt | awk '{print $1}')"
source ~/local/scripts/fzf/fzf-functions
~/local/scripts/fzf/fzf-window fman


# # open selected manual with terminal
# if [[ ! -z "$manual" ]]; then
#     eval "$($terminal -T "Mansearch - Manual Viewer" -e "man $manual")"
# fi

