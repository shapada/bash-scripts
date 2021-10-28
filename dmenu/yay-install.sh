#!/usr/bin/env bash

# terminal to open manual
terminal="terminal"

# list all manuals
package=$(echo -n '' | dmenu -p "YAY Search:")

# open selected manual with terminal
if [[ ! -z "$package" ]]; then
    $terminal -hold -e zsh -c 'tmux new-session -c "yay $package" | fzf'
fi