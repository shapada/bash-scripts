#!/usr/bin/env bash

terminal="terminal"
prompt="-p Search YAY"
# list all manuals
query=$(dmenu -p "Search: Yay" -l 1)

echo $query

if [[ ! -z "$query" ]]; then
    eval "$($terminal -T "YAY Search Results" -e "yay $query")"
fi

exit 0

