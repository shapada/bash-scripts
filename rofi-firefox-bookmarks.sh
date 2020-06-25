#!/usr/bin/env bash

DB="$HOME/local/backups/places.sqlite"
QUERY="select p.url, b.title from moz_places as p, moz_bookmarks as b where p.id == b.id order by b.title;"
BOOKMARKS=$(sqlite3 "${DB}" "${QUERY}")

echo "$BOOKMARKS"
if [ -n "$BOOKMARKS" ] ; then

    SELECTED=$( echo "$BOOKMARKS" | rofi -dmenu -p "Bookmarks")
    URL=$(echo "$SELECTED" | cut -d "[" -f2 | cut -d "]" -f1)
    
    xdg-open "${URL}" 2> /dev/null     

    exec i3-msg [class="^firefox"] focus
fi