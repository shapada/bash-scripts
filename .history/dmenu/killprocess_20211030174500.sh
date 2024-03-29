#!/usr/bin/env bash

# dmenu theming
lines="-l 100"
colors="-nb #2C323E -nf #9899a0 -sb #BF616A -sf #2C323E"

selected="$(ps -a -u $USER | \
            dmenu -i -p "Type to search and select process to kill" \
            $lines | \
            awk '{print $1" "$4}')"; 

if [[ ! -z $selected ]]; then

    answer="$(echo -e "Yes\nNo" | \
            dmenu -i -p "$selected will be killed, are you sure?" \
            $lines $colors $font )"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $1}' <<< $selected)"; 
        kill -9 $selpid
    fi
fi

exit 0