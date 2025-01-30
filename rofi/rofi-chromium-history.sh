#!/usr/bin/env bash
db="$HOME/local/backups/History"

cp "$HOME/.config/chromium/Default/History" "$db"

HISTORY=$(sqlite3 "${db}" "${QUERY}")
history_cache="$HOME/local/cache/chromium_history.txt"

output() {
    printf '%s\n' "$*"
}

updateBookmarkCache() {
    query="select distinct u.url, u.title from urls as u where '' != u.title order by u.last_visit_time DESC"
}

outputHistory() {  
    query="select distinct u.url, u.title from urls as u where '' != u.title order by u.last_visit_time DESC"
    history=$(sqlite3 "${db}" "${query}" | awk -F '|' '{print $2, $1}' | tee "${history_cache}" )
    cat $history_cache
    output "$history"
}

if [[ -z "$@" ]]; then
   outputHistory 
else
    selected_url=$(echo "$@" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*")

    if ! [[ -z "$selected_url" ]]; then
        url=$selected_url
    else
        identifier="${@%% *}"
        search_query="${@#* }"

        case "$identifier" in
            "archwki" | "aw")
                showNotification "ArchWiki"
                setUrl "https://wiki.archlinux.org/index.php?search=" "$search_query"
                ;;
            "ultimateguitar" | "ug")
                showNotification "UltimateGuitar"
                setUrl "https://www.ultimate-guitar.com/search.php?search_type=title&value=" "$search_query"
                ;;
            "youtube" | "yt")
                showNotification "YouTube"
                setUrl "https://www.youtube.com/results?search_query=" "$search_query"
                ;;
            "github" | "gh")
                showNotification "Github"
                setUrl "https://github.com/search?q=" "$search_query"
                ;;
            "stackoverflow" | "sof" | "codehelp" | "stackoflow")
                showNotification "StackOverFlow"
                setUrl "https://stackoverflow.com/search?q=" "$search_query"
                ;;
            "wordpress" | "wp")
                showNotification "WordPress"
                setUrl 'https://developer.wordpress.org/?s=' "$search_query"
                ;;
            *)
                if ! [[ "$URL" == http* ]]; then
                    showNotification "Google"
                    setUrl "https://www.google.com/search?q=" "${@}"
                else
                    notify-send 'Firefox' "Opening: ${URL}"
                fi
                ;;
            esac

    fi

    coproc(chromium "$url") > /dev/null

    exec i3-msg [class="chromium" instance="Navigator"] focus > /dev/null
    exit 0;
fi