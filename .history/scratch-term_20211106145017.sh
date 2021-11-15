#!/usr/bin/env bash

id=$(xdo id -n scratchterm);
if [ -z "$id" ]; then
  terminal -name scratchterm -e zsh -c "tmux new-session -A -s dummy";
else
  action='hide';
  if [[ $(xprop -id $id | awk '/window state: / {print $3}') == 'Withdrawn' ]]; then
    action='show';
  fi
  xdo $action -n scratchterm
  exec i3-msg [instance="scratchterm"] focus
fi