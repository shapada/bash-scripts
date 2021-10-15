#!/usr/bin/env bash

# terminal to open manual
terminal="terminal"

# list all manuals
package=$(echo -n '' | dmenu -p "YAY Search:")

# open selected manual with terminal
if [[ ! -z "$package" ]]; then
    eval $($terminal -hold -T "YAY" -e yay "$package")
    exit;
fi

exit 0

