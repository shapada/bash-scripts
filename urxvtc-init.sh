#!/usr/bin/env bash

if [ ! urxvtc "$@" ]; then
  urxvtd -q -o -f
  urxvtc -n scratchterm "$@"
fi