#!/usr/bin/env bash

fzf_window=$SCRIPTS_DIR/fzf/fzf-window
# list all manuals
#manual="$(man -k . | dmenu $prompt | awk '{print $1}')"

eval $( $fzf_window fman )

# # open selected manual with terminal
# if [[ ! -z "$manual" ]]; then
#     eval "$($terminal -T "Mansearch - Manual Viewer" -e "man $manual")"
# fi

