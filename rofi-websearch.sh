#!/usr/bin/env bash

ARCH_WIKI="https://wiki.archlinux.org/index.php?search="
GOOGLE="https://google.com/search?q="
ULTIMATE_GUTIAR="https://www.ultimate-guitar.com/search.php?search_type=title&value="
JQUERY="https://api.jquery.com/?s="

INPUT=$(rofi -dmenu -show -l 0 -i -p "Search")

if [ -n "$INPUT" ]; then
    IDENTIFIER=$( echo "$INPUT" | cut -f 1 -d ' ')
    QUERY=$( echo "$INPUT" | cut -f 1 -d ' ' --complement)

    case "$IDENTIFIER" in
        (aw)  URL="${ARCH_WIKI}${QUERY}";;
        (gg)  URL="${GOOGLE}${QUERY}";;
        (jq)  URL="${JQUERY}${QUERY}";;
        (ph)  URL="${PORNHUB}${QUERY}";;
        (ug)  URL="${ULTIMATE_GUTIAR}${QUERY}";;
        (*)   URL="${GOOGLE}${INPUT}";;
    esac

    xdg-open "$URL" 2> /dev/null
    exec i3-msg [class="^Chromium$"] focus
fi