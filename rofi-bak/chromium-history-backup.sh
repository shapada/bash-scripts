#!/usr/bin/env bash
HISTORY_DB="${HOME}/.config/chromium/Default/History"
BACKUPS_DIR="/home/sd/local/backups/"

cp "$HISTORY_DB" "${BACKUPS_DIR}/chromium-history.sqlite"