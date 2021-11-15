#!/bin/sh

# # fuzzy_win launches the script from param in a centered window
# xdotool search --onlyvisible --classname fzflaunch windowunmap \
#   || xdotool search --classname fzflaunch windowmap \
#   || $TERMINAL -name fzflaunch -geometry 40x8+297+1 -hold -e zsh -c 'source ~/.zshrc; fman'
echo $terminal

$terminal -hold -e zsh -c 'source ~/.zshrc; "$1"'
