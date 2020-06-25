#!/usr/bin/env bash

source $HOME/local/bin/chromium-history-backup

DB="$HOME/local/backups/chromium-history.sqlite"
QUERY="select distinct u.url, u.title from urls as u where '' != u.title order by u.last_visit_time DESC"
HISTORY=$(sqlite3 "${DB}" "${QUERY}")

if [ -n "$HISTORY" ] ; then
    SELECTED=$( echo "$HISTORY" | awk --field-separator="|" '{print $2 " - [" $1 "]" }' | rofi -dmenu -i -p --font 'hack 16' "History" )
    URL=$(echo "$SELECTED" | cut -d "[" -f2 | cut -d "]" -f1)

    xdg-open $URL 2> /dev/null     
    exec i3-msg [class="Chromium"] focus
fi