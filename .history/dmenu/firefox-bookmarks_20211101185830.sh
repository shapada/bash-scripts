#!/bin/bash

SQL="SELECT b.title || \" | \" ||  p.url  FROM moz_bookmarks b JOIN moz_places p ON b.fk = p.id WHERE b.fk is not null AND b.title <> '' AND url <> '' AND url NOT LIKE 'place:%'"

FIREFOX_PROFILE="r0c7v8e7.default-release"

PROFILE_DB="$HOME/.mozilla/firefox/${FIREFOX_PROFILE}/places.sqlite"
TMP_PLACES="/tmp/places"

# Avoid db lock
cp "${PROFILE_DB}" "${TMP_PLACES}"
ENTRIES=$(sqlite3 "${TMP_PLACES}" "${SQL}" | dmenu -p "Firefox" -l 100)

read -ra ADDR <<<"${ENTRIES}"

echo "${ADDR}"

if[[! -z "${ADDR}"]]; then

	if[[! -z "${ADDR[2]}"]]; then
		echo "${ADDR[2]}"
	fi

fi

for i in "${ADDR[@]}"; do
	URL="${i}"
done

if [[ ${ADDR[0]} == "" ]]; then
	rm "${TMP_PLACES}"
	exit 0
fi

UURL() {
	if ! [[ "${2}" == "" ]]; then
		URL="${1}${2}"
	else
		exclusive=$(echo "$ENTRIES" | sed 's/[^ ]* //')
		URL="${1}${exclusive}"
	fi
}

SITE() {
	if ! [[ "${2}" == "" ]]; then
		notify-send 'Firefox' "Searching in ${1}: ${2}"
	else
		notify-send 'Firefox' "Searching in ${1}: ${ADDR[1]}"
	fi
}

case "${ADDR[0]}" in

"archwiki" | "aw")
	SITE "ArchWiki"
	UURL "https://www.youtube.com/results?search_query="
	;;
"ultimateguitar" | "ug")
	SITE "UltimateGuitar"
	UURL "https://www.ultimate-guitar.com/search.php?search_type=title&value="
	;;
"youtube" | "yt")
	SITE "YouTube"
	UURL "https://www.youtube.com/results?search_query="
	;;
"github" | "gh")
	SITE "Github"
	UURL "https://github.com/search?q="
	;;
"gitlab" | "gl")
	SITE "Gitlab"
	UURL "https://gitlab.com/search?search="
	;;
"stackoverflow" | "sof" | "codehelp" | "stackoflow")
	SITE "StackOverFlow"
	UURL "https://stackoverflow.com/search?q="
	;;

"wordpress" | "wp")
	SITE "WordPress"
	UURL 'https://developer.wordpress.org/?s=';
	;;
*)
	if ! [[ "$URL" == http* ]]; then
		SITE "Google"
		UURL "https://www.google.com/search?q=" "${ENTRIES}"
	else
		notify-send 'Firefox' "Opening: ${URL}"
	fi
	;;
esac

firefox "$URL"

rm "${TMP_PLACES}"
