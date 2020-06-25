#!/usr/bin/env bash

source $HOME/local/bin/firefox-backup

DB="$HOME/local/backups/places.sqlite"
QUERY="select distinct p.title, p.url from moz_places as p, moz_historyvisits as h, moz_bookmarks as b where substr(h.visit_date, 0, 11) >= strftime('%s', date('now') - 30) and p.id == h.place_id and p.title != '' order by h.visit_date DESC;"
HISTORY=$(sqlite3 "${DB}" "${QUERY}")

if [ -n "$HISTORY" ] ; then

    SELECTED=$( echo "$HISTORY" | awk --field-separator="|" '{print $1 " [" $2 "]" }' | rofi -dmenu -i -p "History" )
    URL=$(echo "$SELECTED" | cut -d "[" -f2 | cut -d "]" -f1)
    
    xdg-open "${URL}" 2> /dev/null     

    exec i3-msg [class="^firefox"] focus
fi