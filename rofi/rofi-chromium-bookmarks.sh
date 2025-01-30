#!/usr/bin/env bash

bookmark_data=$( jq '.roots.bookmark_bar.children' ~/.config/chromium/Default/Bookmarks )

var bookmarks
for row in $(echo "${bookmark_data}" | jq -r '.[] | @base64'); do
        _jq() {
            echo ${row} | base64 --decode | jq -r ${1}
        }

        name=$(_jq '.name')
        url=$(_jq '.url')

        if [ "$url" != "null" ]; then
            bookmarks+=("${name} | [${url}]")
        fi
done

selection=$(printf "%s\n" "${bookmarks[@]}" | rofi -dmenu -i -p "Bookmarks" | awk --field-separator="|" '{print $NF}')
if [ -n "$selection" ]; then
    xdg-open $selection 2> /dev/null  
    exec i3-msg [class="^Chromium$"] focus
fi