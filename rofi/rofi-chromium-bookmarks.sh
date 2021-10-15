#!/usr/bin/env bash

BOOKMARKS_DATA=$( jq '.roots.bookmark_bar.children' ~/.config/chromium/Default/Bookmarks )
BOOKMARKS=()

for row in $(echo "${BOOKMARKS_DATA}" | jq -r '.[] | @base64'); do
        _jq() {
            echo ${row} | base64 --decode | jq -r ${1}
        }

        NAME=$(_jq '.name')
        URL=$(_jq '.url')

        if [ "$URL" != "null" ]; then
            BOOKMARKS+=("${NAME} | ${URL}")
        fi
done

SELECTION=$(printf "%s\n" "${BOOKMARKS[@]}" | rofi -dmenu -i -p "Bookmarks" | awk --field-separator="|" '{print $NF}')
echo "$SELECTION" 
if [ -n "$SELECTION" ]; then
    xdg-open $SELECTION 2> /dev/null  
    exec i3-msg [class="^Chromium$"] focus
fi