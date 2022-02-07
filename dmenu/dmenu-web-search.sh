#!/usr/bin/env bash

ARCH_WIKI="https://wiki.archlinux.org/index.php?search="
GOOGLE="https://google.com/search?q="
ULTIMATE_GUTIAR="https://www.ultimate-guitar.com/search.php?search_type=title&value="
JQUERY="https://api.jquery.com/?s="

SEARCH_HISTORY="$HOME/local/development/cache/dmenu-search-history.log"

INPUT=$(tac "$SEARCH_HISTORY" | dmenu -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=14' -p "Search")

if [ -n "$INPUT" ]; then

    echo "$INPUT" | tee -a "$SEARCH_HISTORY"

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
    i3-msg [class="firefox"] focus
fi
