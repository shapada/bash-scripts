#!/usr/bin/env bash

id=$(xdo id -n scratchterm)

if [ -z "$id" ]; then
  urxvtc -name scratchterm -e zsh -c "tmux new-session -A -s dummy"
  exec i3-msg [instnce="scratchterm"] resize set 1910 550; move position 5px 0
else
  action='hide';

  if [[ $(xprop -id $id | awk '/window state: / {print $3}') == 'Withdrawn' ]]; then
    action='show';
  fi

  xdo $action -n scratchterm

  exec i3-msg [instance="scratchterm"] focus
fi