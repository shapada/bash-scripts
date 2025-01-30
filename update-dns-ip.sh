#!/bin/sh

# Send updated dynamic IP address to Namecheap, in order to update subdomains.
# This uses curl (separate pkg) to send the change; Namecheap automatically detects source IP if the ip field (like domain, password) ..
# is not specified.

# info helper
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }

info "Starting IP update for subdomains"

curl "https://dynamicdns.park-your-domain.com/update?host=ambush&domain=shaundavis.xyz&password=46e44dd379324b7085658d49a429a35b"

info "IP update done"
