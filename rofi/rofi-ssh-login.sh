#!/usr/bin/env bash

SERVERS=$(awk '$1=="HostName"{$1="";H=substr($0,2)};$1=="Host"{print $2}' ~/.ssh/config | column -s '$' -t)
SELECTION=$(echo "$SERVERS" | rofi -dmenu -no-fixed-num-line -p "Select Server" );

if [ -n "$SELECTION" ]; then
    urxvt -hold -e ssh "$SELECTION"
fi

